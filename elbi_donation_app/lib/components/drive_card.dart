import 'package:elbi_donation_app/views/admin_views/admin_org_details.dart';
import 'package:flutter/material.dart';

class DonationDriveCard extends StatefulWidget {
  const DonationDriveCard({super.key});

  @override
  State<DonationDriveCard> createState() => _DonationDriveCardState();
}

class _DonationDriveCardState extends State<DonationDriveCard> {
  @override
  Widget build(BuildContext context) {
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // image container
          Container(
            height: 250,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(8)),
          ),
          Text('Donation drive name here',
              style: TextStyle(fontFamily: "Poppins", fontSize: 20)),
          Text('A short description here. One or two sentences maybe?'),
        ],
      ),
    );
  }
}
