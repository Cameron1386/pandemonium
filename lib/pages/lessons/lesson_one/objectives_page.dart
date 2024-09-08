import 'package:flutter/material.dart';

class ObjectivesPage extends StatelessWidget {
  const ObjectivesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final objectives = [
      "Understand the basics of cybersecurity and its importance.",
      "Recognize common cyber threats and how they can impact you.",
      "Learn practical steps to safeguard your personal information.",
      "Become equipped to navigate the digital world safely and responsibly.",
    ];

    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Course Objectives",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              const Text(
                "By the end of this course, you will:",
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: objectives.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle, color: Colors.green[700]),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              objectives[index],
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}