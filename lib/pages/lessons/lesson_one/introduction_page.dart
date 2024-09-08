import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroductionPage extends StatelessWidget {
  const IntroductionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                ),
                const SizedBox(height: 20),
                const Text(
                  "Welcome to Cybersecurity",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                const Text(
                  "In this course, you'll learn how to keep yourself safe in the digital world. Let's jump right in!",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Cybersecurity is crucial today more than ever. With increasing reliance on digital technologies, understanding how to protect yourself from cyber threats is essential.",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 20),
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