import 'package:flutter/material.dart';

class KeyConceptsPage extends StatelessWidget {
  const KeyConceptsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Key Concepts: CIA Triad',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildConceptCard(
                'Confidentiality',
                'Ensures that sensitive information is accessed only by authorized individuals.',
                Icons.lock,
              ),
              _buildConceptCard(
                'Integrity',
                'Ensures the accuracy and reliability of data by preventing unauthorized modifications.',
                Icons.verified_user,
              ),
              _buildConceptCard(
                'Availability',
                'Ensures that information and resources are accessible to authorized users when needed.',
                Icons.cloud_done,
              ),
              const SizedBox(height: 20),
              const Text(
                'Real-World Examples',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildExampleCard(
                'Data Breach',
                'In 2017, Equifax experienced a data breach that exposed the personal information of over 140 million people.',
                Icons.warning,
              ),
              _buildExampleCard(
                'Ransomware Attack',
                'The WannaCry ransomware attack in 2017 affected computers in 150 countries.',
                Icons.computer,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildConceptCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Text(description),
          ],
        ),
      ),
    );
  }

  Widget _buildExampleCard(String title, String description, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, size: 30),
                const SizedBox(width: 10),
                Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              ],
            ),
            const SizedBox(height: 10),
            Text(description),
          ],
        ),
      ),
    );
  }
}