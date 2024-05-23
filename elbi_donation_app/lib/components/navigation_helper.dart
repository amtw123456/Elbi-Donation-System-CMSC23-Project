// navigates depending on the type of the user

import 'package:elbi_donation_app/models/user_model.dart';
import 'package:elbi_donation_app/views/admin_views/admin_profile.dart';
import 'package:elbi_donation_app/views/org_views/org_home_page.dart';
import 'package:elbi_donation_app/views/user_views/user_home_page.dart';
import 'package:elbi_donation_app/views/user_views/user_router.dart';
import 'package:flutter/material.dart';

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
                return const UserRouter();
              } else if (userModel.type == 'admin') {
                return const AdminProfile();
              } else {
                return const Scaffold(
                  body: Center(
                    child: Text('Routing error.'),
                  ),
                );
              }
            } else {
              return Scaffold(
                body: Center(
                  child: Text(snapshot.data!['error']),
                ),
              );
            }
          } else {
            return const Scaffold(
              body: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
        });
  }
}
