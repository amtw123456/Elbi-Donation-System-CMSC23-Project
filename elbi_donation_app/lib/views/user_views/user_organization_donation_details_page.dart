import 'package:elbi_donation_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_app/views/user_views/user_donate_goods_page.dart';

class UserOrganizationDetails extends StatefulWidget {
  UserOrganizationDetails({super.key, required this.organization});

  UserModel organization;

  @override
  State<UserOrganizationDetails> createState() =>
      _UserOrganizationDetailsState();
}

class _UserOrganizationDetailsState extends State<UserOrganizationDetails> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // Add this line to center the title
        title: const Text(
          "Details",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 8.0), // Adjust the horizontal padding as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              height: screenHeight / 3,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: widget.organization.proofOfLegitimacyImageUrlLink != null
                  ? Container(
                      width: double.infinity, // Fill the width of the parent
                      height: double.infinity, // Fill the height of the parent
                      child: Image.network(
                        widget.organization.proofOfLegitimacyImageUrlLink!,
                        fit: BoxFit
                            .cover, // Make the image cover the entire container
                      ),
                    )
                  : Text("Empty"),
            ),
            Text(
              widget.organization.orgName!,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 24.0, // Adjust the font size as needed
              ),
            ),
            Text(
              widget.organization.contactNumber!,
              style: const TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            const Expanded(
              child: Column(
                children: [
                  Text(
                    "This is a description This is a description This is a description This is a description This is a description",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      color: Colors.grey,
                      fontSize: 12.0,
                    ),
                  ),
                ],
              ),
            ),
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DonateGoodsPage(
                          organizationId: widget.organization.id!),
                    ),
                  );
                },
                child: const Text(
                  'Donate now',
                  style: TextStyle(
                      color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
