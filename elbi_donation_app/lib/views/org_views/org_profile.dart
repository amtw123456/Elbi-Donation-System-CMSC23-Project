import 'package:flutter/material.dart';

class OrgProfile extends StatefulWidget {
  const OrgProfile({super.key});

  @override
  State<OrgProfile> createState() => OrgProfileState();
}

class OrgProfileState extends State<OrgProfile> {
  String statusForDonation = "Open";
  List<String> statusesForDonation = [
    'Open',
    'Close'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 35),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Organization name",
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF37A980),
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Text("Status for donation", style: TextStyle(fontFamily: 'Poppins', color: Color(0xFF37A980), fontSize: 16)),
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
                    value: statusForDonation,
                    onChanged: (String? newValue) {
                      setState(() {
                        statusForDonation = newValue!;
                      });
                    },
                    items: statusesForDonation.map((String status) {
                      return DropdownMenuItem<String>(
                        value: status,
                        child: Text(status, style: TextStyle(fontFamily: 'Poppins')),
                      );
                    }).toList(),
                  ),
                ],
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
                      )
                    ), 
                    onPressed: () {}, 
                    child: const Text('Log out', style: TextStyle(color: Colors.white, fontFamily: "Poppins", fontSize: 20)))),
            ],
          ),
        ),
      ),
    );
  }
}
