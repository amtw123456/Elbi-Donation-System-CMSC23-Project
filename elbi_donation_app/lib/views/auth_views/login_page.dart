import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final _formKey = GlobalKey<FormState>();

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
                      TextButton(onPressed: () {}, child: const Text('Sign up'))
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
                          onPressed: () {},
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
