import 'package:flutter/material.dart';
import 'package:elbi_donation_app/models/user_model.dart';
import '../../components/donation_card.dart';

class AdminOrganizationDetails extends StatefulWidget {
  AdminOrganizationDetails({super.key, required this.organization});

  UserModel organization;

  @override
  State<AdminOrganizationDetails> createState() =>
      AdminOrganizationDetailsState();
}

class AdminOrganizationDetailsState extends State<AdminOrganizationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text('Details',
              style: TextStyle(
                  fontFamily: 'Poppins',
                  fontSize: 24,
                  fontWeight: FontWeight.w700)),
        ),
        body: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                Container(
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(8)),
                  child: Image.network(
                    widget.organization.proofOfLegitimacyImageUrlLink!,
                    fit: BoxFit
                        .cover, // Make the image cover the entire container
                  ),
                ),
                Text(widget.organization.orgName!,
                    style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF37A980))),
                Expanded(
                    child: widget.organization.orgDescription != null
                        ? Text(
                            widget.organization.orgDescription!,
                          )
                        : Text("No description yet!")),
                SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(10),
                            backgroundColor: Color(0xFF37A980),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5)),
                            )),
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.75,
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
                        child: const Text('View Donations',
                            style: TextStyle(
                                color: Colors.white,
                                fontFamily: "Poppins",
                                fontSize: 20)))),
              ],
            )));
  }
}
