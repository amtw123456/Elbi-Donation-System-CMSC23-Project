import 'package:elbi_donation_app/views/auth_views/landing.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  final List<String> _savedAddresses = ["Address 1", "Address 2", "Address 3"];

  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;

  void _showAddAddressDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Add Address"),
          content: TextField(
            controller: _addressController,
            decoration: const InputDecoration(hintText: "Enter address"),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text("Add"),
              onPressed: () {
                setState(() {
                  _savedAddresses.add(_addressController.text);
                  _addressController.clear();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserAuthProvider>().user?.uid;
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 35),
              FutureBuilder<Map<String, dynamic>>(
                future: context.read<UserProvider>().getUserModel(userId!),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final userInformation = snapshot.data!['userModel'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // FOR NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userInformation.username,
                              style: TextStyle(
                                fontFamily: "Poppins",
                                fontSize: 32,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF37A980),
                              ),
                            ),
                          ],
                        ),
                        const Text("Name",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 16)),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              userInformation.firstName +
                                  " " +
                                  userInformation.lastName,
                              style: const TextStyle(
                                  fontFamily: "Poppins", fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Email",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 16)),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              userInformation.email,
                              style: const TextStyle(
                                  fontFamily: "Poppins", fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Contact number",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 16)),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: Text(
                              userInformation.contactNumber,
                              style: const TextStyle(
                                  fontFamily: "Poppins", fontSize: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        const Text("Saved addresses",
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 16)),
                        // Iterate over addresses
                        ListView.separated(
                          padding: EdgeInsets.zero,
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(height: 10),
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: _savedAddresses.length,
                          itemBuilder: (context, index) {
                            return Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius:
                                    const BorderRadius.all(Radius.circular(5)),
                                border:
                                    Border.all(color: Colors.grey, width: 1.0),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  _savedAddresses[index],
                                  style: const TextStyle(
                                      fontFamily: "Poppins", fontSize: 16),
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.grey,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            onPressed: _showAddAddressDialog,
                            child: const Text(
                              'Add another address',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: "Poppins",
                                  fontSize: 20),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.red,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
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
                                : const Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins"),
                                  ),
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Text('No data available');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
