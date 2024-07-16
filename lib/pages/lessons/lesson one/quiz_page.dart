import 'package:flutter/material.dart';

class QuizPage extends StatelessWidget {
  final Function(bool) onCheckAnswer;

  const QuizPage({required this.onCheckAnswer, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Quiz Page'),
            const SizedBox(height: 20),
            // Example input field for user to enter answer
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter your answer',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Example logic for checking the answer
                bool isAnswerCorrect = true; // Replace with actual validation logic

                // Call the callback with the result
                onCheckAnswer(isAnswerCorrect);
              },
              child: const Text('Check Answer'),
            ),
          ],
        ),
      ),
    );
  }
}
