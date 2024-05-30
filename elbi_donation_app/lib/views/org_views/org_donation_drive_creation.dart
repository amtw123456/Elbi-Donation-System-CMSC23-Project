import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/models/donation_drive_model.dart';
import 'package:elbi_donation_app/functions/misc.dart';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

class AddDonationDrive extends StatefulWidget {
  const AddDonationDrive({super.key});

  @override
  State<AddDonationDrive> createState() => _AddDonationDriveState();
}

class _AddDonationDriveState extends State<AddDonationDrive> {
  final _formKey = GlobalKey<FormState>();

  String? driveName;
  String? driveDescription;

  XFile? file;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserAuthProvider>().user?.uid;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text(
          'Drive Details',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Please enter your drive details'),
              SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        onChanged: (value) {
                          setState(() {
                            driveName = value;
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a drive name';
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                          hintText: 'Donation drive name',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: TextFormField(
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a drive description';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            driveDescription = value;
                          });
                        },
                        minLines: 9,
                        maxLines: 10,
                        decoration: const InputDecoration(
                          hintText: 'Description',
                          hintStyle: TextStyle(
                              fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                          fillColor: Colors.white,
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                          ),
                        ),
                      ),
                    ),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Upload a donation drive cover!',
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton.outlined(
                          onPressed: () async {
                            if (await Permission.storage.request().isGranted) {
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
                          icon: const Icon(Icons.upload),
                        ),
                        IconButton.outlined(
                          onPressed: () async {
                            if (await Permission.camera.request().isGranted) {
                              file = await ImagePicker()
                                  .pickImage(source: ImageSource.camera);
                            } else {
                              // Permission is not granted. Handle the scenario accordingly.
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text(
                                        "Camera Permission Required"),
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
                          icon: const Icon(Icons.photo_camera),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    const Row(
                      children: [
                        Text(
                          "Donation Drive Image:",
                          style: TextStyle(fontFamily: 'Poppins', fontSize: 16),
                          textAlign: TextAlign.start,
                        ),
                      ],
                    ),
                    Container(
                      width: 400,
                      height: 250,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                      child: file == null
                          ? const Center(
                              child: Text('No image selected.'),
                            )
                          : Image.file(
                              File(file!.path),
                              width: 400,
                              height: 300,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(10),
                    backgroundColor: const Color(0xFF37A980),
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print(driveName);
                      print(driveDescription);

                      String? donationDriveString = generateRandomString(28);

                      if (file != null) {
                        Reference referenceRoot =
                            FirebaseStorage.instance.ref();

                        Reference referenceDirImages =
                            referenceRoot.child('images');

                        Reference referenceImageToUpload =
                            referenceDirImages.child(
                                '$donationDriveString-proofOfLegitimacyImage');

                        try {
                          await referenceImageToUpload
                              .putFile(File(file!.path));
                          imageUrl =
                              await referenceImageToUpload.getDownloadURL();
                        } catch (error) {}
                      }

                      DonationDriveModel donationDriveModel =
                          DonationDriveModel(
                        id: donationDriveString,
                        organizationId: userId,
                        donationDriveName: driveName,
                        donationDriveDescription: driveDescription,
                        donationDriveImageCover: imageUrl,
                      );

                      await context
                          .read<OrganizationProvider>()
                          .addDonationDriveModel(donationDriveModel);
                      Map<String, dynamic> updates = {
                        'organizationDriveList': donationDriveString,
                        // Add other fields you want to update
                      };

                      await context
                          .read<UserProvider>()
                          .updateUserModel(userId!, updates);

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
              )
            ],
          ),
        ),
      ),
    );
  }
}
