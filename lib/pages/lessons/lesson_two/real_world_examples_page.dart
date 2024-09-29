import 'package:flutter/material.dart';

class RealWorldExamplesPage extends StatelessWidget {
  const RealWorldExamplesPage({Key? key}) : super(key: key);

  Widget _buildExampleCard(String title, String description, String example, String imagePath) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            Text(description, style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 10),
            Text("Example: $example", style: const TextStyle(fontSize: 16, fontStyle: FontStyle.italic)),
            const SizedBox(height: 10),
            Center(child: Image.asset(imagePath, height: 150)),
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
            "Real-World Examples",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _buildExampleCard(
            "Data Breaches",
            "Data breaches occur when unauthorized individuals gain access to sensitive information.",
            "In 2017, Equifax experienced a data breach that exposed the personal information of over 140 million people.",
            "",
          ),
          const SizedBox(height: 20),
          _buildExampleCard(
            "Ransomware Attacks",
            "Ransomware attacks involve malicious software that locks access to data until a ransom is paid.",
            "The WannaCry ransomware attack in 2017 affected computers in 150 countries.",
            "",
          ),
        ],
      ),
    );
  }
}