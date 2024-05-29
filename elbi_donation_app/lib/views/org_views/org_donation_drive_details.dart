import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';
import 'package:elbi_donation_app/components/donation_card.dart';
import 'package:flutter/material.dart';

class OrgDonationDriveDetails extends StatefulWidget {
  final String donationDriveId;
  const OrgDonationDriveDetails({required this.donationDriveId, super.key});

  @override
  State<OrgDonationDriveDetails> createState() =>
      _OrgDonationDriveDetailsState();
}

class _OrgDonationDriveDetailsState extends State<OrgDonationDriveDetails> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // Add this line to center the title
        title: Text(
          "Details",
          style: TextStyle(fontFamily: 'Poppins', fontWeight: FontWeight.w700),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: context
            .read<OrganizationProvider>()
            .getDonationDriveModel(widget.donationDriveId),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              width: double.infinity,
              height: 400,
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final donationDriveDetails = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 32.0,
                  vertical: 8.0), // Adjust the horizontal padding as needed
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Edit'), // Dialog title
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Field 1'),
                                  ),
                                  TextField(
                                    decoration:
                                        InputDecoration(labelText: 'Field 2'),
                                  ),
                                ],
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context)
                                        .pop(); // Close the dialog
                                  },
                                  child: Text('Save'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Icon(
                        Icons.edit, // Replace with your desired icon
                        color: Colors.green, // Adjust color as needed
                        size: 20, // Adjust size as needed
                      ),
                    ),
                  ),
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
                    donationDriveDetails['donationDriveModel']
                        .donationDriveName,
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
                          donationDriveDetails['donationDriveModel']
                              .donationDriveDescription,
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
                          )),
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
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              SizedBox(height: 25),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: 5,
                                      itemBuilder: (context, index) {
                                        return DonationCard();
                                      },
                                    ),
                                  ],
                                ),
                              ))),
                        );
                      },
                      child: const Text(
                        'View Donations',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: "Poppins",
                            fontSize: 20),
                      ),
                    ),
                  ),
                ],
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
