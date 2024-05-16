import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(""),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: 32.0), // Adjust the horizontal padding as needed
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Hello, Name 👋",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 167, 235, 211),

                fontSize: 24.0, // Adjust the font size as needed
              ),
            ),
            const Text("Where do you want to donate today?"),
            const SizedBox(height: 8.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      height: screenHeight / 3,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            height: 150,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                                width: 1.0,
                              ),
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                          ),
                          const Text(
                            "Organization name here",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black,

                              fontSize: 16.0, // Adjust the font size as needed
                            ),
                          ),
                          Text(
                            "short description here. One or two sentences maybe",
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: screenHeight / 3,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "This container takes the maximum width available and has borders.",
                      ),
                    ),
                    SizedBox(height: 8.0),
                    Container(
                      width: double.infinity,
                      height: screenHeight / 3,
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Text(
                        "This container takes the maximum width available and has borders.",
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              height: 20,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [Text("Buttons"), Text("Buttons"), Text("Buttons")],
              ),
            )
          ],
        ),
      ),
    );
  }
}
