import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/widgets.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:elbi_donation_app/components/navigation_helper.dart';
import 'package:elbi_donation_app/views/admin_views/admin_profile.dart';
import 'package:elbi_donation_app/views/admin_views/admin_router.dart';
import 'package:elbi_donation_app/views/org_views/org_home_page.dart';
import 'package:elbi_donation_app/views/org_views/org_router.dart';
import 'package:elbi_donation_app/views/user_views/user_router.dart';
import 'package:flutter/material.dart';
import 'package:form_validator/form_validator.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../models/user_model.dart';
import 'package:flutter/material.dart';

import 'dart:io';

class SignUpDonorPage extends StatefulWidget {
  const SignUpDonorPage({super.key});

  @override
  _SignUpDonorPageState createState() => _SignUpDonorPageState();
}

class _SignUpDonorPageState extends State<SignUpDonorPage> {
  // for showing if it's going to be an organization
  bool _isOrganization = false;
  // for loading buttons
  bool _isLoading = false;

  final _formKey = GlobalKey<FormState>();

  File? _selectedImage;

  XFile? file;
  String imageUrl = '';

  // controllers
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController organizationNameController =
      TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    usernameController.dispose();
    emailController.dispose();
    addressController.dispose();
    contactNumberController.dispose();
    passwordController.dispose();
    organizationNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Personal',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: TextFormField(
                    controller: firstNameController,
                    validator: ValidationBuilder().build(),
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
                    controller: lastNameController,
                    validator: ValidationBuilder().build(),
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
                    controller: usernameController,
                    validator: ValidationBuilder().build(),
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
                    controller: addressController,
                    validator: ValidationBuilder().build(),
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
                    controller: contactNumberController,
                    validator: ValidationBuilder().build(),
                    decoration: const InputDecoration(
                      hintText: 'Contact number',
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
                const SizedBox(height: 20),
                CheckboxListTile(
                  title: const Text('Want to sign up as an organization?'),
                  value: _isOrganization,
                  onChanged: (bool? value) {
                    setState(() {
                      _isOrganization = value ?? false;
                    });
                  },
                ),
                const SizedBox(height: 20),
                if (_isOrganization) ...[
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: organizationNameController,
                      validator: ValidationBuilder().build(),
                      decoration: const InputDecoration(
                        hintText: 'Organization name',
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    'Please provide a proof of legitimacy',
                    style: TextStyle(fontFamily: 'Poppins'),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // UPLOAD IMAGE
                  SizedBox(
                    width: double.infinity,
                    height: 150,
                    child: _selectedImage != null
                        ? Image.file(_selectedImage!)
                        : ElevatedButton(
                            onPressed: () async {
                              if (await Permission.storage
                                  .request()
                                  .isGranted) {
                                // _pickImageFromGallery();
                                file = await ImagePicker()
                                    .pickImage(source: ImageSource.gallery);
                                setState(() {});
                              } else {
                                // Permission is not granted. Handle the scenario accordingly.
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text(
                                          "storage Permission Required"),
                                      content: const Text(
                                          "Please grant stroage permission in settings to enable storage access."),
                                      actions: <Widget>[
                                        ElevatedButton(
                                          child: const Text("CANCEL"),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                        ElevatedButton(
                                          child: const Text("SETTINGS"),
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
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              padding: const EdgeInsets.all(20),
                              backgroundColor: Colors.grey[50],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                                side: const BorderSide(
                                    color: Color(0xFF37A980), width: 2),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .center, // Center the contents vertically
                                children: [
                                  Icon(Icons.photo_library,
                                      size: 40,
                                      color: Colors.grey[
                                          500]), // Adjust size and color as needed
                                  const SizedBox(
                                      height:
                                          10), // Add some space between the icon and the text
                                  Text(
                                    "Upload photo",
                                    style: TextStyle(
                                        color: Colors.grey[500],
                                        fontSize: 16,
                                        fontFamily:
                                            'Poppins'), // Adjust text style as needed
                                  ),
                                ],
                              ),
                            ),
                          ),
                  ),
                  // IconButton.outlined(
                  //   onPressed: () async {
                  //     if (await Permission.storage.request().isGranted) {
                  //       // _pickImageFromGallery();
                  //       file = await ImagePicker()
                  //           .pickImage(source: ImageSource.gallery);
                  //     } else {
                  //       // Permission is not granted. Handle the scenario accordingly.
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return AlertDialog(
                  //             title: Text("storage Permission Required"),
                  //             content: Text(
                  //                 "Please grant stroage permission in settings to enable storage access."),
                  //             actions: <Widget>[
                  //               ElevatedButton(
                  //                 child: Text("CANCEL"),
                  //                 onPressed: () {
                  //                   Navigator.of(context).pop();
                  //                 },
                  //               ),
                  //               ElevatedButton(
                  //                 child: Text("SETTINGS"),
                  //                 onPressed: () {
                  //                   openAppSettings(); // This will open the app settings where the user can enable permissions.
                  //                 },
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       );
                  //     }
                  //   },
                  //   icon: const Icon(Icons.upload),
                  // ),
                  const SizedBox(height: 20),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('or'),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // TAKE IMAGE
                  SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (await Permission.camera.request().isGranted) {
                            file = await ImagePicker()
                                .pickImage(source: ImageSource.camera);
                            setState(() {});
                          } else {
                            // Permission is not granted. Handle the scenario accordingly.
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title:
                                      const Text("Camera Permission Required"),
                                  content: const Text(
                                      "Please grant camera permission in settings to enable camera access."),
                                  actions: <Widget>[
                                    ElevatedButton(
                                      child: const Text("CANCEL"),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    ElevatedButton(
                                      child: const Text("SETTINGS"),
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
                        style: ElevatedButton.styleFrom(
                            elevation: 0,
                            padding: const EdgeInsets.all(20),
                            backgroundColor: Colors.green[50],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.camera_alt, color: Color(0xFF37A980)),
                            SizedBox(width: 5),
                            Text(
                              'Open Camera & Take Photo',
                              style: TextStyle(
                                  color: Color(0xFF37A980),
                                  fontFamily: 'Poppins'),
                            ),
                          ],
                        ),
                      )),
                  // IconButton.outlined(
                  //   onPressed: () async {
                  //     if (await Permission.camera.request().isGranted) {
                  //       file = await ImagePicker()
                  //           .pickImage(source: ImageSource.camera);
                  //     } else {
                  //       // Permission is not granted. Handle the scenario accordingly.
                  //       showDialog(
                  //         context: context,
                  //         builder: (BuildContext context) {
                  //           return AlertDialog(
                  //             title: Text("Camera Permission Required"),
                  //             content: Text(
                  //                 "Please grant camera permission in settings to enable camera access."),
                  //             actions: <Widget>[
                  //               ElevatedButton(
                  //                 child: Text("CANCEL"),
                  //                 onPressed: () {
                  //                   Navigator.of(context).pop();
                  //                 },
                  //               ),
                  //               ElevatedButton(
                  //                 child: Text("SETTINGS"),
                  //                 onPressed: () {
                  //                   openAppSettings(); // This will open the app settings where the user can enable permissions.
                  //                 },
                  //               ),
                  //             ],
                  //           );
                  //         },
                  //       );
                  //     }
                  //   },
                  //   icon: const Icon(Icons.camera),
                  // ),
                  const SizedBox(height: 50),
                  file != null
                      ? Image.file(File(file!.path))
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Please select an image",
                                style: TextStyle(
                                    fontFamily: 'Poppins', color: Colors.red))
                          ],
                        ),
                  const SizedBox(
                    height: 10,
                  )
                ],
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
                      if (_formKey.currentState!.validate()) {
                        try {
                          Map<String, dynamic> result;
                          // start loading
                          setState(() {
                            _isLoading = true;
                          });

                          result = await context
                              .read<UserAuthProvider>()
                              .signUp(emailController.text,
                                  passwordController.text);

                          if (!result['success']) {
                            throw result['error'];
                          }

                          String id = result['uid'];

                          if (_isOrganization) {
                            Reference referenceRoot =
                                FirebaseStorage.instance.ref();

                            Reference referenceDirImages =
                                referenceRoot.child('images');

                            Reference referenceImageToUpload =
                                referenceDirImages
                                    .child('$id-proofOfLegitimacyImage');

                            try {
                              await referenceImageToUpload
                                  .putFile(File(file!.path));
                              imageUrl =
                                  await referenceImageToUpload.getDownloadURL();
                            } catch (error) {}
                          }

                          UserModel userModel = UserModel(
                              id: id,
                              firstName: firstNameController.text,
                              lastName: lastNameController.text,
                              username: usernameController.text,
                              orgName: organizationNameController.text,
                              email: emailController.text,
                              address: [addressController.text],
                              contactNumber: contactNumberController.text,
                              organizationDriveList: [],
                              donationsList: [],
                              status: _isOrganization ? "Open" : null,
                              type: _isOrganization ? "org" : "donor",
                              proofOfLegitimacyImageUrlLink: imageUrl,
                              isApprovedByAdmin:
                                  _isOrganization ? false : null);

                          if (context.mounted) {
                            result = await context
                                .read<UserProvider>()
                                .addUserModel(userModel);
                          }

                          if (!result['success']) {
                            throw result['error'];
                          }

                          // finish loading
                          setState(() {
                            _isLoading = false;
                          });

                          if (context.mounted) {
                            if (userModel.type == 'org') {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const OrgRouter()));
                            } else if (userModel.type == 'donor') {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const UserRouter()));
                            } else if (userModel.type == 'admin') {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => const AdminRouter()));
                            } else {
                              throw 'Routing error.';
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
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
                            child: const CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          )
                        : const Text(
                            'Continue',
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Poppins"),
                          ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future<void> _pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage == null) return;
    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
