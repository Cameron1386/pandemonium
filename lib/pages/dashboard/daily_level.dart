import 'package:flutter/material.dart';

class DailyLevel extends StatelessWidget {
  const DailyLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Page'),
      ),
      body: const Center(
        child: Text('Daily Page'),
      ),
    );
  }
}