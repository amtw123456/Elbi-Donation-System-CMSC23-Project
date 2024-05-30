import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';

import 'package:elbi_donation_app/models/donation_model.dart';

class OrgDonationDetails extends StatefulWidget {
  DonationModel donationDetails;
  OrgDonationDetails({super.key, required this.donationDetails});

  @override
  State<OrgDonationDetails> createState() => _OrgDonationDetailsState();
}

class _OrgDonationDetailsState extends State<OrgDonationDetails> {
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  Widget imageCarousel() {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            // TODO: Add images array here
            width: 100,
            height: 100,
            margin: const EdgeInsets.symmetric(horizontal: 5),
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
      if (organizationDriveList.isNotEmpty) {
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
            icon: const Icon(Icons.arrow_back),
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
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Images',
                      style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
                  const SizedBox(height: 10),
                  imageCarousel(),
                  const SizedBox(height: 20),
                  // LOCATION
                  const Row(
                    children: [
                      Icon(
                        Icons.location_pin,
                        color: Color(0xFF37A980),
                      ),
                      Expanded(child: Text("Address goes here")),
                    ],
                  ),
                  const SizedBox(height: 20),
                  // START OF DETAILS
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Category',
                              style: TextStyle(fontFamily: 'Poppins')),
                          Text(widget.donationDetails.categories!.join(', '),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF818181))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Weight',
                              style: TextStyle(fontFamily: 'Poppins')),
                          Text(widget.donationDetails.weight.toString(),
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF818181))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text('Mode of delivery',
                              style: TextStyle(fontFamily: 'Poppins')),
                          Text(widget.donationDetails.isPickupOrDropoff!,
                              style: const TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF818181))),
                        ],
                      ),
                      const SizedBox(height: 20),
                      pickup
                          ? Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Pickup date',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                        DateFormat('MM-dd-yyyy').format(
                                            widget.donationDetails.dateTime!),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF818181))),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Pickup time',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                        DateFormat.jm().format(
                                            widget.donationDetails.dateTime!),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF818181))),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Contact number',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(widget.donationDetails.contactNo!,
                                        style: const TextStyle(
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
                                    const Text('Drop off date',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                        DateFormat('MM-dd-yyyy').format(
                                            widget.donationDetails.dateTime!),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF818181))),
                                  ],
                                ),
                                const SizedBox(height: 20),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text('Drop off time',
                                        style:
                                            TextStyle(fontFamily: 'Poppins')),
                                    Text(
                                        DateFormat.jm().format(
                                            widget.donationDetails.dateTime!),
                                        style: const TextStyle(
                                            fontFamily: 'Poppins',
                                            color: Color(0xFF818181))),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                  // END OF DETAILS
                  const SizedBox(height: 10),
                  const Text("Edit status",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF37A980),
                          fontSize: 16)),
                  // DROPDOWN FOR STATUS
                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
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
                            style: const TextStyle(fontFamily: 'Poppins')),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 10),
                  const Text("Assign donation drive",
                      style: TextStyle(
                          fontFamily: 'Poppins',
                          color: Color(0xFF37A980),
                          fontSize: 16)),
                  // DROPDOWN FOR DONATION DRIVE

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
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
                            style: const TextStyle(fontFamily: 'Poppins')),
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 10),
                  // CONFIRM BUTTON
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
                          try {
                            setState(() {
                              _isLoading = true;
                            });

                            Map<String, dynamic> result;
                            Map<String, dynamic> donationDriveupdate = {
                              'listOfDonationsId': widget.donationDetails.id,
                            };

                            result = await context
                                .read<OrganizationProvider>()
                                .updateDonationDriveModel(
                                    organizationDriveList[
                                        drives.indexOf(selectedDrive)],
                                    donationDriveupdate);

                            if (!result['success']) {
                              throw result['error'];
                            }

                            if (context.mounted) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(const SnackBar(
                                content: Text('Drive updated successfully!'),
                                backgroundColor: Colors.green,
                              ));
                            }

                            setState(() {
                              _isLoading = false;
                            });
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
