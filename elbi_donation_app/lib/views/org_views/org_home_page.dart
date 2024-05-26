import 'package:elbi_donation_app/components/donation_card.dart';
import 'package:elbi_donation_app/views/org_views/org_donation_details_page.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_app/views/user_views/user_organization_donation_details_page.dart';

import '../../components/organization_card.dart';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({super.key});

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 40),
            Text("Hello, userName 👋",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF37A980))),
            Text("Here are the recent donations made by users:",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16)),
            SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      padding: EdgeInsets.zero,
                      separatorBuilder: (BuildContext context, int index) =>
                          SizedBox(height: 25),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        OrgDonationDetails()));
                          },
                          child: DonationCard(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
