import 'package:elbi_donation_app/views/auth_views/landing.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class UserProfile extends StatefulWidget {
  const UserProfile({super.key});

  @override
  State<UserProfile> createState() => UserProfileState();
}

class UserProfileState extends State<UserProfile> {
  final List<String> _savedAddresses = ["Address 1", "Address 2", "Address 3"];

  final TextEditingController _addressController = TextEditingController();
  bool _isLoading = false;

  File? _selectedImage;

  XFile? file;
  String imageUrl = '';

  late TextEditingController contactNumberController = TextEditingController();
  late TextEditingController descriptionController = TextEditingController();

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
              context
                  .read<UserProvider>()
                  .getUserModel(userId!)
                  .then((userDetails) {
                OpenEditDialog(
                    userId,
                    userDetails['userModel'].contactNumber,
                    userDetails['userModel'].orgDescription,
                    userDetails['userModel'].proofOfLegitimacyImageUrlLink);
              });
            },
            child: const Icon(Icons.edit),
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
              const SizedBox(height: 1),
              FutureBuilder<Map<String, dynamic>>(
                future: context.read<UserProvider>().getUserModel(userId!),
                builder: (BuildContext context,
                    AsyncSnapshot<Map<String, dynamic>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.hasData) {
                    final userInformation = snapshot.data!['userModel'];

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          // TODO: Replace default picture
                                          userInformation
                                                      .proofOfLegitimacyImageUrlLink ==
                                                  ''
                                              ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                                              : userInformation
                                                  .proofOfLegitimacyImageUrlLink)),
                                  color: Colors.red),
                            ),
                          ],
                        ),
                        // FOR NAME
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              userInformation.username,
                              style: const TextStyle(
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
                            style:
                                TextStyle(fontFamily: "Poppins", fontSize: 16)),
                        Container(
                          width: double.infinity,
                          height: 200,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                const BorderRadius.all(Radius.circular(5)),
                            border: Border.all(color: Colors.grey, width: 1.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(15),
                            child: userInformation.orgDescription == null
                                ? const Text('No biography available')
                                : Text(
                                    userInformation.orgDescription,
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
                    return const Text('No data available');
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> OpenEditDialog(String userId, String contactNumber,
          String? description, String imageUrl) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          final formKey = GlobalKey<FormState>();
          final screenHeight = MediaQuery.of(context).size.height;
          final contactNumberController =
              TextEditingController(text: contactNumber);
          final descriptionController =
              TextEditingController(text: description ?? '');
          return SingleChildScrollView(
            child: Container(
              height: screenHeight * 0.8,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.0),
                  topRight: Radius.circular(25.0),
                ),
              ),
              child: Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Edit your details',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Edit profile picture'),
                                    content: SingleChildScrollView(
                                      child: Column(children: [
                                        ElevatedButton(
                                            onPressed: () async {
                                              if (await Permission.storage
                                                  .request()
                                                  .isGranted) {
                                                // _pickImageFromGallery();
                                                file = await ImagePicker()
                                                    .pickImage(
                                                        source: ImageSource
                                                            .gallery);
                                                setState(() {});
                                              } else {
                                                // Permission is not granted. Handle the scenario accordingly.
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "storage Permission Required"),
                                                      content: const Text(
                                                          "Please grant stroage permission in settings to enable storage access."),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                          child: const Text(
                                                              "CANCEL"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child: const Text(
                                                              "SETTINGS"),
                                                          onPressed: () {
                                                            openAppSettings(); // This will open the app settings where the user can enable permissions.
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: const Text('Upload photo')),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                            onPressed: () async {
                                              if (await Permission.camera
                                                  .request()
                                                  .isGranted) {
                                                file = await ImagePicker()
                                                    .pickImage(
                                                        source:
                                                            ImageSource.camera);
                                                setState(() {});
                                              } else {
                                                // Permission is not granted. Handle the scenario accordingly.
                                                showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      title: const Text(
                                                          "Camera Permission Required"),
                                                      content: const Text(
                                                          "Please grant camera permission in settings to enable camera access."),
                                                      actions: <Widget>[
                                                        ElevatedButton(
                                                          child: const Text(
                                                              "CANCEL"),
                                                          onPressed: () {
                                                            Navigator.of(
                                                                    context)
                                                                .pop();
                                                          },
                                                        ),
                                                        ElevatedButton(
                                                          child: const Text(
                                                              "SETTINGS"),
                                                          onPressed: () {
                                                            openAppSettings(); // This will open the app settings where the user can enable permissions.
                                                          },
                                                        ),
                                                      ],
                                                    );
                                                  },
                                                );
                                              }
                                            },
                                            child: const Text('Open camera')),
                                      ]),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Close'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                          // TODO: Replace default picture
                                          imageUrl == ''
                                              ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                                              : imageUrl)),
                                  color: Colors.red),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: contactNumberController,
                          decoration: const InputDecoration(
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
                            if (value.length != 11) {
                              return 'Contact number must be of length 11';
                            }
                            return null;
                          }),
                      const SizedBox(height: 20),
                      TextFormField(
                          controller: descriptionController,
                          maxLines: 7,
                          decoration: const InputDecoration(
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
                      const Spacer(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.all(10),
                                  backgroundColor: Colors.red[600],
                                  shape: const RoundedRectangleBorder(
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
                          const SizedBox(
                            width: 5,
                          ),
                          Expanded(
                            child: SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    backgroundColor: const Color(0xFF37A980),
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(5)),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (formKey.currentState!.validate()) {
                                      try {
                                        setState(() {
                                          _isLoading = true;
                                        });

                                        Map<String, dynamic> updates = {
                                          "contactNumber":
                                              contactNumberController.text,
                                          "orgDescription":
                                              descriptionController.text
                                        };

                                        if (context.mounted) {
                                          final result = await context
                                              .read<UserProvider>()
                                              .updateUserModel(userId, updates);
                                          if (!result['success']) {
                                            throw result['error'];
                                          }
                                        }

                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(const SnackBar(
                                            content: Text('Profile edited'),
                                            backgroundColor: Colors.green,
                                          ));
                                        }

                                        if (context.mounted) {
                                          Navigator.pop(context);
                                        }
                                      } catch (error) {
                                        if (context.mounted) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(error.toString()),
                                            backgroundColor: Colors.red,
                                          ));
                                        }

                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }
                                    }
                                  },
                                  child: _isLoading
                                      ? Container(
                                          width: 20,
                                          height: 20,
                                          padding: const EdgeInsets.all(4),
                                          child:
                                              const CircularProgressIndicator(
                                            color: Colors.white,
                                            strokeWidth: 2,
                                          ),
                                        )
                                      : const Text('Confirm',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontFamily: "Poppins"))),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
}
