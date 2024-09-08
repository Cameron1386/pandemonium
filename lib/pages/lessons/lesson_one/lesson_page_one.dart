import 'package:flutter/material.dart';
import 'setup_page.dart';
import 'introduction_page.dart';
import 'objectives_page.dart';
import 'application_page.dart';

class LessonPageOne extends StatefulWidget {
  const LessonPageOne({Key? key}) : super(key: key);

  @override
  _LessonPageOneState createState() => _LessonPageOneState();
}

class _LessonPageOneState extends State<LessonPageOne> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() => _currentPage = index);
            },
            children: const [
              SetupPage(),
              IntroductionPage(),
              ObjectivesPage(),
              ApplicationPage(),
            ],
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(4, (index) => _buildDot(index)),
            ),
          ),
          if (_currentPage > 0)
            Positioned(
              left: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  _controller.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Icon(Icons.arrow_back),
              ),
            ),
          if (_currentPage < 4)
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                child: const Icon(Icons.arrow_forward),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 10,
      height: 10,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}