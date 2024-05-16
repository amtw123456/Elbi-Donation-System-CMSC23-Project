import 'package:flutter/material.dart';

class OrganizationCard extends StatefulWidget {
  const OrganizationCard({super.key});

  @override
  State<OrganizationCard> createState() => _OrganizationCardState();
}

class _OrganizationCardState extends State<OrganizationCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
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
            height: 150,
            padding: EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(8)
            ),
          ),
          Text('Organization name here', style: TextStyle(fontFamily: "Poppins", fontSize: 20)),
          Text('A short description here. One or two sentences maybe?'),
        ],
      ),
    );
  }
}