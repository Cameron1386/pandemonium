import 'package:flutter/material.dart';

class LessonPageThree extends StatelessWidget {
  const LessonPageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Page 3'),
      ),
      body: const Center(
        child: Text('This is Lesson Page 3'),
      ),
    );
  }
}