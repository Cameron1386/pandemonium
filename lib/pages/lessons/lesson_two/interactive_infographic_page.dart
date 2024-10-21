import 'package:flutter/material.dart';

class InteractiveInfographicPage extends StatefulWidget {
  const InteractiveInfographicPage({Key? key}) : super(key: key);

  @override
  _InteractiveInfographicPageState createState() => _InteractiveInfographicPageState();
}

class _InteractiveInfographicPageState extends State<InteractiveInfographicPage> {
  String _selectedConcept = '';

  Widget _buildInteractiveIcon(String concept, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedConcept = concept;
        });
      },
      child: Column(
        children: [
          Icon(icon, size: 48, color: Colors.teal[300]),
          Text(concept, style: const TextStyle(fontSize: 16, color: Colors.white)),
        ],
      ),
    );
  }

  Widget _buildConceptDetails() {
    switch (_selectedConcept) {
      case 'Confidentiality':
        return const Text(
          "Confidentiality ensures that data is kept private and only accessed by authorized parties. Examples include encryption and access controls.",
          style: TextStyle(fontSize: 16, color: Colors.white),
        );
      case 'Integrity':
        return const Text(
          "Integrity guarantees that data remains accurate and unaltered. This is achieved through methods like checksums and digital signatures.",
          style: TextStyle(fontSize: 16, color: Colors.white),
        );
      case 'Availability':
        return const Text(
          "Availability ensures that data and resources are accessible when needed. This involves measures like redundancy and disaster recovery planning.",
          style: TextStyle(fontSize: 16, color: Colors.white),
        );
      default:
        return const Text(
          "Click on an icon to learn more about each concept.",
          style: TextStyle(fontSize: 16, fontStyle: FontStyle.italic, color: Colors.white),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Interactive Infographic",
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            "Explore this interactive infographic to learn more about different aspects of cybersecurity.",
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildInteractiveIcon('Confidentiality', Icons.lock),
              _buildInteractiveIcon('Integrity', Icons.verified),
              _buildInteractiveIcon('Availability', Icons.cloud_done),
            ],
          ),
          const SizedBox(height: 20),
          Card(
            color: const Color(0xFF1B263B),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: _buildConceptDetails(),
            ),
          ),
        ],
      ),
    );
  }
}