import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome back',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Text('Login to continue'),
                const SizedBox(
                  height: 48,
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Email'),
                ),
                TextFormField(
                  decoration: const InputDecoration(hintText: 'Password'),
                ),
                Row(
                  children: [
                    const Text('Don\'t have an account yet?'),
                    TextButton(onPressed: () {}, child: const Text('Sign up'))
                  ],
                ),
                const SizedBox(
                  height: 48,
                ),
                SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {}, child: const Text('Login'))),
              ],
            ),
          ),
        ));
  }
}
