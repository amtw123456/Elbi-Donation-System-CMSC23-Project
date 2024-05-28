import 'package:flutter/material.dart';
import 'package:elbi_donation_app/components/organization_card.dart';
import 'package:elbi_donation_app/providers/user_provider.dart';

import 'package:elbi_donation_app/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/user_card.dart';

class AdminDonorsPage extends StatefulWidget {
  const AdminDonorsPage({super.key});

  @override
  State<AdminDonorsPage> createState() => _AdminDonorsPageState();
}

class _AdminDonorsPageState extends State<AdminDonorsPage> {
  @override
  Widget build(BuildContext context) {
    final futureDonorsList = context.read<UserProvider>().getDonors();
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Text("Hello, admin 👋",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF37A980))),
            Text("Here are the registered donors",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<dynamic>(
                      future: futureDonorsList,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          if (snapshot.data!['success']) {
                            final donors = snapshot.data!['donors'];
                            print(donors);
                            return ListView.separated(
                              separatorBuilder:
                                  (BuildContext context, int index) =>
                                      const SizedBox(height: 25),
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: donors.length,
                              itemBuilder: (context, index) {
                                return ListTile(
                                  leading: Icon(Icons.person),
                                  title: Text(donors[index].firstName +
                                      " " +
                                      donors[index].lastName),
                                  subtitle: Text(donors[index].email),
                                  trailing: Icon(Icons.arrow_forward),
                                  onTap: () {
                                    // Handle tap event
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text(donors[index].firstName),
                                          content: Text('yellow'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Close'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                );
                              },
                            );
                          } else {
                            return const Text('No organizations yet!');
                          }
                        } else if (snapshot.hasError) {
                          return Text('Error: ${snapshot.error}');
                        } else {
                          return const SizedBox(
                            width: 60,
                            height: 60,
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
