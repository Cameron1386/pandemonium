import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pandemonium/pages/main_screens/home_content.dart';
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
      appBar: AppBar(
        title: const Text('Easy Level'),
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // Use Navigator.pop to return to the previous screen without altering the state
          },
        ),
        actions: [
          StreamBuilder<DocumentSnapshot>(
            stream: FirebaseAuth.instance.currentUser != null
                ? FirebaseFirestore.instance
                    .collection('users')
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .snapshots()
                : null,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 5),
                      Text(
                        'Loading...',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }

              if (!snapshot.hasData || !snapshot.data!.exists) {
                return Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Row(
                    children:  [
                      Icon(Icons.star, color: Colors.yellow),
                      SizedBox(width: 5),
                      Text(
                        '0',
                        style: TextStyle(color: Colors.black),
                      ),
                    ],
                  ),
                );
              }

              int score = snapshot.data!['score'] ?? 0;

              return Container(
                margin: const EdgeInsets.only(right: 10),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.star, color: Colors.yellow),
                    const SizedBox(width: 5),
                    Text(
                      '$score',
                      style: const TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Container(
        color: Colors.green,
        child: Row(
          children: [
            Container(
              width: 100,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/bamboo_stick.png'),
                  fit: BoxFit.fitHeight,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: lessonDashboard.lessons.length,
                        itemBuilder: (context, index) {
                          final lesson = lessonDashboard.lessons[index];
                          return LessonTile(
                            lesson: lesson,
                            onTap: () {
                              if (index == 0) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonPageOne(),
                                  ),
                                );
                              } else if (index == 1) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonPageTwo(),
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
