import 'package:elbi_donation_app/views/admin_views/admin_org_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/models/donation_drive_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

import 'dart:io';

class DonationDriveCard extends StatefulWidget {
  final String donationDriveId;
  final String organizationId;
  final VoidCallback? onDeletion;

  const DonationDriveCard(
      {required this.donationDriveId,
      required this.organizationId,
      required this.onDeletion,
      super.key});

  @override
  State<DonationDriveCard> createState() => _DonationDriveCardState();
}

class _DonationDriveCardState extends State<DonationDriveCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: context
          .read<OrganizationProvider>()
          .getDonationDriveModel(widget.donationDriveId),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(16.0),
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
          return Container(
            width: double.infinity,
            height: 400,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey,
                width: 1.0,
              ),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // image container
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      // Handle tap event here
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text(''),
                            content: SizedBox(
                              width: 400.0,
                              height: 120,
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Text(
                                    'Are you sure you want to delete this donation drive?',
                                  ),
                                  const SizedBox(
                                      height: 20), // Add some spacing
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        ElevatedButton(
                                          onPressed: () async {
                                            // Handle the button press action
                                            await context
                                                .read<OrganizationProvider>()
                                                .deleteDonationDriveModel(
                                                    widget.donationDriveId);

                                            context
                                                .read<UserProvider>()
                                                .removeDonationDriveModelFromUserModel(
                                                    widget.organizationId,
                                                    widget.donationDriveId);

                                            Navigator.of(context)
                                                .pop(); // Close the dialog

                                            widget.onDeletion?.call();
                                          },
                                          child: const Text('Delete'),
                                        ),
                                        const SizedBox(
                                            width: 10), // Add some spacing
                                        ElevatedButton(
                                          child: const Text('Close'),
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: const Icon(
                      Icons.close,
                      size: 25.0, // Adjust size as needed
                      color: Colors.grey, // Adjust color as needed
                    ),
                  ),
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
                  child: donationDriveDetails['donationDriveModel']
                              .donationDriveImageCover ==
                          null
                      ? const Center(
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
                    style:
                        const TextStyle(fontFamily: "Poppins", fontSize: 20)),
                Text(
                  donationDriveDetails['donationDriveModel']
                      .donationDriveDescription,
                ),
              ],
            ),
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
