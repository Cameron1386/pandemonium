import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'main_screens/ai_page.dart';
import 'main_screens/leaderboard_page.dart';
import 'main_screens/streaks_page.dart';
import 'main_screens/home_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentIndex = 0;
  void goToPage(index) {
    setState(() {
      currentIndex = index;
    });
  }

  // List of pages
  List _pages = [
    // Home page
    HomeContent(),

    //AI page
    AiPage(),

    // Leaderboard page
    LeaderboardPage(),
    
    // Streaks page
    StreaksPage(),
  ];

  final user = FirebaseAuth.instance.currentUser!;

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
      // Bottom navigation bar
      bottomNavigationBar: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15.0,
            vertical: 10.0,
          ),
          child: GNav(
            backgroundColor: Colors.black,
            color: Colors.white,
            activeColor: Colors.white,
            tabBackgroundColor: Colors.grey.shade800,
            gap: 8,
            padding: EdgeInsets.all(16),
            onTabChange: (index) => goToPage(index),
            tabs: [
              GButton(
                icon: Icons.home,
                text: 'Home',
              ),
              GButton(
                icon: Icons.search,
                text: 'Search',
              ),
              GButton(
                icon: Icons.star,
                text: 'Leaderboard',
              ),
              GButton(
                icon: Icons.calendar_month,
                text: 'Streaks',
              ),
            ],
          ),
        ),
      ),
      
      // Background color
      
    );
  }
}
