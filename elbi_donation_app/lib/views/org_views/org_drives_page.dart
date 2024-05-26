import 'package:elbi_donation_app/components/drive_card.dart';
import 'package:elbi_donation_app/views/org_views/org_donation_drive_creation.dart';
import 'package:elbi_donation_app/views/org_views/org_donation_drive_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';

import '../../components/donation_card.dart';

class OrgDonationDrivePage extends StatefulWidget {
  const OrgDonationDrivePage({super.key});

  @override
  State<OrgDonationDrivePage> createState() => OrgDonationDrivePageState();
}

class OrgDonationDrivePageState extends State<OrgDonationDrivePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Donation Drives',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            children: [
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) =>
                    SizedBox(height: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: DonationDriveCard(),
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrgDonationDriveDetails()));
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => AddDonationDrive()));
        },
        child: Icon(
          Icons.add,
          color: Color(0xFF37A980),
        ),
        backgroundColor: Colors.white,
        shape: CircleBorder(),
      ),
    );
  }
}
