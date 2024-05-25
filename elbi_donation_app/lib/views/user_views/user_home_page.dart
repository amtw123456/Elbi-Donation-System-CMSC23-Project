import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_app/views/user_views/user_organization_donation_details_page.dart';
import 'package:provider/provider.dart';

import '../../components/organization_card.dart';

class UserHomePage extends StatefulWidget {
  const UserHomePage({super.key});

  @override
  State<UserHomePage> createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final futureOrgList = context.read<UserProvider>().getOrganizations();
    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40),
            const Text("Hello, userName 👋",
                style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF37A980))),
            const Text("Here are some organizations that might interest you",
                style: TextStyle(fontFamily: 'Poppins', fontSize: 16)),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FutureBuilder<dynamic>(
                        future: futureOrgList,
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            if (snapshot.data!['success']) {
                              final organizations = snapshot.data!['orgs'];
                              return ListView.separated(
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const SizedBox(height: 25),
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: organizations.length,
                                itemBuilder: (context, index) {
                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    UserOrganizationDetails(
                                                      organization:
                                                          organizations[index],
                                                    )));
                                      },
                                      child: OrganizationCard(
                                          organization: organizations[index]));
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
                        })
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
