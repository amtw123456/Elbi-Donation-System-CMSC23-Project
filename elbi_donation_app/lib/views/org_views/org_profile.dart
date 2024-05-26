import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/views/auth_views/landing.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({super.key});

  @override
  State<OrgProfile> createState() => OrgProfileState();
}

class OrgProfileState extends State<OrgProfile> {
  String statusForDonation = "Open";
  List<String> statusesForDonation = ['Open', 'Close'];

  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserAuthProvider>().user?.uid;
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: FutureBuilder<Map<String, dynamic>>(
        future: context.read<UserProvider>().getUserModel(userId!),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final userInformation = snapshot.data!['userModel'];
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 35),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          userInformation.orgName,
                          style: TextStyle(
                            fontFamily: "Poppins",
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF37A980),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Text("Status for donation",
                            style: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF37A980),
                                fontSize: 16)),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            // hintText: 'Pe',
                            // hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          value: statusForDonation,
                          onChanged: (String? newValue) {
                            setState(() {
                              statusForDonation = newValue!;
                            });
                          },
                          items: statusesForDonation.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status,
                                  style: TextStyle(fontFamily: 'Poppins')),
                            );
                          }).toList(),
                        ),
                      ],
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
                                      builder: (context) =>
                                          const LandingPage()));
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
                            child: _isLoading
                                ? Container(
                                    width: 20,
                                    height: 20,
                                    padding: const EdgeInsets.all(4),
                                    child: const CircularProgressIndicator(
                                      color: Colors.white,
                                      strokeWidth: 2,
                                    ),
                                  )
                                : const Text('Log out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins",
                                        fontSize: 20)))),
                  ],
                ),
              ),
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
