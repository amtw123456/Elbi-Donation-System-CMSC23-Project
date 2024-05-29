import 'package:flutter/material.dart';
import 'package:elbi_donation_app/models/donation_model.dart';

class DonationCard extends StatefulWidget {
  DonationModel donationInformation;

  DonationCard({super.key, required this.donationInformation});

  @override
  State<DonationCard> createState() => _DonationCardState();
}

class _DonationCardState extends State<DonationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(color: Color(0xFFD2D2D2), width: 1.0)),
      child: Column(
        children: [
          // date container
          Container(
            padding: EdgeInsets.all(2),
            height: 30,
            width: double.infinity,
            child: Text(
              "Made on: 05/25/2003",
              style: TextStyle(
                fontFamily: 'Poppins',
              ),
            ),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(color: Color(0xFFD2D2D2), width: 1.0)),
          ),
          SizedBox(height: 18),
          Row(children: [
            // TODO: Image placeholder
            Container(
                height: 75,
                width: 75,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(5),
                ),
                margin: EdgeInsets.only(left: 5, right: 5)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.donationInformation.donatorId!,
                    style: TextStyle(fontFamily: 'Poppins')),
                Container(
                  child: Text('Clothes',
                      style: TextStyle(
                          fontSize: 9,
                          fontFamily: 'Poppins',
                          color: Color(0xFF37A980))),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFF37A980), width: 1),
                      borderRadius: BorderRadius.circular(5)),
                )
              ],
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: Container(
                  child: Text('Pending',
                      style: TextStyle(
                          fontSize: 12,
                          fontFamily: 'Poppins',
                          color: Color(0xFFD2D2D2))),
                  padding: EdgeInsets.all(3),
                  decoration: BoxDecoration(
                      border: Border.all(color: Color(0xFFD2D2D2), width: 1),
                      borderRadius: BorderRadius.circular(5)),
                ),
              ),
            )
          ])
        ],
      ),
    );
  }
}
