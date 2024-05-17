import 'package:flutter/material.dart';

class UserDonationDetails extends StatefulWidget {
  const UserDonationDetails({Key? key}) : super(key: key);

  @override
  State<UserDonationDetails> createState() => _UserDonationDetailsState();
}

class _UserDonationDetailsState extends State<UserDonationDetails> {
  Widget imageCarousel() {
    return Container(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            width: 100,
            height: 100,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.circular(5) 
            ),
          );
        },
      ),
    );
  }

  bool pickup = true;
  bool completed = false;

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
        title: Text(
          'Donation Details',
          style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Images', style: TextStyle(fontFamily: 'Poppins', fontSize: 14)),
              SizedBox(height: 10),
              imageCarousel(),
              SizedBox(height: 20),
// LOCATION
              Row(
                children: [
                  Icon(
                    Icons.location_pin,
                    color: Color(0xFF37A980),
                  ),
                  Expanded(child: Text("Address goes here")),
                ],
              ),
              SizedBox(height: 20),
// START OF DETAILS
              Expanded(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Category', style: TextStyle(fontFamily: 'Poppins')),
                        Text('Clothes', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Weight', style: TextStyle(fontFamily: 'Poppins')),
                        Text('10kg', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Mode of delivery', style: TextStyle(fontFamily: 'Poppins')),
                        Text('pickup', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                      ],
                    ),
                    SizedBox(height: 20),
                    pickup ? // if pickup
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pickup date', style: TextStyle(fontFamily: 'Poppins')),
                            Text('05/25/2024', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                          ],
                        ),
                    SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Pickup time', style: TextStyle(fontFamily: 'Poppins')),
                            Text('10:10 AM', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                          ],
                        ),
                    SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Contact number', style: TextStyle(fontFamily: 'Poppins')),
                            Text('1234567890', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                          ],
                        ),
                      ],
                    )
                  : Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Drop off date', style: TextStyle(fontFamily: 'Poppins')),
                            Text('05/25/2024', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                          ],
                        ),
                    SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Drop off time', style: TextStyle(fontFamily: 'Poppins')),
                            Text('11:11 AM', style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF818181))),
                          ],
                        )
                      ],
                    ),
                  ],
                ),
              ),
              // END OF DETAILS
              completed
                  ? // IF DONATION COMPLETED
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
                        onPressed: () {},
                        child: const Text(
                          'Completed',
                          style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                        ),
                      ),
                    )
                  : Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Generate QR
                            },
                            child: const Text(
                              'Generate QR',
                              style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                            ),
                          ),
                        ),
                        SizedBox(height: 10),
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.all(10),
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(5)),
                              ),
                            ),
                            onPressed: () {
                              // TODO: Cancel Donation
                            },
                            child: const Text(
                              'Cancel Donation',
                              style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                            ),
                          ),
                        )
                      ],
                    )
            ],
          ),
        ),
      );
  }
}
