import 'package:elbi_donation_app/views/auth_views/sign_up_org_page.dart';
import 'package:flutter/material.dart';

class SignUpDonorPage extends StatefulWidget {
  const SignUpDonorPage({super.key});

  @override
  _SignUpDonorPageState createState() => _SignUpDonorPageState();
}

class _SignUpDonorPageState extends State<SignUpDonorPage> {
  bool _showAdditionalFields = false;

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
                const SizedBox(height: 20,),
                const Text(
                  'Personal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                      hintText: 'First name',
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
                    decoration: const InputDecoration(
                      hintText: 'Last name',
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
                    decoration: const InputDecoration(
                      hintText: 'Username',
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
                    decoration: const InputDecoration(
                      hintText: 'Address',
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
                    decoration: const InputDecoration(
                      hintText: 'Contact number',
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text('Want to sign up as an organization?'),
                  value: _showAdditionalFields,
                  onChanged: (bool? value) {
                    setState(() {
                      _showAdditionalFields = value ?? false;
                    });
                  },
                ),
                SizedBox(height: 20),
                if (_showAdditionalFields) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      decoration: const InputDecoration(
                        hintText: 'Organization name',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  const Text(
                    'Please provide a proof of legitimacy',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  IconButton.outlined(
                    onPressed: () {}, icon: const Icon(Icons.add)
                  ),
                  SizedBox(height: 20),
                ],
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.all(20),
                        backgroundColor: Color(0xFF37A980),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(2),
                        )
                      ), 
                      onPressed: () {}, 
                      child: const Text('Sign up', style: TextStyle(color: Colors.white, fontFamily: "Poppins"),))),
                const SizedBox(height: 20,),

              ],
            ),
          ),
        ));
  }
}
