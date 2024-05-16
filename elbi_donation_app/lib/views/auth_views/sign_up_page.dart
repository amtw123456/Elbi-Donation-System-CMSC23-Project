import 'package:flutter/material.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        child: Column(
          children: [
            const Text('Help us get to know you'),
            const Text('Create your account so you can start donating.'),
            const Text('Personal'),
            TextFormField(
              decoration: const InputDecoration(hintText: 'First name'),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Last name'),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Username'),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Email'),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Address'),
            ),
            TextFormField(
              decoration: const InputDecoration(hintText: 'Contact number'),
            ),
            FilledButton(onPressed: () {}, child: const Text('Sign up')),
            Row(
              children: [
                const Text('Want to sign up as an organization?'),
                TextButton(onPressed: () {}, child: const Text('Sign up'))
              ],
            )
          ],
        ),
      ),
    ));
  }
}
