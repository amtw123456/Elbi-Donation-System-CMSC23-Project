import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const Expanded(
              child: Column(
            children: [Text('elBigay'), Text('Make a difference. Together')],
          )),
          TextButton(onPressed: () {}, child: const Text('Get Started')),
          TextButton(
              onPressed: () {}, child: const Text('I already have an account')),
        ],
      ),
    );
  }
}
