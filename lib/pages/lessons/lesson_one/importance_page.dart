import 'package:flutter/material.dart';

class ImportancePage extends StatelessWidget {
  const ImportancePage({super.key});

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
                'Why Cybersecurity is Important',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              _buildSection(
                'Personal Impact',
                [
                  _buildImpactCard(
                    'Identity Theft',
                    'Identity theft occurs when someone steals your personal information to commit fraud.',
                    'Someone uses your Social Security number to open a credit card in your name.',
                    Icons.person_off,
                  ),
                  _buildImpactCard(
                    'Financial Loss',
                    'Cyber attacks can result in significant financial loss.',
                    'A phishing scam that leads you to disclose your bank details, resulting in unauthorized transactions.',
                    Icons.money_off,
                  ),
                ],
              ),
              _buildSection(
                'Organizational Impact',
                [
                  _buildImpactCard(
                    'Data Breaches',
                    'Data breaches can expose sensitive information, leading to reputational damage and financial penalties for organizations.',
                    'A breach at a major retailer exposing customer payment information.',
                    Icons.security,
                  ),
                  _buildImpactCard(
                    'Operational Disruption',
                    'Cyber attacks can disrupt business operations, causing downtime and loss of productivity.',
                    'A ransomware attack shutting down a company\'s computer systems.',
                    Icons.business,
                  ),
                ],
              ),
              _buildSection(
                'The Bigger Picture',
                [
                  _buildImpactCard(
                    'National Security',
                    'Cybersecurity protects not just individuals and organizations but also national security and critical infrastructure.',
                    'Protecting power grids, water supply systems, and other critical services from cyber attacks.',
                    Icons.public,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> cards) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        ...cards,
        const SizedBox(height: 20),
      ],
    );
  }

  Widget _buildImpactCard(String title, String description, String example, IconData icon) {
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
}