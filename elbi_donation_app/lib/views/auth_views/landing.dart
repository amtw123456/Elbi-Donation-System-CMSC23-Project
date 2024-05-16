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
                onPressed: () {},
                child: const Text(
                  'Get Started',
                )),
            OutlinedButton(
                onPressed: () {},
                child: const Text(
                  'I already have an account',
                )),
          ],
        ),
      ),
    );
  }
}
