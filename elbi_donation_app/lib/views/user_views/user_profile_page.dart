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
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
         actions: [
          TextButton(
            onPressed: () {
              context.read<UserProvider>().getUserModel(userId!).then((userDetails) {
                OpenEditDialog(
                  userId, userDetails['userModel'].contactNumber, userDetails['userModel'].orgDescription
                );
              });
            },
            child: Icon(Icons.edit),
          ),
        ],
      ),
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
                        const Text("Bio",
                          style: TextStyle(fontFamily: "Poppins", fontSize: 16)),
                        Container(
                          width: double.infinity,
                          height: 200,
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: userInformation.orgDescription == null
                            ? Text('') 
                            : Text(
                              userInformation.orgDescription,
                              style: const TextStyle(
                                  fontFamily: "Poppins", fontSize: 16),
                            ),
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey, width: 1.0),
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
                          itemCount: userInformation.address.length,
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
                                  userInformation.address[index],
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
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              // backgroundColor: Colors.red,
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
                                      fontSize: 16,
                                      color: Colors.red,
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

  Future<void> OpenEditDialog(String userId, String contactNumber, String? description) => 
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          final _formKey = GlobalKey<FormState>();
          final screenHeight = MediaQuery.of(context).size.height;
          final contactNumberController = TextEditingController(text: contactNumber);
          final descriptionController =
              TextEditingController(text: description == null ? '' : description);
          return Container(
              height: screenHeight * 0.75,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Form(
                key: _formKey,
                child: Padding(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit your details',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          controller: contactNumberController,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a contact number';
                            }
                            return null;
                          }),
                      SizedBox(height: 20),
                      TextFormField(
                          controller: descriptionController,
                          maxLines: 7,
                          decoration: InputDecoration(
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(4)),
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your bio';
                            }
                            return null;
                          }),
                      Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  backgroundColor: Colors.red[600],
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onPressed: () {
                                    Navigator.pop(context);
                                },
                                child: const Text(
                                  'Cancel',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(10),
                                  backgroundColor: Color(0xFF37A980),
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(5)),
                                  ),
                                ),
                                onPressed: () async {
                                  if (_formKey.currentState!.validate()) {
                                    print(contactNumberController.text);
                                    print(descriptionController.text);
                                    Map <String, dynamic> updates = {
                                      "contactNumber": contactNumberController.text,
                                      "orgDescription": descriptionController.text
                                    };
                                    final result = await context.read<UserProvider>().updateUserModel(
                                      userId, updates
                                    );
                                    print(result);
                                    Navigator.pop(context);
                                  }
                                },
                                child: const Text(
                                  'Confirm',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 20),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ));
        },
      );
}
