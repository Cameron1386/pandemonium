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
  bool isLoading = false;
  String feedbackMessage = '';
  final TextEditingController _answerController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    _fetchUserScore();
  }

  // Fetch the existing score from Firebase
  Future<void> _fetchUserScore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          score = data['score'] ?? 0;  // Use existing score if available
        });
      }
    }
  }

  void _checkAnswer() async {
    if (_answerController.text.isEmpty) {
      setState(() {
        feedbackMessage = "Answer cannot be empty.";
      });
      return;
    }

    if (!hasAnswered) {
      setState(() {
        isLoading = true;
      });

      bool isAnswerCorrect = _answerController.text.isNotEmpty;  // Assuming a basic non-empty validation for now

      if (isAnswerCorrect) {
        setState(() {
          score += 100;
          hasAnswered = true;
          feedbackMessage = 'Your answer is submitted successfully!';
        });

        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          String userId = user.uid;

          try {
            // Merge score update with existing data
            await FirebaseFirestore.instance.collection('users').doc(userId).set({
              'score': score,
            }, SetOptions(merge: true));
          } catch (e) {
            setState(() {
              feedbackMessage = "Failed to update score: $e";
            });
          }

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const EasyLevel(),
              settings: RouteSettings(arguments: {'score': score}),
            ),
          );
        } else {
          setState(() {
            feedbackMessage = "No user is currently logged in.";
          });
        }
      }

      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator()
            : Column(
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
                  const SizedBox(height: 20),
                  Text(
                    'Current Score: $score',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    feedbackMessage,
                    style: TextStyle(fontSize: 16, color: hasAnswered ? Colors.green : Colors.red),
                  ),
                ],
              ),
      ),
    );
  }
}
