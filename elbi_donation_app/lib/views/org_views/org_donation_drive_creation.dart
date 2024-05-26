import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/models/donation_drive_model.dart';
import 'package:elbi_donation_app/functions/misc.dart';

class AddDonationDrive extends StatefulWidget {
  const AddDonationDrive({Key? key}) : super(key: key);

  @override
  State<AddDonationDrive> createState() => _AddDonationDriveState();
}

class _AddDonationDriveState extends State<AddDonationDrive> {
  final _formKey = GlobalKey<FormState>();

  String? driveName;
  String? driveDescription;

  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserAuthProvider>().user?.uid;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text(
          'Drive Details',
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Please enter your drive details'),
              Expanded(
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
                        decoration: InputDecoration(
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
                        decoration: InputDecoration(
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
                  ],
                ),
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(10),
                    backgroundColor: Color(0xFF37A980),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      print(driveName);
                      print(driveDescription);

                      String? donationDriveString = generateRandomString(28);

                      DonationDriveModel donationDriveModel =
                          DonationDriveModel(
                        id: donationDriveString,
                        organizationId: userId,
                        donationDriveName: driveName,
                        donationDriveDescription: driveDescription,
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
