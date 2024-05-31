import 'package:flutter/material.dart';

class OrgNavbar extends StatefulWidget {
  final ValueChanged<int> onItemTapped;
  final int selectedIndex;

  const OrgNavbar({
    Key? key,
    required this.onItemTapped,
    required this.selectedIndex,
  }) : super(key: key);

  @override
  State<OrgNavbar> createState() => _OrgNavbarState();
}

class _OrgNavbarState extends State<OrgNavbar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      selectedItemColor: Color(0xFF37A980),
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.volunteer_activism_rounded),
          label: 'Donations',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.card_giftcard_rounded),
          label: 'Drives',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'QR',
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
