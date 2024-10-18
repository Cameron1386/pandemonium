import 'package:flutter/material.dart';

class DailyLevel extends StatefulWidget {
  const DailyLevel({Key? key}) : super(key: key);

  @override
  _DailyLevelState createState() => _DailyLevelState();
}

class _DailyLevelState extends State<DailyLevel> {
  final Map<String, List<String>> categories = {
    'Network Security': [],
    'Encryption': [],
    'Access Control': [],
  };

  final List<String> terms = [
    'Firewall',
    'VPN',
    'AES',
    'RSA',
    'Two-Factor Authentication',
    'Biometrics',
  ];

  final Map<String, String> correctCategoryMapping = {
    'Firewall': 'Network Security',
    'VPN': 'Network Security',
    'AES': 'Encryption',
    'RSA': 'Encryption',
    'Two-Factor Authentication': 'Access Control',
    'Biometrics': 'Access Control',
  };

  int score = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(
          'Cybersecurity Challenge | Score: $score',
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        backgroundColor: Colors.blueGrey[800],
        elevation: 5.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: resetCategories,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  String category = categories.keys.elementAt(index);
                  return buildCategoryTarget(category);
                },
              ),
            ),
            const Divider(),
            const SizedBox(height: 10),
            buildTermPool(),
          ],
        ),
      ),
    );
  }

  Widget buildCategoryTarget(String category) {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        bool isDraggingOver = candidateData.isNotEmpty;
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(vertical: 10),
          color: isDraggingOver ? Colors.lightGreen[50] : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  children: categories[category]!
                      .map((term) => Draggable<String>(
                            data: term,
                            feedback: Material(
                              child: buildTermChip(term),
                              elevation: 6.0,
                              color: Colors.transparent,
                            ),
                            childWhenDragging: buildTermChip(term, Colors.grey[300]),
                            child: buildTermChip(term),
                          ))
                      .toList(),
                ),
              ],
            ),
          ),
        );
      },
      onWillAccept: (data) {
        return data != null && !categories[category]!.contains(data);
      },
      onAccept: (data) {
        setState(() {
          bool isCorrect = correctCategoryMapping[data] == category;

          _removeFromAllCategories(data);

          if (isCorrect) {
            score += 1;
          } else {
            score -= 1;
          }

          categories[category]!.add(data);
          terms.remove(data);

          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
              isCorrect ? 'Correct! $data added to $category' : 'Incorrect! $data doesn\'t belong to $category',
              style: TextStyle(color: isCorrect ? Colors.green : Colors.red),
            ),
            duration: const Duration(seconds: 2),
          ));
        });
      },
    );
  }

  Widget buildTermPool() {
    return DragTarget<String>(
      builder: (context, candidateData, rejectedData) {
        return Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 3,
                blurRadius: 6,
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: terms.length,
            itemBuilder: (context, index) {
              return Draggable<String>(
                data: terms[index],
                feedback: Material(
                  child: buildTermChip(terms[index]),
                  elevation: 6.0,
                  color: Colors.transparent,
                ),
                childWhenDragging: buildTermChip(terms[index], Colors.grey[300]),
                child: buildTermChip(terms[index]),
              );
            },
          ),
        );
      },
      onWillAccept: (data) => true,
      onAccept: (data) {
        setState(() {
          if (!terms.contains(data)) {
            terms.add(data);
          }
        });
      },
    );
  }

  void _removeFromAllCategories(String term) {
    categories.forEach((category, termsList) {
      if (termsList.contains(term)) {
        termsList.remove(term);
      }
    });
  }

  void resetCategories() {
    setState(() {
      terms.clear();
      terms.addAll([
        'Firewall',
        'VPN',
        'AES',
        'RSA',
        'Two-Factor Authentication',
        'Biometrics',
      ]);
      categories.forEach((key, value) {
        value.clear();
      });
      score = 0;
    });
  }

  Widget buildTermChip(String term, [Color? color]) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: Chip(
        label: Text(term, style: TextStyle(fontSize: 16)),
        backgroundColor: color ?? Colors.lightBlue[100],
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
