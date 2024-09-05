import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../dashboard/easy_level.dart';

class ApplicationPage extends StatefulWidget {
  const ApplicationPage({super.key});

  @override
  _ApplicationPageState createState() => _ApplicationPageState();
}

class _ApplicationPageState extends State<ApplicationPage> {
  int score = 0;
  bool hasAnswered = false;
  final TextEditingController _answerController = TextEditingController();

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
      // Simple validation - check if the answer is not empty
      bool isAnswerCorrect = _answerController.text.isNotEmpty;

      if (isAnswerCorrect) {
        setState(() {
          score += 100;
          hasAnswered = true;
        });

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userId = user.uid;

          try {
            await FirebaseFirestore.instance.collection('users').doc(userId).set({
              'score': score,
            }, SetOptions(merge: true));
          } catch (e) {
            print("Failed to update score: $e");
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EasyLevel(),
              settings: RouteSettings(arguments: {'score': score}),
            ),
          );
        } else {
          print("No user is currently logged in.");
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Cybersecurity Application',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Describe a real-world scenario where cybersecurity is crucial.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _answerController,
                maxLines: 3,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Enter your answer here',
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: hasAnswered ? null : _checkAnswer,
              child: const Text('Submit Answer'),
            ),
          ],
        ),
      ),
    );
  }
}