import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';

import 'package:elbi_donation_app/models/donation_model.dart';

class OrgDonationDetails extends StatefulWidget {
  DonationModel donationDetails;
  OrgDonationDetails({Key? key, required this.donationDetails})
      : super(key: key);

  @override
  State<OrgDonationDetails> createState() => _OrgDonationDetailsState();
}

class _OrgDonationDetailsState extends State<OrgDonationDetails> {
  final _formKey = GlobalKey<FormState>();
  Widget imageCarousel() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // TODO: Add images array here
            width: 100,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5),
            ),
          );
        },
      ),
    );
  }

  bool pickup = true;
  bool completed = false;
  String selectedStatus = 'Pending';
  List<String> statuses = [
    'Pending',
    'Confirmed',
    'Scheduled for Pick-up',
    'Complete',
    'Canceled'
  ];

  List<String> organizationDriveList = [];
  List<String> drives = [];
  String selectedDrive = '-';

  @override
  void initState() {
    super.initState();
    _fetchDonationDriveModels();
  }

  Future<void> _fetchDonationDriveModels() async {
    final userId = context.read<UserAuthProvider>().user?.uid;
    final userInformation =
        await context.read<UserProvider>().getUserModel(userId!);
    organizationDriveList = userInformation['userModel'].organizationDriveList;
    List<String> items = [];
    for (String donationDriveId in organizationDriveList) {
      final donationDriveModel = await context
          .read<OrganizationProvider>()
          .getDonationDriveModel(donationDriveId);
      items.add(donationDriveModel['donationDriveModel'].donationDriveName);
    }
    setState(() {
      if (organizationDriveList.length != 0) {
        drives = items;
        selectedDrive = items[0];
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // final userId = context.read<UserAuthProvider>().user?.uid;

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Donation Details',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w700),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Images',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                  SizedBox(height: 10),
                  imageCarousel(),
                  SizedBox(height: 20),
                  // LOCATION
                  Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Color(0xFF37A980),
                      ),
                      Expanded(child: Text("Address goes here")),
                    ],
                  ),
                  SizedBox(height: 20),
                  // START OF DETAILS
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Category',
                            style: TextStyle(fontFamily: 'Poppins')),
                          Text(widget.donationDetails.categories!.join(', '),
                            style: TextStyle(
                            fontFamily: 'Poppins',
                            color: Color(0xFF818181))),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Weight',
                            style: TextStyle(fontFamily: 'Poppins')),
                          Text(widget.donationDetails.weight.toString(),
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF818181))),
                        ],
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Mode of delivery',
                            style: TextStyle(fontFamily: 'Poppins')),
                          Text(widget.donationDetails.isPickupOrDropoff!,
                            style: TextStyle(
                              fontFamily: 'Poppins',
                              color: Color(0xFF818181))),
                        ],
                      ),
                      SizedBox(height: 20),
                      pickup
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Pickup date',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                      DateFormat('MM-dd-yyyy').format(widget.donationDetails.dateTime!),
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF818181))),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Pickup time',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                      DateFormat.jm().format(widget.donationDetails.dateTime!),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF818181))),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Contact number',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(widget.donationDetails.contactNo!,
                                        style: TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF818181))),
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Drop off date',
                                      style:
                                      TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                      DateFormat('MM-dd-yyyy').format(widget.donationDetails.dateTime!),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF818181))),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('Drop off time',
                                      style:
                                        TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                      DateFormat.jm().format(widget.donationDetails.dateTime!),
                                      style: TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF818181))),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                  // END OF DETAILS
                  SizedBox(height: 10),
                  Text("Edit status",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF37A980),
                          fontSize: 16)),
                  // DROPDOWN FOR STATUS
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      // hintText: 'Pe',
                      // hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    value: selectedStatus,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedStatus = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please input the status';
                      }
                      return null;
                    },
                    items: statuses.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status,
                            style: TextStyle(fontFamily: 'Poppins')),
                      );
                    }).toList(),
                  ),

                  SizedBox(height: 10),
                  Text("Assign donation drive",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF37A980),
                          fontSize: 16)),
                  // DROPDOWN FOR DONATION DRIVE

                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      // hintText: 'Pe',
                      // hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                        borderRadius: BorderRadius.all(Radius.circular(4)),
                      ),
                    ),
                    value: selectedDrive,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedDrive = newValue!;
                      });
                    },
                    validator: (value) {
                      if (value == null) {
                        return 'Please choose a drive';
                      }
                      return null;
                    },
                    items: drives.map((String donationDriveName) {
                      return DropdownMenuItem<String>(
                        value: donationDriveName,
                        child: Text(donationDriveName,
                            style: TextStyle(fontFamily: 'Poppins')),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 10),
                  // CONFIRM BUTTON
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
                          print(selectedStatus);
                          print(selectedDrive);
                          // print(drives.indexOf(selectedDrive));
                          print(organizationDriveList);
                          // print(organizationDriveList[
                          //     drives.indexOf(selectedDrive)]);
                          Map<String, dynamic> donationDriveupdate = {
                            'listOfDonationsId': widget.donationDetails.id,
                          };

                          await context
                              .read<OrganizationProvider>()
                              .updateDonationDriveModel(
                                  organizationDriveList[
                                      drives.indexOf(selectedDrive)],
                                  donationDriveupdate);
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
        ));
  }
}
