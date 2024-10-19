import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pandemonium/pages/home_page.dart';
import 'package:pandemonium/pages/lessons/advanced_lesson_four/advanced_lesson_four.dart';
import 'package:pandemonium/pages/lessons/advanced_lesson_three/advanced_lesson_three.dart';
import 'package:pandemonium/pages/lessons/advanced_lesson_two/advanced_lesson_two.dart';
import 'package:pandemonium/pages/lessons/advanced_lesson_one/advanced_lesson_one.dart';
import 'package:pandemonium/pages/main_screens/home_content.dart';
import '../../components/lesson_tile.dart';
import 'package:pandemonium/models/lesson_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HardLevel extends StatefulWidget {
  const HardLevel({super.key});

  @override
  State<HardLevel> createState() => _HardLevelState();
}

class _HardLevelState extends State<HardLevel> {
  final LessonDashboard lessonDashboard = LessonDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.red[900]!, Colors.red[700]!],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              _buildAppBar(),
              Expanded(
                child: _buildLessonList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Use pop instead of pushReplacement
            },
          ),
          Expanded(
            child: Text(
              'Advanced Cybersecurity',
              style: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          _buildScoreWidget(),
        ],
      ),
    );
  }

  Widget _buildScoreWidget() {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const SizedBox(); // Return an empty widget if the user is null
    }

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return const Icon(Icons.error, color: Colors.white);
        }

        int score = 0;
        if (snapshot.hasData && snapshot.data!.exists) {
          final data = snapshot.data!.data() as Map<String, dynamic>;
          score = data['advancedScore'] ?? data['score'] ?? 0; // Safe access to score
        }

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.security, color: Colors.amber, size: 16),
              const SizedBox(width: 4),
              Text(
                '$score',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLessonList() {
    return ListView.builder(
      padding: const EdgeInsets.all(8),
      itemCount: lessonDashboard.advancedLessons.length,
      itemBuilder: (context, index) {
        final lesson = lessonDashboard.advancedLessons[index];
        return _buildLessonCard(lesson, index);
      },
    );
  }

  Widget _buildLessonCard(Lesson lesson, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () => _navigateToLesson(index),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Advanced Lesson ${index + 1}',
                      style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Icon(
                    lesson.isCompleted ? Icons.security : Icons.security_outlined,
                    color: lesson.isCompleted ? Colors.red : Colors.grey,
                    size: 18,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                lesson.title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 4),
              Text(
                lesson.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 12,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 14, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${lesson.duration} mins',
                    style: TextStyle(color: Colors.grey[600], fontSize: 12),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _navigateToLesson(index),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red[900],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    ),
                    child: Text(
                      lesson.isCompleted ? 'Review' : 'Start',
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigateToLesson(int index) {
    switch (index) {
      case 0:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdvancedLessonOne()),
        );
        break;
      case 1:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdvancedLessonTwo()),
        );
        break;
      case 2:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdvancedLessonThree()),
        );
        break;
      case 3:
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AdvancedLessonFour()),
        );
        break;
    }
  }
}

class Lesson {
  final String title;
  final String description;
  final int duration;
  final bool isCompleted;
  final List<String> objectives;

  Lesson({
    required this.title,
    required this.description,
    required this.duration,
    this.isCompleted = false,
    required this.objectives,
  }) : assert(title != null && description != null && duration != null);
}

class LessonDashboard {
  final List<Lesson> advancedLessons = [
    Lesson(
      title: 'Advanced Networking and Security Protocols',
      description: 'Deep dive into network security protocols and advanced threat detection techniques.',
      duration: 45,
      isCompleted: false,
      objectives: [
        'Understand advanced networking concepts and protocols',
        'Analyze complex network security architectures',
        'Implement and configure advanced security protocols',
        'Detect and mitigate sophisticated network-based attacks',
      ],
    ),
    Lesson(
      title: 'Cryptography and Secure Communication',
      description: 'Explore advanced cryptographic algorithms and secure communication protocols.',
      duration: 60,
      isCompleted: false,
      objectives: [
        'Understand advanced cryptographic algorithms',
        'Implement and analyze secure communication protocols',
        'Explore quantum cryptography and its implications',
        'Design and evaluate cryptographic systems',
      ],
    ),
    Lesson(
      title: 'Advanced Malware Analysis and Reverse Engineering',
      description: 'Learn techniques for analyzing complex malware and reverse engineering software.',
      duration: 75,
      isCompleted: false,
      objectives: [
        'Perform static and dynamic malware analysis',
        'Use advanced reverse engineering tools and techniques',
        'Analyze obfuscated and polymorphic malware',
        'Develop custom tools for malware analysis and detection',
      ],
    ),
    Lesson(
      title: 'Advanced Penetration Testing and Ethical Hacking',
      description: 'Master advanced techniques for identifying and exploiting complex vulnerabilities.',
      duration: 90,
      isCompleted: false,
      objectives: [
        'Conduct advanced penetration testing on complex systems',
        'Exploit zero-day vulnerabilities and develop custom exploits',
        'Perform advanced social engineering attacks',
        'Implement and bypass advanced defensive measures',
      ],
    ),
  ];
}
