import 'package:elbi_donation_app/providers/user_provider.dart';
import 'package:elbi_donation_app/providers/auth_provider.dart';
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
    final userId = context.read<UserAuthProvider>().user?.uid;
    final futureOrgList =
        context.read<UserProvider>().getAllVerifiedOrganizations();

    return Scaffold(
      backgroundColor: const Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: FutureBuilder<Map<String, dynamic>>(
          future: context.read<UserProvider>().getUserModel(userId!),
          builder: (BuildContext context,
              AsyncSnapshot<Map<String, dynamic>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              final userInformation = snapshot.data!;

              // Assuming the user's name is stored under 'firstname' key
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),
                  FutureBuilder<Map<String, dynamic>>(
                    future: context.read<UserProvider>().getUserModel(userId),
                    builder: (BuildContext context,
                        AsyncSnapshot<Map<String, dynamic>> snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        final userInformation = snapshot.data!;
                        final userName = userInformation['userModel'].username;
                        return Text(
                          "Hello, $userName 👋",
                          style: const TextStyle(
                            fontFamily: 'Poppins',
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF37A980),
                          ),
                        );
                      } else {
                        return const Text('No data available');
                      }
                    },
                  ),
                  const Text(
                      "Here are some organizations that might interest you",
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
                                    final organizations =
                                        snapshot.data!['orgs'];
                                    return ListView.separated(
                                      separatorBuilder:
                                          (BuildContext context, int index) =>
                                              const SizedBox(height: 25),
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
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
                                                ),
                                              ),
                                            );
                                          },
                                          child: OrganizationCard(
                                            organization: organizations[index],
                                            userType:
                                                userInformation['userModel']
                                                    .type,
                                          ),
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
                              })
                        ],
                      ),
                    ),
                  )
                ],
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
