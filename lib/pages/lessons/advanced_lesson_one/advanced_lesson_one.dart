import 'package:flutter/material.dart';

class AdvancedLessonOne extends StatelessWidget {
  const AdvancedLessonOne({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Advanced Lesson 1'),
      ),
      body: const Center(
        child: Text('This is Advanced Lesson 1'),
      ),
    );
  }
}