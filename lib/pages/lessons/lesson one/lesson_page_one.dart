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
  // Controller to keep track of the current page
  final PageController _controller = PageController();
  // Variable to keep track of the current page index
  int _currentPage = 0;
  // Variable to keep track of whether the current answer is correct
  bool _isAnswerCorrect = false;

  // Method to handle page changes
  void _onPageChanged(int index) {
    setState(() {
      _currentPage = index;
      _isAnswerCorrect = false; // Reset the answer correctness for the new page
    });
  }

  // Calculate the percentage based on the current page index
  double _getPercentage() {
    return (_currentPage + 1) / 5;
  }

  // Method to go to the next page
  void _nextPage() {
    if (_currentPage < 4) {
      _controller.nextPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // Method to go to the previous page
  void _previousPage() {
    if (_currentPage > 0) {
      _controller.previousPage(duration: const Duration(milliseconds: 300), curve: Curves.ease);
    }
  }

  // Method to check the answer
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
          // PageView
          PageView(
            controller: _controller,
            onPageChanged: _onPageChanged,
            children: [
              const SetupPage(),
              const TeachingPage(),
              QuizPage(onCheckAnswer: _checkAnswer),
              TestPage(onCheckAnswer: _checkAnswer),
              ApplicationPage(onCheckAnswer: _checkAnswer),
            ],
          ),

          // Percent indicator
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

          // Back button
          if (_currentPage > 0)
            Positioned(
              left: 20,
              top: MediaQuery.of(context).size.height * 0.85,
              child: ElevatedButton(
                onPressed: _previousPage,
                child: const Text('Back'),
              ),
            ),

          // Next button
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
