import 'package:flutter/material.dart';

import '../models/lesson.dart';

class LessonTile extends StatelessWidget {
  final Lesson lesson;
  void Function()? onTap;

  LessonTile({
    super.key, 
    required this.lesson,
    required this.onTap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 20.0),
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(10.0),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 3.0,
              spreadRadius: 3.0,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: ListTile(
          title: Text(lesson.name),
          subtitle: Text(lesson.bamboopoints),
          leading: Image.asset(lesson.imagePath),
          trailing: const Icon(Icons.arrow_forward_ios),
        ),
      ),
    ); 
  }
}

