import 'package:flutter/material.dart';

class KeyConceptsPage extends StatelessWidget {
  const KeyConceptsPage({Key? key}) : super(key: key);

  Widget _buildConceptCard(String title, String description, IconData icon) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, size: 48, color: Colors.blue),
            const SizedBox(height: 10),
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description, textAlign: TextAlign.center, style: const TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Key Concepts: CIA Triad",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildConceptCard(
            "Confidentiality",
            "Ensures that sensitive information is accessed only by authorized individuals.",
            Icons.lock,
          ),
          const SizedBox(height: 20),
          _buildConceptCard(
            "Integrity",
            "Ensures the accuracy and reliability of data by preventing unauthorized modifications.",
            Icons.verified,
          ),
          const SizedBox(height: 20),
          _buildConceptCard(
            "Availability",
            "Ensures that information and resources are accessible to authorized users when needed.",
            Icons.cloud_done,
          ),
        ],
      ),
    );
  }
}