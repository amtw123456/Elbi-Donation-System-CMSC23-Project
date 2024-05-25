import 'package:elbi_donation_app/models/user_model.dart';
import 'package:elbi_donation_app/views/admin_views/admin_org_details.dart';
import 'package:flutter/material.dart';

class OrganizationCard extends StatefulWidget {
  OrganizationCard({super.key, required this.organization});

  UserModel organization;

  @override
  State<OrganizationCard> createState() => _OrganizationCardState();
}

class _OrganizationCardState extends State<OrganizationCard> {
  @override
  Widget build(BuildContext context) {
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
          Container(
            height: 250,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
                color: Colors.green, borderRadius: BorderRadius.circular(8)),
          ),
          Text(widget.organization.orgName!,
              style: const TextStyle(fontFamily: "Poppins", fontSize: 20)),
          const Text('An organization ready to receive your help.'),
        ],
      ),
    );
  }
}
