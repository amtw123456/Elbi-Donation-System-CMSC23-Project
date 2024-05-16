import 'package:flutter/material.dart';

class AdminNavBar extends StatefulWidget {
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  const AdminNavBar({
    Key? key,
    required this.onItemTapped,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<AdminNavBar> createState() => _AdminNavBarState();
}

class _AdminNavBarState extends State<AdminNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Color(0xFF37A980),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Organization',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.favorite),
          label: 'Donors',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Profile',
        ),
      ],
      currentIndex: widget.selectedIndex,
      onTap: widget.onItemTapped, // Use widget.onItemTapped here
    );
  }
}
