import 'package:flutter/material.dart';
import 'definition_page.dart';
import 'key_concepts_page.dart';
import 'real_world_examples_page.dart';
import 'interactive_infographic_page.dart';

class LessonPageTwo extends StatefulWidget {
  const LessonPageTwo({Key? key}) : super(key: key);

  @override
  _LessonPageTwoState createState() => _LessonPageTwoState();
}

class _LessonPageTwoState extends State<LessonPageTwo> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Widget> _pages = [
    const DefinitionPage(),
    const KeyConceptsPage(),
    const RealWorldExamplesPage(),
    const InteractiveInfographicPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      appBar: AppBar(
        title: const Text('Definitions and Key Concepts', style: TextStyle(color: Colors.white)),
        backgroundColor: const Color(0xFF1B263B),
      ),
      body: Stack(
        children: [
          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                _currentPage = page;
              });
            },
            children: _pages,
          ),
          Positioned(
            bottom: 20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(_pages.length, (index) => _buildDot(index)),
            ),
          ),
          if (_currentPage > 0)
            Positioned(
              left: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  _pageController.previousPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Colors.teal[300],
                child: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),
          if (_currentPage < _pages.length - 1)
            Positioned(
              right: 20,
              bottom: 20,
              child: FloatingActionButton(
                onPressed: () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                },
                backgroundColor: Colors.teal[300],
                child: const Icon(Icons.arrow_forward, color: Colors.white),
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
        color: _currentPage == index ? Colors.teal[300] : Colors.grey,
      ),
    );
  }
}