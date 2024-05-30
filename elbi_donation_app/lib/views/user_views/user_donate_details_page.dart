import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_app/models/donation_model.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class UserDonationDetails extends StatefulWidget {
  DonationModel donationDetails;
  UserDonationDetails({super.key, required this.donationDetails});

  @override
  State<UserDonationDetails> createState() => _UserDonationDetailsState();
}

class _UserDonationDetailsState extends State<UserDonationDetails> {
  bool _isLoading = false;

  Widget imageCarousel(List<String>? donationUrlLists) {
    return donationUrlLists != []
        ? SizedBox(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: donationUrlLists!.length,
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  width: 100,
                  height: 100,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(5)),
                  child: donationUrlLists[index] != null
                      ? Image.network(
                          donationUrlLists[index],
                          width: 100,
                          height: 100,
                          fit: BoxFit.cover,
                        )
                      : const Center(
                          child: Text('No image selected'),
                        ),
                );
              },
            ),
          )
        : Container(child: const Text("red"));
  }

  bool pickup = true;
  bool completed = false;

  @override
  Widget build(BuildContext context) {
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
              fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Images',
                style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
            const SizedBox(height: 10),
            widget.donationDetails.imagesOfDonationsList != null &&
                    widget.donationDetails.imagesOfDonationsList!.isNotEmpty
                ? imageCarousel(widget.donationDetails.imagesOfDonationsList)
                : const Text('No images available'),

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
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Category',
                          style: TextStyle(fontFamily: 'Poppins')),
                      Text(widget.donationDetails.categories!.join(', '),
                          style: const TextStyle(
                              fontFamily: 'Poppins', color: Color(0xFF818181))),
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
                              fontFamily: 'Poppins', color: Color(0xFF818181))),
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
                              fontFamily: 'Poppins', color: Color(0xFF818181))),
                    ],
                  ),
                  const SizedBox(height: 20),
                  pickup
                      ? // if pickup
                      Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Pickup date',
                                    style: TextStyle(fontFamily: 'Poppins')),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Pickup time',
                                    style: TextStyle(fontFamily: 'Poppins')),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Contact number',
                                    style: TextStyle(fontFamily: 'Poppins')),
                                Text(
                                    widget.donationDetails.contactNo.toString(),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Drop off date',
                                    style: TextStyle(fontFamily: 'Poppins')),
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Drop off time',
                                    style: TextStyle(fontFamily: 'Poppins')),
                                Text(
                                    DateFormat.jm().format(
                                        widget.donationDetails.dateTime!),
                                    style: const TextStyle(
                                        fontFamily: 'Poppins',
                                        color: Color(0xFF818181))),
                              ],
                            )
                          ],
                        ),
                ],
              ),
            ),
            // END OF DETAILS
            completed
                ? // IF DONATION COMPLETED
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
                      onPressed: () {},
                      child: const Text(
                        'Completed',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 20),
                      ),
                    ),
                  )
                : Column(
                    children: [
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
                          onPressed: () {
                            // TODO: Generate QR
                          },
                          child: const Text(
                            'Generate QR',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 20),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(10),
                              backgroundColor: Colors.red,
                              shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            onPressed: () async {
                              // TODO: Cancel Donation
                              try {
                                setState(() {
                                  _isLoading = true;
                                });

                                Map<String, dynamic> result;

                                // first dereference from user
                                if (context.mounted) {
                                  result = await context
                                      .read<UserProvider>()
                                      .updateUserModel(
                                          widget.donationDetails.donatorId!, {
                                    'donationsList': FieldValue.arrayRemove(
                                        [widget.donationDetails.id])
                                  });

                                  if (!result['success']) {
                                    throw result['error'];
                                  }
                                }

                                // dereferencing
                                if (context.mounted) {
                                  result = await context
                                      .read<OrganizationProvider>()
                                      .dereferenceDonation(
                                          widget.donationDetails.id!);

                                  if (!result['success']) {
                                    throw result['error'];
                                  }
                                }

                                // deletion of the model itself
                                if (context.mounted) {
                                  result = await context
                                      .read<DonorProvider>()
                                      .deleteDonationModel(
                                          widget.donationDetails.id!);

                                  if (!result['success']) {
                                    throw result['error'];
                                  }
                                }

                                if (context.mounted) {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text('Donation canceled.'),
                                    backgroundColor: Colors.green,
                                  ));
                                }

                                if (context.mounted) {
                                  Navigator.of(context).pop();
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
                                : const Text('Cancel Donation',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: "Poppins"))),
                      )
                    ],
                  )
          ],
        ),
      ),
    );
  }
}
