import 'package:flutter/material.dart';
import 'package:pandemonium/pages/lessons/lesson_one/application_page.dart';
import 'package:pandemonium/pages/lessons/lesson_one/key_concepts_page.dart';
import 'package:pandemonium/pages/lessons/lesson_one/importance_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'setup_page.dart';
import 'cyber_threats_page.dart';
import 'key_concepts_page.dart';
import 'cyber_threats_page.dart';
import 'importance_page.dart';

class LessonPageOne extends StatefulWidget {
  const LessonPageOne({super.key});

  @override
  State<LessonPageOne> createState() => _LessonPageOneState();
}

class _LessonPageOneState extends State<LessonPageOne> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
    });
  }

  double _getPercentage() {
    return (_currentPage + 1) / 7; // Updated for 7 pages
  }

  void _nextPage() {
    if (_currentPage < 6) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: _onPageChanged,
            physics: const NeverScrollableScrollPhysics(),
            children: const [
              SetupPage(),
              KeyConceptsPage(),
              CyberThreatsPage(),
              ImportancePage(),
              ApplicationPage(),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            alignment: const Alignment(0, 0.75),
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: LinearPercentIndicator(
              lineHeight: 12.0,
              backgroundColor: Colors.grey[300],
              progressColor: Colors.blue,
              percent: _getPercentage(),
              barRadius: const Radius.circular(8.0),
              animation: true,
              animationDuration: 500,
            ),
          ),
          if (_currentPage > 0)
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 0.85,
              child: ElevatedButton(
                onPressed: _previousPage,
                child: const Text('Back'),
              ),
            ),
          if (_currentPage < 6)
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height * 0.85,
              child: ElevatedButton(
                onPressed: _nextPage,
                child: const Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}