import 'package:flutter/material.dart';
import '../leaderboard_screens/global_page.dart';
import '../leaderboard_screens/regional_page.dart';

class LeaderboardPage extends StatelessWidget {
  const LeaderboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Number of tabs
      child: Theme(
        data: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: const Color(0xFF0D1B2A),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1B263B),
            elevation: 5.0,
          ),
          tabBarTheme: const TabBarTheme(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(color: Colors.teal, width: 2.0),
            ),
          ),
          cardColor: const Color(0xFF1B263B),
          textTheme: Theme.of(context).textTheme.apply(
            bodyColor: Colors.white,
            displayColor: Colors.white,
          ),
          dividerColor: Colors.teal.withOpacity(0.3),
        ),
        child: Scaffold(
          appBar: AppBar(
            title: const Text(
              'Leaderboard',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            bottom: const TabBar(
              tabs: [
                Tab(text: 'Regional', icon: Icon(Icons.location_on)),
                Tab(text: 'Global', icon: Icon(Icons.public)),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              // Regional Leaderboard
              _themedLeaderboardContent(RegionalPage()),
              // Global Leaderboard
              _themedLeaderboardContent(GlobalPage()),
            ],
          ),
        ),
      ),
    );
  }

  Widget _themedLeaderboardContent(Widget child) {
    return Builder(
      builder: (BuildContext context) {
        return Container(
          color: Theme.of(context).scaffoldBackgroundColor,
          child: child,
        );
      },
    );
  }
}