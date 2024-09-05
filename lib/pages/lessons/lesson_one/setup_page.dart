import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SetupPage extends StatelessWidget {
  const SetupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/animations/meditatingpanda.json'), // Replace with your panda animation
            const SizedBox(height: 20),
            const Text(
              "Welcome to Cybersecurity!",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "I'm Harry, and I'll guide you through keeping yourself safe in the digital world.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the next page or start the lesson
              },
              child: const Text("Let's Begin!"),
            ),
          ],
        ),
      ),
    );
  }
}