import 'package:flutter/material.dart';

class SignUpLegitPage extends StatelessWidget {
  const SignUpLegitPage({super.key});

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
                  'Help us get to know you',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Text('Create your account so you can start donating.'),
                const SizedBox(
                  height: 48,
                ),
                const Text(
                  'Personal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextFormField(
                  decoration:
                      const InputDecoration(hintText: 'Name of organization'),
                ),
                const SizedBox(
                  height: 48,
                ),
                const Text(
                  'Proof of legitimacy',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                IconButton.outlined(
                    onPressed: () {}, icon: const Icon(Icons.add)),
                const SizedBox(
                  height: 48,
                ),
                SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {}, child: const Text('Sign up'))),
              ],
            ),
          ),
        ));
  }
}
