import 'package:flutter/material.dart';

class EasyLevel extends StatelessWidget {
  const EasyLevel({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Easy Level'),
      ),
      body: const Center(
        child: Text('Easy Level'),
      ),
    );
  }
}