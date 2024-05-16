import 'package:elbi_donation_app/screens/admin/admin_nav_bar.dart';
import 'package:flutter/material.dart';

import 'admin_donors_page.dart';
import 'admin_organization_page.dart';

class AdminRouter extends StatefulWidget {
  const AdminRouter({Key? key});

  @override
  State<AdminRouter> createState() => _AdminRouterState();
}

class _AdminRouterState extends State<AdminRouter> {
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
      bottomNavigationBar: AdminNavBar(
        onItemTapped: _onItemTapped, // Pass the callback to the adminNavBar
        selectedIndex: _selectedIndex, // Pass the selectedIndex to the adminNavBar
      ),
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const AdminOrganizationPage();
      case 1:
        return const AdminDonorsPage();
      case 2:
        // return const AdminProfilePage();
      default:
        return const SizedBox.shrink();
    }
  }
}
