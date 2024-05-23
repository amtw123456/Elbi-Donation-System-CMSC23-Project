import 'package:elbi_donation_app/models/user_model.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/views/admin_views/admin_profile.dart';
import 'package:elbi_donation_app/views/org_views/org_home_page.dart';
import 'package:elbi_donation_app/views/user_views/user_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';

import 'package:elbi_donation_app/views/auth_views/landing.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Stream<User?> userStream = context.watch<UserAuthProvider>().userStream;

    return StreamBuilder(
        stream: userStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Scaffold(
              body: Center(
                child: Text("Error encountered! ${snapshot.error}"),
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (!snapshot.hasData) {
            return const LandingPage();
          } else {
            // first fetch the information of the user before doing the user router
            final id = snapshot.data!.uid;
            final future = context.read<UserProvider>().getUserModel(id);
            // then return the helper here
            return NavigationHelper(future: future);
          }
          // return const UserRouter();
        });
  }
}

// navigates depending on the type of the user

class NavigationHelper extends StatelessWidget {
  const NavigationHelper({super.key, required this.future});

  final Future<Map<String, dynamic>> future; // pass the future here

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: future,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data!['success']) {
              // then route depending on user type
              UserModel userModel = snapshot.data!['userModel'];
              if (userModel.type == 'org') {
                return const OrgHomePage();
              } else if (userModel.type == 'donor') {
                return const UserHomePage();
              } else if (userModel.type == 'admin') {
                return const AdminProfile();
              } else {
                return const Center(
                  child: Text('Routing error.'),
                );
              }
            } else {
              return Center(
                child: Text(snapshot.data!['error']),
              );
            }
          } else {
            return const Center(
              child: Text(
                  'Error: Firebase Auth and Cloud Firestore inconsistency.'),
            );
          }
        });
  }
}
