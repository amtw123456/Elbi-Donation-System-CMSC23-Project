import 'package:flutter/material.dart';
import 'package:elbi_donation_app/views/user_views/user_donate_goods_page.dart';

class OrganizationDonationDetailsPage extends StatefulWidget {
  const OrganizationDonationDetailsPage({super.key});

  @override
  State<OrganizationDonationDetailsPage> createState() =>
      _OrganizationDonationDetailsPageState();
}

class _OrganizationDonationDetailsPageState
    extends State<OrganizationDonationDetailsPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // Add this line to center the title
        title: Text("Details"),
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
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Text(
                "This container takes the maximum width available and has borders.",
              ),
            ),
            Text(
              "Organization Title here.",
              style: TextStyle(
                color: Colors.black,
                fontSize: 24.0, // Adjust the font size as needed
              ),
            ),
            Text(
              "Contact Number.",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            Text(
              "This is a description This is a description This is a description This is a description This is a description",
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4))),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => const DonateGoodsPage(),
                    ),
                  );
                },
                child: const Text('Donate'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
