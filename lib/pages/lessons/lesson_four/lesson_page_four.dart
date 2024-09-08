import 'package:flutter/material.dart';

class LessonPageFour extends StatelessWidget {
  const LessonPageFour({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lesson Page 4'),
      ),
      body: const Center(
        child: Text('This is Lesson Page 4'),
      ),
    );
  }
}