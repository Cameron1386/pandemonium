import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class IntroPage2 extends StatefulWidget {
  const IntroPage2({super.key});

  @override
  State<IntroPage2> createState() => _IntroPage1State();
}

class _IntroPage1State extends State<IntroPage2> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 0, 203, 255),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/animations/sleepingpanda.json'),
            const Text(
              "Protect your peace!",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

