import 'package:elbi_donation_app/components/user_navbar.dart';
import 'package:elbi_donation_app/views/user_views/user_donation_history_page.dart';
import 'package:elbi_donation_app/views/user_views/user_home_page.dart';
import 'package:elbi_donation_app/views/user_views/user_profile_page.dart';
import 'package:flutter/material.dart';

class UserRouter extends StatefulWidget {
  const UserRouter({Key? key});

  @override
  State<UserRouter> createState() => _UserRouterState();
}

class _UserRouterState extends State<UserRouter> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Use Navigator to navigate to different screens
    switch (index) {
      case 0:
        // Navigator.pushNamed(context, '/admin/organizations');
        break;
      case 1:
        // Navigator.pushNamed(context, '/admin/donors');
        break;
      case 2:
        // Navigator.pushNamed(context, '/admin/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildPage(),
      bottomNavigationBar: UserNavbar(
        onItemTapped: _onItemTapped, // Pass the callback to the adminNavBar
        selectedIndex: _selectedIndex, // Pass the selectedIndex to the adminNavBar
      ),
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const UserHomePage();
      case 1:
        return const UserDonationHistory();
      case 2:
        return const UserProfile();
      default:
        return const SizedBox.shrink();
    }
  }
}
