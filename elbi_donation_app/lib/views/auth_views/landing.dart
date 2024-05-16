import 'package:elbi_donation_app/views/auth_views/login_page.dart';
import 'package:elbi_donation_app/views/auth_views/sign_up_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: const Color(0xff35aa80),
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'elBigay',
                    style: TextStyle(fontSize: 48, color: Colors.white),
                  ),
                  Text(
                    'Make a difference. Together.',
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  )
                ],
              ),
            )),
            FilledButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignUpDonorPage()));
                },
                child: const Text(
                  'Get Started',
                )),
            OutlinedButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const LoginPage()));
                },
                child: const Text(
                  'I already have an account',
                )),
          ],
        ),
      ),
    );
  }
}
