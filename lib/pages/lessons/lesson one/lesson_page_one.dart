import 'package:flutter/material.dart';
import 'package:pandemonium/pages/lessons/lesson%20one/application_page.dart';
import 'package:pandemonium/pages/lessons/lesson%20one/quiz_page.dart';
import 'package:pandemonium/pages/lessons/lesson%20one/test_page.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import 'setup_page.dart';
import 'teaching_page.dart';

class LessonPageOne extends StatefulWidget {
  const LessonPageOne({super.key});

  @override
  State<LessonPageOne> createState() => _LessonPageOneState();
}

class _LessonPageOneState extends State<LessonPageOne> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  bool _isAnswerCorrect = false;

  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      _isAnswerCorrect = false;
    });
  }

  double _getPercentage() {
    return (_currentPage + 1) / 5;
  }

  void _nextPage() {
    if (_currentPage < 4) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  void _checkAnswer(bool isCorrect) {
    setState(() {
      _isAnswerCorrect = isCorrect;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: _onPageChanged,
            physics: const NeverScrollableScrollPhysics(), // Disable swipe
            children: [
              const SetupPage(),
              const TeachingPage(),
              QuizPage(onCheckAnswer: _checkAnswer),
              TestPage(onCheckAnswer: _checkAnswer),
              ApplicationPage(onCheckAnswer: _checkAnswer),
            ],
          ),
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () {
                Navigator.pop(context); // Navigates back to the lessons screen
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
          if (_currentPage < 4)
            Positioned(
              right: 20,
              top: MediaQuery.of(context).size.height * 0.85,
              child: ElevatedButton(
                onPressed: (_currentPage == 0 || _currentPage == 1 || _isAnswerCorrect) ? _nextPage : null,
                child: const Text('Next'),
              ),
            ),
        ],
      ),
    );
  }
}
