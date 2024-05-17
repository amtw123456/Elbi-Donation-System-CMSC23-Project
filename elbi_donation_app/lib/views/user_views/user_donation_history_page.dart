import 'package:flutter/material.dart';

import '../../components/donation_card.dart';
import 'user_donate_details_page.dart';

class UserDonationHistory extends StatefulWidget {
  const UserDonationHistory({super.key});

  @override
  State<UserDonationHistory> createState() => _UserDonationHistoryState();
}

class _UserDonationHistoryState extends State<UserDonationHistory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Donation History', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700)),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: Column(
            
            children: [
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    child: DonationCard(),
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => UserDonationDetails()));
                    },
                  );
                },
              ),
            ],
          ), 
        ) 
      ) 
    );
  }
}
