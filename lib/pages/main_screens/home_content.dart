// lib/main_screens/home_content.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:pandemonium/pages/dashboard/daily_level.dart';
import 'package:pandemonium/pages/dashboard/easy_level.dart';
import 'package:pandemonium/pages/dashboard/hard_level.dart';
import 'package:pandemonium/pages/profile_page.dart';
import 'ai_page.dart';
import 'leaderboard_page.dart';
import 'streaks_page.dart';

class HomeContent extends StatefulWidget {
  const HomeContent({super.key});

  @override
  _HomeContentState createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  int currentIndex = 0;
  bool _scaleFactor = false; // For card scaling

  final user = FirebaseAuth.instance.currentUser!;

  // List of main pages
  final List _pages = [
    // Home content itself
    const _InnerHomeContent(),
    const AiPage(),
    const LeaderboardPage(),
    const StreaksPage(),
  ];

  void goToPage(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  void _onCardTap(bool isTapped) {
    setState(() {
      _scaleFactor = isTapped;
    });
  }

  // Sign user out method
  void signUserOut() {
    FirebaseAuth.instance.signOut();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[currentIndex],
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
            padding: const EdgeInsets.all(16),
            onTabChange: (index) => goToPage(index),
            tabs: const [
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
    );
  }
}

class _InnerHomeContent extends StatelessWidget {
  const _InnerHomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0D1B2A),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            expandedHeight: 250,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.person, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.logout, color: Colors.white),
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  Navigator.pushReplacementNamed(context, '/login');
                },
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              title: const Text(
                "Pandemonium!",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(
                    'lib/images/panda.png',
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Color(0xFF0D1B2A),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                _buildLevelCard(
                  context,
                  'Daily Level',
                  'Complete a new challenge each day!',
                  'lib/images/panda.png',
                  Colors.teal,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const DailyLevel())),
                ),
                const SizedBox(height: 30),
                _buildLevelCard(
                  context,
                  'Easy Level',
                  'Start easy, get familiar with the basics.',
                  'lib/images/panda.png',
                  Colors.green,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EasyLevel())),
                ),
                const SizedBox(height: 30),
                _buildLevelCard(
                  context,
                  'Hard Level',
                  'Take on the hardest challenges!',
                  'lib/images/panda.png',
                  Colors.orange,
                  () => Navigator.push(context, MaterialPageRoute(builder: (context) => const HardLevel())),
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelCard(BuildContext context, String title, String description, String imagePath, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.5),
              blurRadius: 15,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: AnimatedScale(
          scale: 1.0,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    description,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const Spacer(),
                  const Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(Icons.arrow_forward_ios, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
