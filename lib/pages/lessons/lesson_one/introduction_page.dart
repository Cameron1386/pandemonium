import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Dark theme background color
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Center(
                  // You can add an image here if needed
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Cybersecurity",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                ),
                SizedBox(height: 10),
                Text(
                  "In this course, you'll learn how to keep yourself safe in the digital world. Let's jump right in!",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 20),
                Text(
                  "Cybersecurity is crucial today more than ever. With increasing reliance on digital technologies, understanding how to protect yourself from cyber threats is essential.",
                  style: TextStyle(fontSize: 16, color: Colors.white),
                ),
                SizedBox(height: 20),
                Center(
                  // You can add another image here if needed
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}