import 'package:elbi_donation_app/views/auth_views/sign_up_legit_page.dart';
import 'package:flutter/material.dart';

class SignUpDonorPage extends StatelessWidget {
  const SignUpDonorPage({super.key});

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
                const SizedBox(
                  height: 48,
                ),
                SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                        onPressed: () {}, child: const Text('Sign up'))),
                Row(
                  children: [
                    const Text('Want to sign up as an organization?'),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => const SignUpOrgPage()));
                        },
                        child: const Text('Sign up'))
                  ],
                )
              ],
            ),
          ),
        ));
  }
}
