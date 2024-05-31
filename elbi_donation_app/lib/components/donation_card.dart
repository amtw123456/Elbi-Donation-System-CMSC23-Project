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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Image placeholder
                    Container(
                      margin: EdgeInsets.fromLTRB(10, 0, 10, 0),
                      height: 75, 
                      width: 75, 
                      decoration: BoxDecoration(
                        color: Colors.green,
                        borderRadius: BorderRadius.circular(5)
                      ),
                      child: widget.donationInformation.imagesOfDonationsList != null &&
                            widget.donationInformation.imagesOfDonationsList!.isNotEmpty
                            ? Image.network(widget.donationInformation.imagesOfDonationsList![0])
                            : Image.network('')
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
                          Wrap(
                            spacing: 8.0, // horizontal gap between items
                            runSpacing: 4.0, // vertical gap between lines
                            children: List.generate(
                              widget.donationInformation.categories!.length,
                              (index) {
                                final category = widget.donationInformation.categories![index];
                                return Container(
                                  padding: const EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF37A980),
                                    border: Border.all(color: const Color(0xFF37A980), width: 1),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    category,
                                    style: const TextStyle(
                                      fontSize: 9,
                                      fontFamily: 'Poppins',
                                      color: Colors.white,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 50, 20, 0),
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: const Color(0xFFD2D2D2), width: 1),
                        borderRadius: BorderRadius.circular(5),
                        color: widget.donationInformation.status == 'Confirmed' ?  Color(0xFF37A980) : Colors.white 

                      ),
                      child: Text(
                        widget.donationInformation.status ?? 'N/A',
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Poppins',
                          color: widget.donationInformation.status == 'Confirmed' ? Colors.white :Color(0xFFD2D2D2),
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
