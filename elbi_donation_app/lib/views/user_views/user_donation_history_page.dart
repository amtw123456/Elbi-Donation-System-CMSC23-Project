import 'package:flutter/material.dart';

import '../../components/donation_card.dart';
import 'user_donate_details_page.dart';

import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/models/donation_model.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:elbi_donation_app/providers/donor_provider.dart';
import 'package:provider/provider.dart';

class UserDonationHistory extends StatefulWidget {
  const UserDonationHistory({super.key});

  @override
  State<UserDonationHistory> createState() => _UserDonationHistoryState();
}

class _UserDonationHistoryState extends State<UserDonationHistory> {
  @override
  Widget build(BuildContext context) {
    final userId = context.read<UserAuthProvider>().user?.uid;
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation History',
            style: TextStyle(
                fontFamily: 'Poppins',
                fontSize: 24,
                fontWeight: FontWeight.w700)),
        centerTitle: true,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: context.read<UserProvider>().getUserModel(userId!),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final userInformation = snapshot.data!['userModel'];
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(30),
                child: Column(
                  children: [
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) =>
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
                              AsyncSnapshot<Map<String, dynamic>> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator());
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (snapshot.hasData) {
                              final donationInformation =
                                  snapshot.data!['donationModel'];
                              print("blue");
                              print(snapshot.data);
                              return GestureDetector(
                                child: DonationCard(
                                  donationInformation: donationInformation,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              UserDonationDetails()));
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
            );
          } else {
            return Text('No data available');
          }
        },
      ),
    );
  }
}
