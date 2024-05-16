import 'package:flutter/material.dart';

import '../../components/donation_card.dart';

class AdminOrganizationDetails extends StatefulWidget {
  const AdminOrganizationDetails({super.key});

  @override
  State<AdminOrganizationDetails> createState() => AdminOrganizationDetailsState();
}

class AdminOrganizationDetailsState extends State<AdminOrganizationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Details', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Container(
              height: 300,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(8) 
              ),
            ),
            Text('Organization name here', style: TextStyle(fontFamily: "Poppins", fontSize: 24, fontWeight: FontWeight.w700, color: Color(0xFF37A980))),
            Expanded(child: Text('More information about the organization')),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.all(10),
                  backgroundColor: Color(0xFF37A980),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5)),
                  )
                ), 
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => Container(
                      height: MediaQuery.of(context).size.height * 0.75,
                      decoration: new BoxDecoration(
                        color: Colors.white,
                        borderRadius: new BorderRadius.only(
                          topLeft: const Radius.circular(25.0),
                          topRight: const Radius.circular(25.0),
                        ),
                      ),
                      child: SingleChildScrollView(
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
                                  return DonationCard();
                                },
                              ),
                            ],
                          ), 
                        ) 
                      ) 
                    ),
                  );
                }, 
                child: const Text('View Donations', style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20)
                )
              )
            ),
          ],
        ) 
      ) 
    );
  }
}