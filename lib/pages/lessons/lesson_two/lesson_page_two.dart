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
      appBar: AppBar(
        title: const Text('Lesson 2: Definition and Key Concepts'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: _pages,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_currentPage > 0)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.previousPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Previous'),
                  )
                else
                  const SizedBox(width: 80),
                Text('${_currentPage + 1} / ${_pages.length}'),
                if (_currentPage < _pages.length - 1)
                  ElevatedButton(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: const Text('Next'),
                  )
                else
                  const SizedBox(width: 80),
              ],
            ),
          ),
        ],
      ),
    );
  }
}