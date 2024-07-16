import 'package:flutter/material.dart';
import '../../components/heat_map.dart';

class StreaksPage extends StatelessWidget {
  const StreaksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Streaks Page'),
      ),
      backgroundColor: Colors.grey[300],
      body: const MyHeatMap(),
    );
  }
}