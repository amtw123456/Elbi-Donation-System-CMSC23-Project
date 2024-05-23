import 'package:elbi_donation_app/components/navigation_helper.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
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
