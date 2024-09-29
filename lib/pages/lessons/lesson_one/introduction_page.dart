import 'package:flutter/material.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: const SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                ),
                SizedBox(height: 20),
                Text(
                  "Welcome to Cybersecurity",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                Text(
                  "In this course, you'll learn how to keep yourself safe in the digital world. Let's jump right in!",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Text(
                  "Cybersecurity is crucial today more than ever. With increasing reliance on digital technologies, understanding how to protect yourself from cyber threats is essential.",
                  style: TextStyle(fontSize: 16),
                ),
                SizedBox(height: 20),
                Center(
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}