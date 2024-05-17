import 'package:elbi_donation_app/views/admin_views/admin_router.dart';
import 'package:elbi_donation_app/views/auth_views/landing.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_app/views/user_views/user_home_page.dart';

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
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Color(0xFF37A980)
          ),
          useMaterial3: true,
        ),
        home: const LandingPage());
  }
}
