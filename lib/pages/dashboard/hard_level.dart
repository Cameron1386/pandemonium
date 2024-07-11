import 'package:flutter/material.dart';

class HardLevel extends StatelessWidget {
  const HardLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Hard Level'),
      ),
      body: const Center(
        child: Text('Hard Level'),
      ),
    );
  }
}