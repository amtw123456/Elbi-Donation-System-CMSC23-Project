import 'package:elbi_donation_app/models/donation_model.dart';
import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';
import 'package:elbi_donation_app/components/donation_card.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';

import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgDonationDriveDetails extends StatefulWidget {
  final String donationDriveId;
  const OrgDonationDriveDetails({required this.donationDriveId, super.key});

  @override
  State<OrgDonationDriveDetails> createState() =>
      _OrgDonationDriveDetailsState();
}

class _OrgDonationDriveDetailsState extends State<OrgDonationDriveDetails> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // Add this line to center the title
        title: Text(
          "Details",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
        actions: [
          PopupMenuButton<int>(
            icon: Icon(Icons.more_horiz), // three-dot menu icon
            onSelected: (int result) {
              if (result == 1) {
                context
                    .read<OrganizationProvider>()
                    .getDonationDriveModel(widget.donationDriveId)
                    .then((donationDriveDetails) {
                  OpenEditDialog(
                    donationDriveDetails['donationDriveModel']
                        .donationDriveName,
                    donationDriveDetails['donationDriveModel']
                        .donationDriveDescription,
                  );
                });
              } else if (result == 2) {
                // TODO: DO DELETE HERE
              }
            },
            itemBuilder: (BuildContext context) => <PopupMenuEntry<int>>[
              const PopupMenuItem<int>(
                value: 1,
                child: Text('Edit'),
              ),
              const PopupMenuItem<int>(
                value: 2,
                child: Text('Delete'),
              ),
            ],
            color: Colors.white,
          )
        ],
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: context
            .read<OrganizationProvider>()
            .getDonationDriveModel(widget.donationDriveId),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: 400,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final donationDriveDetails = snapshot.data!;
            print(widget.donationDriveId);
            print(donationDriveDetails['donationDriveModel'].donationDriveName);
            print(donationDriveDetails['donationDriveModel'].listOfDonationsId);
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0), // Adjust the horizontal padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit'), // Dialog title
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Field 1'),
                                  ),
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Field 2'),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.edit, // Replace with your desired icon
                        color: Colors.green, // Adjust color as needed
                        size: 20, // Adjust size as needed
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: screenHeight / 3,
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: donationDriveDetails['donationDriveModel']
                                .donationDriveImageCover ==
                            null
                        ? Center(
                            child: Text('No image available'),
                          )
                        : FittedBox(
                            child: Image.network(
                              donationDriveDetails['donationDriveModel']
                                  .donationDriveImageCover!,
                              width: 400,
                              height: 250,
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                  Text(
                    donationDriveDetails['donationDriveModel']
                        .donationDriveName,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.black,
                      fontSize: 24.0, // Adjust the font size as needed
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          donationDriveDetails['donationDriveModel']
                              .donationDriveDescription,
                          style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Colors.grey,
                            fontSize: 12.0,
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
                          )),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => Container(
                            height: MediaQuery.of(context).size.height * 0.75,
                            decoration: new BoxDecoration(
                              color: Colors.white,
                              borderRadius: new BorderRadius.only(
                                topLeft: const Radius.circular(25.0),
                                topRight: const Radius.circular(25.0),
                              ),
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.all(30),
                                child: Column(
                                  children: [
                                    ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(height: 25),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: donationDriveDetails[
                                                  'donationDriveModel']
                                              .listOfDonationsId
                                              ?.length ??
                                          0,
                                      itemBuilder: (context, index) {
                                        return FutureBuilder<
                                            Map<String, dynamic>>(
                                          future: context
                                              .read<DonorProvider>()
                                              .getDonationModel(
                                                  donationDriveDetails[
                                                          'donationDriveModel']
                                                      .listOfDonationsId[index]),
                                          builder: (context, snapshot) {
                                            if (snapshot.hasData) {
                                              final donationDetails = snapshot
                                                  .data!['donationModel'];
                                              print(donationDetails);
                                              return DonationCard(
                                                  donationInformation:
                                                      donationDetails);
                                              // return Container();
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else {
                                              return const SizedBox(
                                                width: 60,
                                                height: 60,
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                          },
                                        );

                                        //
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      child: const Text(
                        'View Donations',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }

  Future<void> OpenEditDialog(String name, String description) =>
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (BuildContext context) {
          final _formKey = GlobalKey<FormState>();
          final screenHeight = MediaQuery.of(context).size.height;
          final nameController = TextEditingController(text: name);
          final descriptionController =
              TextEditingController(text: description);
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
                        'Edit drive details',
                        style: TextStyle(
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w700,
                          fontSize: 24.0,
                        ),
                      ),
                      SizedBox(height: 20),
                      TextFormField(
                          controller: nameController,
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
                              return 'Please enter a name';
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
                              return 'Please enter details';
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
                                  if (_formKey.currentState!.validate()) {
                                    print(nameController.text);
                                    print(descriptionController.text);
                                    // TODO: ADD UPDATE LOGIC HERE
                                    Navigator.pop(context);
                                  }
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
                                    // TODO: ADD UPDATE LOGIC HERE
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
