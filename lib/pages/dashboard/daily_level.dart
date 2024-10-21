import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class DailyLevel extends StatefulWidget {
  const DailyLevel({Key? key}) : super(key: key);

  @override
  _DailyLevelState createState() => _DailyLevelState();
}

class _DailyLevelState extends State<DailyLevel> {
  final Map<String, List<String>> categories = {
    'Network Security': [],
    'Encryption': [],
    'Access Control': [],
  };

  final List<String> terms = [
    'Firewall',
    'VPN',
    'AES',
    'RSA',
    'Two-Factor Authentication',
    'Biometrics',
  ];

  final Map<String, String> correctCategoryMapping = {
    'Firewall': 'Network Security',
    'VPN': 'Network Security',
    'AES': 'Encryption',
    'RSA': 'Encryption',
    'Two-Factor Authentication': 'Access Control',
    'Biometrics': 'Access Control',
  };

  int score = 0;
  bool isLoading = false;
  bool hasAnswered = false;
  String feedbackMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  // Initialize Firebase and fetch user's score
  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
    _fetchUserScore();
  }

  // Fetch score from Firebase for the authenticated user
  Future<void> _fetchUserScore() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        setState(() {
          score = userDoc['score'] ?? 0;  // Set score from Firestore or default to 0
        });
      }
    }
  }

  // Update score in Firestore for the authenticated user
  Future<void> _updateScoreInFirebase(int newScore) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      try {
        await FirebaseFirestore.instance.collection('users').doc(userId).set({
          'score': newScore,  // Update score in Firestore
        }, SetOptions(merge: true));  // Merge to avoid overwriting
      } catch (e) {
        setState(() {
          feedbackMessage = "Failed to update score: $e";
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A), // Dark theme background color
      appBar: AppBar(
        title: Text(
          'Cybersecurity Challenge\nScore: $score',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20, color: Colors.white),
        ),
        backgroundColor: const Color(0xFF1B263B), // Dark theme AppBar color
        elevation: 5.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetCategories,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories.keys.elementAt(index);
                  return buildCategoryTarget(category);
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            buildTermPool(),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryTarget(String category) {
  return DragTarget<String>(
    builder: (context, candidateData, rejectedData) {
      bool isDraggingOver = candidateData.isNotEmpty;
      return Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5.0,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: isDraggingOver ? Colors.teal[50] : const Color(0xFF1B263B), // Dark-themed card
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                category,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: categories[category]!
                    .map((term) => Draggable<String>(
                          data: term,
                          feedback: Material(
                            child: buildTermChip(term),
                            elevation: 6.0,
                            color: Colors.transparent,
                          ),
                          childWhenDragging: buildTermChip(term, Colors.grey[300]),
                          child: buildTermChip(term),
                        ))
                    .toList(),
              ),
            ],
          ),
        ),
      );
    },
    onWillAcceptWithDetails: (DragTargetDetails<String> details) {
      // Accept the drag only if the term is not already in the category
      return !categories[category]!.contains(details.data);
    },
    onAcceptWithDetails: (DragTargetDetails<String> details) {
      // Process the drag details
      final String draggedTerm = details.data;
      setState(() {
        bool isCorrect = correctCategoryMapping[draggedTerm] == category;

        _removeFromAllCategories(draggedTerm);

        if (isCorrect) {
          score += 100;  // Increment score by 100
          _updateScoreInFirebase(score);  // Update score in Firestore
          feedbackMessage = 'Correct! Your score has been updated.';
        } else {
          score -= 50;  // Deduct points for incorrect answer
          _updateScoreInFirebase(score);  // Update score in Firestore
          feedbackMessage = 'Incorrect! You lost some points.';
        }

        categories[category]!.add(draggedTerm);
        terms.remove(draggedTerm);

        // Show feedback with a SnackBar
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
            feedbackMessage,
            style: TextStyle(color: isCorrect ? Colors.green : Colors.red),
          ),
          duration: const Duration(seconds: 2),
        ));
      });
    },
  );
}

Widget buildTermPool() {
  return DragTarget<String>(
    builder: (context, candidateData, rejectedData) {
      return Container(
        height: 120,
        decoration: BoxDecoration(
          color: const Color(0xFF1B263B), // Dark pool background
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 3,
              blurRadius: 6,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: terms.length,
          itemBuilder: (context, index) {
            return Draggable<String>(
              data: terms[index],
              feedback: Material(
                child: buildTermChip(terms[index]),
                elevation: 6.0,
                color: Colors.transparent,
              ),
              childWhenDragging: buildTermChip(terms[index], Colors.grey[300]),
              child: buildTermChip(terms[index]),
            );
          },
        ),
      );
    },
    onWillAcceptWithDetails: (DragTargetDetails<String> details) {
      // Always accept drag operation in the term pool
      return true;
    },
    onAcceptWithDetails: (DragTargetDetails<String> details) {
      final String draggedTerm = details.data;
      setState(() {
        if (!terms.contains(draggedTerm)) {
          terms.add(draggedTerm);
        }
      });
    },
  );
}

  void _removeFromAllCategories(String term) {
    categories.forEach((category, termsList) {
      if (termsList.contains(term)) {
        termsList.remove(term);
      }
    });
  }

  void resetCategories() {
    setState(() {
      terms.clear();
      terms.addAll([
        'Firewall',
        'VPN',
        'AES',
        'RSA',
        'Two-Factor Authentication',
        'Biometrics',
      ]);
      categories.forEach((key, value) {
        value.clear();
      });
      score = 0;  // Reset score locally
      _updateScoreInFirebase(score);  // Reset score in Firestore
    });
  }

  Widget buildTermChip(String term, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(term, style: const TextStyle(fontSize: 16, color: Colors.white)), // White text for chips
        backgroundColor: color ?? Colors.teal[300], // Chip color
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
