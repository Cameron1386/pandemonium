import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../components/lesson_tile.dart';
import '../lessons/lesson_one/lesson_page_one.dart';
import '../lessons/lesson_two/lesson_page_two.dart';
import 'package:pandemonium/models/lesson_dashboard.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EasyLevel extends StatefulWidget {
  const EasyLevel({Key? key}) : super(key: key);

  @override
  State<EasyLevel> createState() => _EasyLevelState();
}

class _EasyLevelState extends State<EasyLevel> {
  final LessonDashboard lessonDashboard = LessonDashboard();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.green[700]!, Colors.green[300]!],
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
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Text(
            'Cybersecurity Basics',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          _buildScoreWidget(),
        ],
      ),
    );
  }

  Widget _buildScoreWidget() {
    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseAuth.instance.currentUser != null
          ? FirebaseFirestore.instance
              .collection('users')
              .doc(FirebaseAuth.instance.currentUser!.uid)
              .snapshots()
          : null,
      builder: (context, snapshot) {
        int score = 0;
        if (snapshot.hasData && snapshot.data!.exists) {
          score = snapshot.data!['score'] ?? 0;
        }
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            children: [
              const Icon(Icons.star, color: Colors.amber, size: 20),
              const SizedBox(width: 5),
              Text(
                '$score',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
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
      padding: const EdgeInsets.all(16),
      itemCount: lessonDashboard.lessons.length,
      itemBuilder: (context, index) {
        final lesson = lessonDashboard.lessons[index];
        return _buildLessonCard(lesson, index);
      },
    );
  }

  Widget _buildLessonCard(Lesson lesson, int index) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => _navigateToLesson(index),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Lesson ${index + 1}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Icon(
                    lesson.isCompleted ? Icons.check_circle : Icons.circle_outlined,
                    color: lesson.isCompleted ? Colors.green : Colors.grey,
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                lesson.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                lesson.description,
                style: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 4),
                  Text(
                    '${lesson.duration} mins',
                    style: TextStyle(color: Colors.grey[600], fontSize: 14),
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () => _navigateToLesson(index),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green[700],
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(lesson.isCompleted ? 'Review' : 'Start'),
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
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LessonPageOne()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const LessonPageTwo()),
      );
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
  });
}

class LessonDashboard {
  final List<Lesson> lessons = [
    Lesson(
      title: 'Welcome to Cybersecurity',
      description: 'Meet Harry and learn about the importance of cybersecurity in today\'s digital world.',
      duration: 15,
      isCompleted: false,
      objectives: [
        'Understand the basics of cybersecurity and its importance',
        'Recognize common cyber threats and their impact',
        'Learn practical steps to safeguard personal information',
        'Navigate the digital world safely and responsibly',
      ],
    ),
    Lesson(
      title: 'Definition and Key Concepts',
      description: 'Explore the CIA triad: Confidentiality, Integrity, and Availability.',
      duration: 20,
      isCompleted: false,
      objectives: [
        'Define cybersecurity',
        'Understand the CIA triad',
        'Explore real-world examples of cyber threats',
        'Interact with an infographic on cybersecurity aspects',
      ],
    ),
    // Add more lessons here as needed
  ];
}