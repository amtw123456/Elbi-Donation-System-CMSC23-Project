import 'package:flutter/material.dart';

class OrgDonationDetails extends StatefulWidget {
  const OrgDonationDetails({Key? key}) : super(key: key);

  @override
  State<OrgDonationDetails> createState() => _OrgDonationDetailsState();
}

class _OrgDonationDetailsState extends State<OrgDonationDetails> {



  final _formKey = GlobalKey<FormState>();
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
              borderRadius: BorderRadius.circular(5),
            ),
          );
        },
      ),
    );
  }

  bool pickup = true;
  bool completed = false;
  String selectedStatus = 'Pending';
  List<String> statuses = [
    'Pending',
    'Confirmed',
    'Scheduled for Pick-up',
    'Complete',
    'Canceled'
  ];


  List<String> drives = [
    'Drive 1',
    'Drive 2',
    'Drive 3',
  ];
  String selectedDrive = 'Drive 1';

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
          style: TextStyle(
              fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
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
                Column(
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
                    pickup
                        ? Column(
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
                              ),
                            ],
                          ),
                  ],
                ),
                // END OF DETAILS
                SizedBox(height: 10),
                Text("Edit status", style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF37A980), fontSize: 16)),
  // DROPDOWN FOR STATUS
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    // hintText: 'Pe',
                    // hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  value: selectedStatus,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedStatus = newValue!;
                    });
                  },
                  items: statuses.map((String status) {
                    return DropdownMenuItem<String>(
                      value: status,
                      child: Text(status, style: TextStyle(fontFamily: 'Poppins')),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
                Text("Assign donation drive", style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF37A980), fontSize: 16)),
  // DROPDOWN FOR DONATION DRIVE
                DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    // hintText: 'Pe',
                    // hintStyle: TextStyle(fontFamily: 'Poppins', color: Color(0XFFD2D2D2)),
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0XFFD2D2D2)),
                      borderRadius: BorderRadius.all(Radius.circular(4)),
                    ),
                  ),
                  value: selectedDrive,
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedDrive = newValue!;
                    });
                  },
                  items: drives.map((String drive) {
                    return DropdownMenuItem<String>(
                      value: drive,
                      child: Text(drive, style: TextStyle(fontFamily: 'Poppins')),
                    );
                  }).toList(),
                ),
                SizedBox(height: 10),
  // CONFIRM BUTTON
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
                      'Confirm',
                      style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }
}
