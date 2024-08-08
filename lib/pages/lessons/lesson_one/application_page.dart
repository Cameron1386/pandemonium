import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../dashboard/easy_level.dart';

class ApplicationPage extends StatefulWidget {
  final Function(bool) onCheckAnswer;

  const ApplicationPage({required this.onCheckAnswer, Key? key}) : super(key: key);

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int score = 0;
  bool hasAnswered = false;

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  void _checkAnswer() async {
    if (!hasAnswered) {
      // Example logic for checking the answer
      bool isAnswerCorrect = true; // Replace with actual validation logic

      if (isAnswerCorrect) {
        setState(() {
          score += 100;
          hasAnswered = true;
        });

        // Get current user ID
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userId = user.uid;

          try {
            // Save the score to Firestore
            await FirebaseFirestore.instance.collection('users').doc(userId).set({
              'score': score,
            }, SetOptions(merge: true));
          } catch (e) {
            // Handle error
            print("Failed to update score: $e");
          }

          // Navigate to EasyLevel
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => EasyLevel(),
              settings: RouteSettings(arguments: {'score': score}),
            ),
          );
        } else {
          // Handle the case when the user is not logged in
          print("No user is currently logged in.");
        }
      }

      // Call the callback with the result
      widget.onCheckAnswer(isAnswerCorrect);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Application Page'),
            const SizedBox(height: 20),
            const TextField(
              decoration: InputDecoration(
                labelText: 'Enter your answer',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: hasAnswered ? null : _checkAnswer,
              child: const Text('I\'m done!'),
            ),
          ],
        ),
      ),
    );
  }
}
