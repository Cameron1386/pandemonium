import 'package:flutter/material.dart';
import 'package:pandemonium/pages/intro_screens/intro_page_1.dart';
import 'package:pandemonium/pages/intro_screens/intro_page_2.dart';
import 'package:pandemonium/pages/intro_screens/intro_page_3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  //controller to keep track of the current page

  PageController _controller = PageController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // PageView
          PageView(
            controller: _controller,
            children: [
              IntroPage1(),
              IntroPage2(),
              IntroPage3(),
            ],
          ),

          // dot indicator
          Container(
            alignment: Alignment(0, 0.75),
            child: SmoothPageIndicator(controller: _controller, count: 3)
            ),
        ],
      ),
    );
  }
}