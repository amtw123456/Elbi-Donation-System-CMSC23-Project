import 'package:flutter/material.dart';
import 'package:elbi_donation_app/models/donation_model.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class DonationCard extends StatefulWidget {
  final DonationModel donationInformation;

  const DonationCard({super.key, required this.donationInformation});

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: context
          .read<UserProvider>()
          .getUserModel(widget.donationInformation.donatorId!),
      builder:
          (BuildContext context, AsyncSnapshot<Map<String, dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          final userInformation = snapshot.data!['userModel'];
          return Container(
            height: 150,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: const Color(0xFFD2D2D2), width: 1.0),
            ),
            child: Column(
              children: [
                // Date container
                Container(
                  padding: const EdgeInsets.all(5),
                  height: 30,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: const Border(
                      bottom: BorderSide(color: Color(0xFFD2D2D2), width: 1.0),
                    ),
                  ),
                  child: Text(
                    DateFormat('MM-dd-yyyy')
                        .format(widget.donationInformation.dateTime!),
                    style: const TextStyle(
                      fontFamily: 'Poppins',
                    ),
                  ),
                ),
                const SizedBox(height: 18),
                Row(
                  children: [
                    // Image placeholder
                    Container(
                      height: 75,
                      width: 75,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5),
                      ),
                      margin: const EdgeInsets.only(left: 5, right: 5),
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${userInformation.firstName} ${userInformation.lastName}',
                            style: const TextStyle(fontFamily: 'Poppins'),
                          ),
                          const SizedBox(height: 10),
                          SizedBox(
                            height: 20, // Adjust the height as needed
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  widget.donationInformation.categories!.length,
                              itemBuilder: (context, index) {
                                final category = widget
                                    .donationInformation.categories![index];
                                return Container(
                                    margin: const EdgeInsets.only(
                                        right:
                                            8), // Add margin if you want some spacing between items
                                    padding: const EdgeInsets.all(3),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: const Color(0xFF37A980),
                                          width: 1),
                                      borderRadius: BorderRadius.circular(5),
                                    ),
                                    child: Center(
                                      child: Text(
                                        category,
                                        style: const TextStyle(
                                          fontSize: 9,
                                          fontFamily: 'Poppins',
                                          color: Color(0xFF37A980),
                                        ),
                                      ),
                                    ));
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                      // TODO: Change decoration depending on status
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFD2D2D2), width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        // TODO: Change text
                        widget.donationInformation.status ?? 'N/A',
                        style: const TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: Color(0xFFD2D2D2),
                        ),
                      ),
                    )
                  ],
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
