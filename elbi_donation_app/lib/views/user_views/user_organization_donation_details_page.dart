import 'package:flutter/material.dart';
import 'package:elbi_donation_app/views/user_views/user_donate_goods_page.dart';

class UserOrganizationDetails extends StatefulWidget {
  const UserOrganizationDetails({super.key});

  @override
  State<UserOrganizationDetails> createState() =>
      _UserOrganizationDetailsState();
}

class _UserOrganizationDetailsState
    extends State<UserOrganizationDetails> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // Add this line to center the title
        title: Text("Details", style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),),
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
                fontFamily: 'Poppins',
                color: Colors.black,
                fontSize: 24.0, // Adjust the font size as needed
              ),
            ),
            Text(
              "Contact Number.",
              style: TextStyle(
                fontFamily: 'Poppins',
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
            Expanded(
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
                    padding: EdgeInsets.all(10),
                    backgroundColor: Color(0xFF37A980),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(5)),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DonateGoodsPage()));   
                  },
                  child: const Text(
                    'Donate now',
                    style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
