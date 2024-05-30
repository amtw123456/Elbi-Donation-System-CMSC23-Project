import 'package:elbi_donation_app/components/donation_card.dart';
import 'package:elbi_donation_app/views/org_views/org_donation_details_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/donor_provider.dart';
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
    final userId = context.read<UserAuthProvider>().user?.uid;

    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<Map<String, dynamic>>(
          future: context.read<UserProvider>().getUserModel(userId!),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final userInformation = snapshot.data!['userModel'];
              final userName = userInformation.username;
              final verificationStatus = userInformation.isApprovedByAdmin;
              print(userInformation.donationsList.length);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 40),
                  Text("Hello, $userName 👋",
                      style: const TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: Color(0xFF37A980))),
                  Row(
                    children: [
                      const Text(
                        "Verification status: ",
                      ),
                      Text(
                        "${verificationStatus ? 'Verified' : 'Unverified'}",
                        style: TextStyle(
                          color: verificationStatus ? Colors.green : Colors.red,
                        ),
                      ),
                    ],
                  ),
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
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    SizedBox(height: 25),
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: userInformation.donationsList.length,
                            itemBuilder: (context, index) {
                              print(userInformation.donationsList[index]);
                              return FutureBuilder<Map<String, dynamic>>(
                                future: context
                                    .read<DonorProvider>()
                                    .getDonationModel(
                                        userInformation.donationsList[index]),
                                builder: (BuildContext context,
                                    AsyncSnapshot<Map<String, dynamic>>
                                        snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.waiting) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  } else if (snapshot.hasError) {
                                    return Text('Error: ${snapshot.error}');
                                  } else if (snapshot.hasData) {
                                    final donationInformation =
                                        snapshot.data!['donationModel'];

                                    return GestureDetector(
                                      child: DonationCard(
                                        donationInformation:
                                            donationInformation,
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        OrgDonationDetails(
                                                          donationDetails:
                                                              donationInformation,
                                                        )))
                                            .then((_) => setState(() {}));
                                      },
                                    );
                                  } else {
                                    return Text('No data available');
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
