import 'package:flutter/material.dart';

class adminNavBar extends StatefulWidget {
  const adminNavBar({super.key});

  @override
  State<adminNavBar> createState() => _adminNavBarState();
}

class _adminNavBarState extends State<adminNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Organization'
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Donors' 
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile'
        )
      ] 
    );
  }
}