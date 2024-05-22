import 'package:elbi_donation_app/views/auth_views/sign_up_donor_page.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
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
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: emailController,
                      validator: ValidationBuilder().email().build(),
                      decoration: const InputDecoration(
                        hintText: 'Email',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      validator: ValidationBuilder().minLength(8).build(),
                      decoration: const InputDecoration(
                        hintText: 'Password',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Don\'t have an account yet?'),
                      TextButton(
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => const SignUpDonorPage()));
                          },
                          child: const Text('Sign up'))
                    ],
                  ),
                  const SizedBox(
                    height: 48,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(20),
                              backgroundColor: const Color(0xFF37A980),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2),
                              )),
                          onPressed: () async {
                            // TODO: add verification if the login is successful
                            await context.read<UserAuthProvider>().signIn(
                                emailController.text, passwordController.text);
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content:
                                          Text('Successfully logged in!')));
                            }
                          },
                          child: const Text('Login',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins")))),
                ],
              ),
            ),
          ),
        ));
  }
}
