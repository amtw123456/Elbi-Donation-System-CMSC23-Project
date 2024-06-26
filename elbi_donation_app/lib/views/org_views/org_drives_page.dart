import 'package:elbi_donation_app/components/drive_card.dart';
import 'package:elbi_donation_app/providers/organization_provider.dart';
import 'package:elbi_donation_app/views/org_views/org_donation_drive_creation.dart';
import 'package:elbi_donation_app/views/org_views/org_donation_drive_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';

import '../../components/donation_card.dart';

class OrgDonationDrivePage extends StatefulWidget {
  const OrgDonationDrivePage({super.key});

  @override
  State<OrgDonationDrivePage> createState() => OrgDonationDrivePageState();
}

class OrgDonationDrivePageState extends State<OrgDonationDrivePage> {
  bool shouldReload = false; // State variable to trigger a reload

  void handleDeletion() {
    // Callback function to handle deletion
    setState(() {
      // Trigger a rebuild of the parent widget
      shouldReload = !shouldReload;
    });
  }

  @override
  Widget build(BuildContext context) {
    String? userId = context.read<UserAuthProvider>().user?.uid ?? "";
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Donation Drives',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 24,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: context.read<UserProvider>().getUserModel(userId),
        builder: (BuildContext context,
            AsyncSnapshot<Map<String, dynamic>> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // return const Center(child: CircularProgressIndicator());
            return Container(); // return an empty container instead so that loading icon wont overlap on other loading icons
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            final userInformation = snapshot.data!;
            final organizationDriveIds =
                userInformation['userModel'].organizationDriveList;
            return organizationDriveIds.length == 0
                ? const Center(child: Text("No Donation Drives yet!"))
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          ListView.separated(
                            separatorBuilder:
                                (BuildContext context, int index) =>
                                    const SizedBox(height: 25),
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: organizationDriveIds.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                child: DonationDriveCard(
                                    organizationId: userId,
                                    donationDriveId:
                                        organizationDriveIds[index],
                                    onDeletion: handleDeletion),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          OrgDonationDriveDetails(
                                        donationDriveId:
                                            organizationDriveIds[index],
                                        organizationId: userId,
                                      ),
                                    ),
                                  ).then((_) => setState(() {}));
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
          } else {
            return const Text('No data available');
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final value = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddDonationDrive()),
          ).then((_) => setState(() {}));
        },
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(
          Icons.add,
          color: Color(0xFF37A980),
        ),
      ),
    );
  }
}
