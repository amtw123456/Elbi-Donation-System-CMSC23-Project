import 'package:elbi_donation_app/views/auth_views/landing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';

class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => AdminProfileState();
}

class AdminProfileState extends State<AdminProfile> {
  @override
  bool _isLoading = false;
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xFFF8F8F8),
        body: SingleChildScrollView(
            child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Username",
                  style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF37A980)),
                ),
              ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // FOR NAME
                  Text("Name",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      child: Text(
                        "First name Last name",
                        style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Email",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      child: Text(
                        "Email@email.com",
                        style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Contact number",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
                  Container(
                    width: double.infinity,
                    child: Padding(
                      child: Text(
                        "1234567890",
                        style: TextStyle(fontFamily: "Poppins", fontSize: 16),
                      ),
                      padding: EdgeInsets.all(15),
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                      border: Border.all(color: Colors.grey, width: 1.0),
                    ),
                  ),
                  SizedBox(height: 10),
                  Text("Saved addresses",
                      style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
                  // TODO: Iterate over addresses
                  ListView.separated(
                    separatorBuilder: (BuildContext context, int index) =>
                        SizedBox(height: 10),
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        child: Padding(
                          child: Text(
                            "Address here",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 16),
                          ),
                          padding: EdgeInsets.all(15),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(5)),
                          border: Border.all(color: Colors.grey, width: 1.0),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              )),
                          onPressed: () async {
                            try {
                              // start loading
                              setState(() {
                                _isLoading = true;
                              });
                              final result = await context
                                  .read<UserAuthProvider>()
                                  .signOut();
                              if (!result['success']) {
                                throw result['error'];
                              }

                              if (context.mounted) {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) => const LandingPage()));
                              }

                              // end loading
                              setState(() {
                                _isLoading = false;
                              });
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                  backgroundColor: Colors.red,
                                ));
                              }

                              setState(() {
                                _isLoading = false;
                              });
                            }
                          },
                          child: const Text('Log out',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 20)))),
                ],
              )
            ],
          ),
        )));
  }
}
