import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class SetupPage extends StatefulWidget {
  const SetupPage({super.key});

  @override
  State<SetupPage> createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset('lib/animations/meditatingpanda.json'),
            const Text(
              "Welcome to Level One!",
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
