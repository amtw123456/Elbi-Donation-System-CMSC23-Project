import 'package:flutter/material.dart';

class DonateGoodsPage extends StatefulWidget {
  const DonateGoodsPage({super.key});

  @override
  State<DonateGoodsPage> createState() => _DonateGoodsPageState();
}

class _DonateGoodsPageState extends State<DonateGoodsPage> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true, // Add this line to center the title
        title: Text("Donate Goods"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 32.0,
            vertical: 8.0), // Adjust the horizontal padding as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [],
        ),
      ),
    );
  }
}
