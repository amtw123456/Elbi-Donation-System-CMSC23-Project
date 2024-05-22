import 'package:elbi_donation_app/views/org_views/org_drives_page.dart';
import 'package:elbi_donation_app/views/org_views/org_home_page.dart';
import 'package:elbi_donation_app/views/org_views/org_profile.dart';
import 'package:flutter/material.dart';

import '../../components/org_navbar.dart';

class OrgRouter extends StatefulWidget {
  const OrgRouter({Key? key});

  @override
  State<OrgRouter> createState() => _UserRouterState();
}

class _UserRouterState extends State<OrgRouter> {
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
      bottomNavigationBar: OrgNavbar(
        onItemTapped: _onItemTapped, // Pass the callback to the adminNavBar
        selectedIndex: _selectedIndex, // Pass the selectedIndex to the adminNavBar
      ),
    );
  }

  Widget _buildPage() {
    switch (_selectedIndex) {
      case 0:
        return const OrgHomePage();
      case 1:
        return const OrgDonationDrivePage();
      case 2:
        return const OrgProfile();
      default:
        return const SizedBox.shrink();
    }
  }
}
