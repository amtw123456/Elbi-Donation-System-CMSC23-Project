import 'package:elbi_donation_app/components/organization_card.dart';
import 'package:elbi_donation_app/screens/admin/admin_nav_bar.dart';
import 'package:flutter/material.dart';

class AdminOrganizationPage extends StatefulWidget {
  const AdminOrganizationPage({super.key});

  @override
  State<AdminOrganizationPage> createState() => _AdminOrganizationPageState();
}

class _AdminOrganizationPageState extends State<AdminOrganizationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F8F8),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 25),
            Text("Hello, admin 👋", style: TextStyle(fontFamily: 'Poppins', fontSize: 32, fontWeight: FontWeight.w700, color: Color(0xFF37A980))),
            Text("Here are the organizations that are accepting donations", style: TextStyle(fontFamily: 'Poppins', fontSize: 16)),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => SizedBox(height: 25),
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: 5,
                      itemBuilder: (context, index) {
                        return OrganizationCard();
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