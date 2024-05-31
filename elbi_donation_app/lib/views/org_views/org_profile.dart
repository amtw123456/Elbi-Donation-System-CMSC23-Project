import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/views/auth_views/landing.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

class OrgProfile extends StatefulWidget {
  const OrgProfile({super.key});

  @override
  State<OrgProfile> createState() => OrgProfileState();
}

class OrgProfileState extends State<OrgProfile> {
  String statusForDonation = "Open";
  List<String> statusesForDonation = ['Open', 'Close'];

  bool _isLoading = false;
  bool _editing = false;

  File? _selectedImage;

  XFile? file;
  String imageUrl = '';

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserAuthProvider>().user?.uid;

    if (userId == null) {
      return Container();
    } else {
      return Scaffold(
         appBar: AppBar(
        backgroundColor: const Color(0xFFF8F8F8),
         actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _editing = !_editing;
              });
            },
            child: Icon(Icons.edit),
          ),
        ],
      ),
        backgroundColor: Color(0xFFF8F8F8),
        body: FutureBuilder<Map<String, dynamic>>(
          future: context.read<UserProvider>().getUserModel(userId),
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
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 35),
                      // PROFILE IMAGE
                      _editing
                      ? GestureDetector(
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
                              userInformation.proofOfLegitimacyImageUrlLink == ''
                              ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                              : userInformation.proofOfLegitimacyImageUrlLink
                            )
                          ),
                          color: Colors.red
                        ),
                      ),
                      )
                      : Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                              // TODO: Replace default picture
                              userInformation.proofOfLegitimacyImageUrlLink == ''
                              ? 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_960_720.png'
                              : userInformation.proofOfLegitimacyImageUrlLink
                            )
                          ),
                          color: Colors.red
                        ),
                      ),
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
                          _editing ? 
                          DropdownButtonFormField<String>(
                            decoration: InputDecoration(
                              // hintText: 'Pe',
                              // hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Color(0XFFD2D2D2)),
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
                          ) : Container(
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
                              // TODO: Org status
                              'Open',
                              style: const TextStyle(
                                  fontFamily: "Poppins", fontSize: 16),
                            ),
                          ),
                        ),
                          SizedBox(
                            height: 10,
                          ),
                      //     const Text(
                      //       'Upload Organization Cover Photo',
                      //       style: TextStyle(fontFamily: 'Poppins'),
                      //     ),
                      //     SizedBox(
                      //       height: 10,
                      //     ),
                      //     // UPLOAD IMAGE
                      //     SizedBox(
                      //       width: double.infinity,
                      //       height: 150,
                      //       child: _selectedImage != null
                      //           ? Image.file(_selectedImage!)
                      //           : ElevatedButton(
                      //               onPressed: () async {
                      //                 if (await Permission.storage
                      //                     .request()
                      //                     .isGranted) {
                      //                   // _pickImageFromGallery();
                      //                   file = await ImagePicker().pickImage(
                      //                       source: ImageSource.gallery);
                      //                   setState(() {});
                      //                 } else {
                      //                   // Permission is not granted. Handle the scenario accordingly.
                      //                   showDialog(
                      //                     context: context,
                      //                     builder: (BuildContext context) {
                      //                       return AlertDialog(
                      //                         title: Text(
                      //                             "storage Permission Required"),
                      //                         content: Text(
                      //                             "Please grant stroage permission in settings to enable storage access."),
                      //                         actions: <Widget>[
                      //                           ElevatedButton(
                      //                             child: Text("CANCEL"),
                      //                             onPressed: () {
                      //                               Navigator.of(context).pop();
                      //                             },
                      //                           ),
                      //                           ElevatedButton(
                      //                             child: Text("SETTINGS"),
                      //                             onPressed: () {
                      //                               openAppSettings(); // This will open the app settings where the user can enable permissions.
                      //                             },
                      //                           ),
                      //                         ],
                      //                       );
                      //                     },
                      //                   );
                      //                 }
                      //               },
                      //               child: Center(
                      //                 child: Column(
                      //                   mainAxisAlignment: MainAxisAlignment
                      //                       .center, // Center the contents vertically
                      //                   children: [
                      //                     Icon(Icons.photo_library,
                      //                         size: 40,
                      //                         color: Colors.grey[
                      //                             500]), // Adjust size and color as needed
                      //                     SizedBox(
                      //                         height:
                      //                             10), // Add some space between the icon and the text
                      //                     Text(
                      //                       "Upload photo",
                      //                       style: TextStyle(
                      //                           color: Colors.grey[500],
                      //                           fontSize: 16,
                      //                           fontFamily:
                      //                               'Poppins'), // Adjust text style as needed
                      //                     ),
                      //                   ],
                      //                 ),
                      //               ),
                      //               style: ElevatedButton.styleFrom(
                      //                 elevation: 0,
                      //                 padding: const EdgeInsets.all(20),
                      //                 backgroundColor: Colors.grey[50],
                      //                 shape: RoundedRectangleBorder(
                      //                   borderRadius: BorderRadius.circular(20),
                      //                   side: BorderSide(
                      //                       color: const Color(0xFF37A980),
                      //                       width: 2),
                      //                 ),
                      //               ),
                      //             ),
                      //     ),
                      //     SizedBox(height: 20),
                      //     Row(
                      //       mainAxisAlignment: MainAxisAlignment.center,
                      //       children: [
                      //         Text('or'),
                      //       ],
                      //     ),
                      //     SizedBox(height: 20),
                      //     // TAKE IMAGE
                      //     SizedBox(
                      //         width: double.infinity,
                      //         child: ElevatedButton(
                      //           child: Row(
                      //             mainAxisAlignment: MainAxisAlignment.center,
                      //             children: [
                      //               Icon(Icons.camera_alt,
                      //                   color: Color(0xFF37A980)),
                      //               SizedBox(width: 5),
                      //               Text(
                      //                 'Open Camera & Take Photo',
                      //                 style: TextStyle(
                      //                     color: Color(0xFF37A980),
                      //                     fontFamily: 'Poppins'),
                      //               ),
                      //             ],
                      //           ),
                      //           onPressed: () async {
                      //             if (await Permission.camera
                      //                 .request()
                      //                 .isGranted) {
                      //               file = await ImagePicker()
                      //                   .pickImage(source: ImageSource.camera);
                      //               setState(() {});
                      //             } else {
                      //               // Permission is not granted. Handle the scenario accordingly.
                      //               showDialog(
                      //                 context: context,
                      //                 builder: (BuildContext context) {
                      //                   return AlertDialog(
                      //                     title: Text(
                      //                         "Camera Permission Required"),
                      //                     content: Text(
                      //                         "Please grant camera permission in settings to enable camera access."),
                      //                     actions: <Widget>[
                      //                       ElevatedButton(
                      //                         child: Text("CANCEL"),
                      //                         onPressed: () {
                      //                           Navigator.of(context).pop();
                      //                         },
                      //                       ),
                      //                       ElevatedButton(
                      //                         child: Text("SETTINGS"),
                      //                         onPressed: () {
                      //                           openAppSettings(); // This will open the app settings where the user can enable permissions.
                      //                         },
                      //                       ),
                      //                     ],
                      //                   );
                      //                 },
                      //               );
                      //             }
                      //           },
                      //           style: ElevatedButton.styleFrom(
                      //               elevation: 0,
                      //               padding: const EdgeInsets.all(20),
                      //               backgroundColor: Colors.green[50],
                      //               shape: RoundedRectangleBorder(
                      //                 borderRadius: BorderRadius.circular(20),
                      //               )),
                      //         )),
                      //   ],
                      // ),
                      // SizedBox(height: 10),
                      // file != null
                      //     ? Image.file(File(file!.path))
                      //     : Row(
                      //         mainAxisAlignment: MainAxisAlignment.center,
                      //         children: [
                      //           Text("Please select an image",
                      //               style: TextStyle(
                      //                   fontFamily: 'Poppins',
                      //                   color: Colors.red))
                      //         ],
                      //       ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      _editing ? SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              )),
                          onPressed: () async {
                            try {
                              // start loading
                              setState(() {
                                _editing = false;
                              });
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                  backgroundColor: Colors.green,
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
                                  'Update Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 20),
                                ),
                        ),
                      ) : SizedBox.shrink(),
                      SizedBox(height: 10),
                      _editing ? SizedBox.shrink()
                      : SizedBox(
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
                                  'Log out',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: "Poppins",
                                      fontSize: 20),
                                ),
                        ),
                      ),
                    ],
                  ),
                ])
              ));
            } else {
              return Text('No data available');
            }
          },
        ),
      );
    }
  }
}
