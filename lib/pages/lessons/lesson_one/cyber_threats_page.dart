import 'package:flutter/material.dart';

class CyberThreatsPage extends StatelessWidget {
  const CyberThreatsPage({super.key});

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
                'Common Cyber Threats',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildThreatCard(
                'Phishing',
                'Tricking individuals into providing sensitive information by pretending to be a trustworthy entity.',
                'An email claiming to be from your bank asking for your account details.',
                Icons.email,
              ),
              _buildThreatCard(
                'Malware',
                'Malicious software designed to damage, disrupt, or gain unauthorized access to computer systems.',
                'A virus that infects your computer and steals your personal information.',
                Icons.bug_report,
              ),
              _buildThreatCard(
                'Social Engineering',
                'Manipulates individuals into divulging confidential information through deceptive means.',
                'A phone call from someone pretending to be tech support asking for your password.',
                Icons.person,
              ),
              _buildThreatCard(
                'Ransomware',
                'Locks access to your data and demands payment to unlock it.',
                'A pop-up message demanding payment to restore access to your files.',
                Icons.lock,
              ),
              const SizedBox(height: 20),
              const Text(
                'Threat Sources',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              _buildSourceCard(
                'Hackers',
                'Individuals or groups who use their technical skills to exploit vulnerabilities for malicious purposes.',
                Icons.code,
              ),
              _buildSourceCard(
                'Insiders',
                'Employees or trusted individuals who misuse their access to an organization\'s resources.',
                Icons.person_outline,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildThreatCard(String title, String description, String example, IconData icon) {
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
            const SizedBox(height: 5),
            Text('Example: $example', style: const TextStyle(fontStyle: FontStyle.italic)),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceCard(String title, String description, IconData icon) {
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