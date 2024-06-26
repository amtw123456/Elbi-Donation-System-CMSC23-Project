import 'package:elbi_donation_app/views/auth_views/login_page.dart';
import 'package:elbi_donation_app/views/auth_views/sign_up_donor_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(36),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('images/landing_bg.png'), fit: BoxFit.cover)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Expanded(
                child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text.rich(TextSpan(children: [
                    TextSpan(
                        text: 'el',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Poppins")),
                    TextSpan(
                        text: 'Bigay',
                        style: TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: "Poppins"))
                  ])),
                  Text(
                    'Make a difference. Together.',
                    style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontFamily: "Poppins"),
                  )
                ],
              ),
            )),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: FilledButton(
                  style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const SignUpDonorPage()));
                  },
                  child: const Text('Get Started',
                      style: TextStyle(
                          color: Color(0xff4cba8b), fontFamily: "Poppins"))),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              width: double.infinity,
              child: OutlinedButton(
                  style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4))),
                  onPressed: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => LoginPage()));
                  },
                  child: const Text(
                    'I already have an account',
                    style:
                        TextStyle(color: Colors.white, fontFamily: "Poppins"),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}
