import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pandemonium/models/lesson.dart';
import 'package:pandemonium/models/lesson_dashboard.dart';
import '../../components/lesson_tile.dart';
import '../lessons/lesson one/lesson_page_one.dart';
import '../lessons/lesson_page_two.dart';

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
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back to previous screen
          },
        ),
      ),
      body: Container(
        color: Colors.green,
        child: Row(
          children: [
            // Image on the side
            Container(
              width: 100, // Adjust as needed
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('lib/images/bamboo_stick.png'), // Replace with your image path
                  fit: BoxFit.fitHeight, // Adjust how the image fills the container
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Heading
                    
                    SizedBox(height: 20),
                    Expanded(
                      child: ListView.builder(
                        itemCount: lessonDashboard.lessons.length,
                        itemBuilder: (context, index) {
                          final Lesson lesson = lessonDashboard.lessons[index];
                          return LessonTile(
                            lesson: lesson,
                            onTap: () {
                              if (index == 0) {
                                // Navigate to LessonPage1
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LessonPageOne(),
                                ),
                              );
                            } else if (index == 1) {
                              // Navigate to LessonPage2
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LessonPageTwo(),
                                ),
                              );
                            };
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
