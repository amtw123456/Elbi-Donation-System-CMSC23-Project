import 'package:elbi_donation_app/screens/admin/admin_router.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_app/views/user_home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: AdminRouter(),
    );
  }
}
