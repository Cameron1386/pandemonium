import 'package:flutter/material.dart';
import '../leaderboard_screens/global_page.dart';
import '../leaderboard_screens/regional_page.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Leaderboard'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Regional'),
              Tab(text: 'Global'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            // Regional Leaderboard
            RegionalPage(),
            // Global Leaderboard
            GlobalPage(),
          ],
        ),
      ),
    );
  }
}
