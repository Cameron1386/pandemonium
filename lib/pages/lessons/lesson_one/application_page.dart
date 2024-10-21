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

  Future<void> _fetchUserScore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> data = userDoc.data() as Map<String, dynamic>;
        setState(() {
          score = data['score'] ?? 0;
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

      bool isAnswerCorrect = _answerController.text.isNotEmpty;  // Basic validation

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
      backgroundColor: const Color(0xFF0D1B2A), // Dark theme background color
      body: Center(
        child: isLoading
            ? const CircularProgressIndicator(color: Colors.teal)
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Cybersecurity Application',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Describe a real-world scenario where cybersecurity is crucial.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      const SizedBox(height: 20),
                      TextField(
                        controller: _answerController,
                        maxLines: 3,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[300]!),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[300]!),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.teal[300]!),
                          ),
                          hintText: 'Enter your answer here',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: hasAnswered ? null : _checkAnswer,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal[300],
                          disabledBackgroundColor: Colors.grey,
                        ),
                        child: const Text('Submit Answer', style: TextStyle(color: Colors.white)),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Current Score: $score',
                        style: const TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        feedbackMessage,
                        style: TextStyle(fontSize: 16, color: hasAnswered ? Colors.green[300] : Colors.red[300]),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}