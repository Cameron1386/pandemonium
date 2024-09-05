import 'package:flutter/material.dart';

class LessonPageTwo extends StatelessWidget {
  const LessonPageTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Page 2'),
      ),
      body: const Center(
        child: Text('This is Lesson Page 2'),
      ),
    );
  }
}