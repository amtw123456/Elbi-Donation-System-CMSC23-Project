import 'package:flutter/material.dart';

class AdminSignups extends StatefulWidget {
  const AdminSignups({super.key});

  @override
  State<AdminSignups> createState() => _AdminSignupsState();
}

class _AdminSignupsState extends State<AdminSignups> {
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
        title: Text('Sign ups', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, fontWeight: FontWeight.w700)),
      ),
      body: Padding(
        padding: EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.separated(
                separatorBuilder: (BuildContext context, int index) => SizedBox(height: 25),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                    color: Colors.green
                                    ),
                                  ),
                                  Text('Organization name', style: TextStyle(fontFamily: 'Poppins', fontSize: 24, color: Color(0xFF37A980))),
                                  Text('More description here'),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Row(
                                    children: [
                                      Expanded(
                                        child: OutlinedButton(
                                        onPressed: () {}, //TODO: Add rejection logic 
                                        child: Text("Reject", style: TextStyle(color: Colors.red, fontFamily: 'Poppins', )),
                                        style: OutlinedButton.styleFrom(
                                          side: BorderSide(width: 2, color: Colors.red),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5),
                                          )
                                        )
                                      ),
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(
                                        child: ElevatedButton(
                                        onPressed: () {}, //TODO: Add confirm logic 
                                        child: Text("Confirm", style: TextStyle(color: Colors.white, fontFamily: 'Poppins',)),
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: Color(0xFF37A980),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(5)
                                          )
                                        ),
                                      )
                                      )
                                    ],
                                  )
                                  )
                                  
                                ],
                              ), 
                            ) 
                          ) 
                        ),
                      );
                    },
                    child: Container(
                      height: 75,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0
                        ),
                        borderRadius: BorderRadius.circular(5) 
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.person),
                          Text("Organization name", style: TextStyle(fontFamily: 'Poppins', fontSize: 16))
                        ],
                      ),
                    )
                  ) ;
                },
              ),
            ]
          ),
        ),
      )
    );
  }
}