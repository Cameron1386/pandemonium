import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class StreaksPage extends StatefulWidget {
  const StreaksPage({super.key});

  @override
  _StreaksPageState createState() => _StreaksPageState();
}

class _StreaksPageState extends State<StreaksPage> {
  Map<DateTime, int> streakData = {};
  int dailyChallengePoints = 50; // Points for completing daily challenge
  int consecutiveDays = 0; // Streak counter

  @override
  void initState() {
    super.initState();
    _simulateStreakData(); // Add fake streak data
  }

  // Simulate streak data with some fake dates and activity counts
  void _simulateStreakData() {
    streakData = {
  DateTime(2024, 10, 23): 1,
  DateTime(2024, 10, 22): 2,
  DateTime(2024, 10, 21): 3,
  DateTime(2024, 10, 20): 4,
  DateTime(2024, 10, 19): 5,
  DateTime(2024, 10, 18): 6,
  DateTime(2024, 10, 17): 7,
  DateTime(2024, 10, 16): 8,
  DateTime(2024, 10, 15): 9,
  DateTime(2024, 10, 14): 1,
  DateTime(2024, 10, 13): 2,
  DateTime(2024, 10, 12): 3,
  DateTime(2024, 10, 11): 4,
  DateTime(2024, 10, 10): 5,
  DateTime(2024, 10, 9): 6,
  DateTime(2024, 10, 8): 7,
  DateTime(2024, 10, 7): 8,
  DateTime(2024, 10, 6): 9,
  DateTime(2024, 10, 5): 1,
  DateTime(2024, 10, 4): 2,
  DateTime(2024, 10, 3): 3,
  DateTime(2024, 10, 2): 4,
  DateTime(2024, 10, 1): 5,
  DateTime(2024, 9, 30): 6,
  DateTime(2024, 9, 29): 7,
  DateTime(2024, 9, 28): 8,
  DateTime(2024, 9, 27): 9,
  DateTime(2024, 9, 26): 1,
  DateTime(2024, 9, 25): 2,
  DateTime(2024, 9, 24): 3,
  DateTime(2024, 9, 23): 4,
  DateTime(2024, 9, 22): 5,
  DateTime(2024, 9, 21): 6,
  DateTime(2024, 9, 20): 7,
  DateTime(2024, 9, 19): 8,
  DateTime(2024, 9, 18): 9,
  DateTime(2024, 9, 17): 1,
  DateTime(2024, 9, 16): 2,
  DateTime(2024, 9, 15): 3,
  DateTime(2024, 9, 14): 4,
  DateTime(2024, 9, 13): 5,
  DateTime(2024, 9, 12): 6,
  DateTime(2024, 9, 11): 7,
  DateTime(2024, 9, 10): 8,
  DateTime(2024, 9, 9): 9,
  DateTime(2024, 9, 8): 1,
  DateTime(2024, 9, 7): 2,
  DateTime(2024, 9, 6): 3,
  DateTime(2024, 9, 5): 4,
  DateTime(2024, 9, 4): 5,
  DateTime(2024, 9, 3): 6,
  DateTime(2024, 9, 2): 7,
  DateTime(2024, 9, 1): 8,
  DateTime(2024, 8, 31): 9,
  DateTime(2024, 8, 30): 1,
  DateTime(2024, 8, 29): 2,
  DateTime(2024, 8, 28): 3,
  DateTime(2024, 8, 27): 4,
  DateTime(2024, 8, 26): 5,
  DateTime(2024, 8, 25): 6,
  DateTime(2024, 8, 24): 7,
  DateTime(2024, 8, 23): 8,
  DateTime(2024, 8, 22): 9,
  DateTime(2024, 8, 21): 1,
  DateTime(2024, 8, 20): 2,
  DateTime(2024, 8, 19): 3,
  DateTime(2024, 8, 18): 4,
  DateTime(2024, 8, 17): 5,
  DateTime(2024, 8, 16): 6,
  DateTime(2024, 8, 15): 7,
  DateTime(2024, 8, 14): 8,
  DateTime(2024, 8, 13): 9,
  DateTime(2024, 8, 12): 1,
  DateTime(2024, 8, 11): 2,
  DateTime(2024, 8, 10): 3,
  DateTime(2024, 8, 9): 4,
  DateTime(2024, 8, 8): 5,
  DateTime(2024, 8, 7): 6,
  DateTime(2024, 8, 6): 7,
  DateTime(2024, 8, 5): 8,
  DateTime(2024, 8, 4): 9,
  DateTime(2024, 8, 3): 1,
  DateTime(2024, 8, 2): 2,
  DateTime(2024, 8, 1): 3,
  DateTime(2024, 7, 31): 4,
  DateTime(2024, 7, 30): 5,
  DateTime(2024, 7, 29): 6,
  DateTime(2024, 7, 28): 7,
  DateTime(2024, 7, 27): 8,
  DateTime(2024, 7, 26): 9,
  DateTime(2024, 7, 25): 1,
  DateTime(2024, 7, 24): 2,
  DateTime(2024, 7, 23): 3,
  DateTime(2024, 7, 22): 4,
  DateTime(2024, 7, 21): 5,
  DateTime(2024, 7, 20): 6,
  DateTime(2024, 7, 19): 7,
  DateTime(2024, 7, 18): 8,
  DateTime(2024, 7, 17): 9,
  DateTime(2024, 7, 16): 1,
  DateTime(2024, 7, 15): 2,
  DateTime(2024, 7, 14): 3,
  DateTime(2024, 7, 13): 4,
  DateTime(2024, 7, 12): 5,
  DateTime(2024, 7, 11): 6,
  DateTime(2024, 7, 10): 7,
  DateTime(2024, 7, 9): 8,
  DateTime(2024, 7, 8): 9,
  DateTime(2024, 7, 7): 1,
  DateTime(2024, 7, 6): 2,
  DateTime(2024, 7, 5): 3,
  DateTime(2024, 7, 4): 4,
  DateTime(2024, 7, 3): 5,
  DateTime(2024, 7, 2): 6,
  DateTime(2024, 7, 1): 7,
  DateTime(2024, 6, 30): 8,
  DateTime(2024, 6, 29): 9,
  DateTime(2024, 6, 28): 1,
  DateTime(2024, 6, 27): 2,
  DateTime(2024, 6, 26): 3,
  DateTime(2024, 6, 25): 4,
  DateTime(2024, 6, 24): 5,
  DateTime(2024, 6, 23): 6,
  DateTime(2024, 6, 22): 7,
  DateTime(2024, 6, 21): 8,
  DateTime(2024, 6, 20): 9,
  DateTime(2024, 6, 19): 1,
  DateTime(2024, 6, 18): 2,
  DateTime(2024, 6, 17): 3,
  DateTime(2024, 6, 16): 4,
  DateTime(2024, 6, 15): 5,
  DateTime(2024, 6, 14): 6,
  DateTime(2024, 6, 13): 7,
  DateTime(2024, 6, 12): 8,
  DateTime(2024, 6, 11): 9,
  DateTime(2024, 6, 10): 1,
  DateTime(2024, 6, 9): 2,
  DateTime(2024, 6, 8): 3,
  DateTime(2024, 6, 7): 4,
  DateTime(2024, 6, 6): 5,
  DateTime(2024, 6, 5): 6,
  DateTime(2024, 6, 4): 7,
  DateTime(2024, 6, 3): 8,
  DateTime(2024, 6, 2): 9,
  DateTime(2024, 6, 1): 1,
  DateTime(2024, 5, 31): 2,
  DateTime(2024, 5, 30): 3,
  DateTime(2024, 5, 29): 4,
  DateTime(2024, 5, 28): 5,
  DateTime(2024, 5, 27): 6,
  DateTime(2024, 5, 26): 7,
  DateTime(2024, 5, 25): 8,
  DateTime(2024, 5, 24): 9,
  DateTime(2024, 5, 23): 1,
  DateTime(2024, 5, 22): 2,
  DateTime(2024, 5, 21): 3,
  DateTime(2024, 5, 20): 4,
  DateTime(2024, 5, 19): 5,
  DateTime(2024, 5, 18): 6,
  DateTime(2024, 5, 17): 7,
  DateTime(2024, 5, 16): 8,
  DateTime(2024, 5, 15): 9,
  DateTime(2024, 5, 14): 1,
  DateTime(2024, 5, 13): 2,
  DateTime(2024, 5, 12): 3,
  DateTime(2024, 5, 11): 4,
  DateTime(2024, 5, 10): 5,
  DateTime(2024, 5, 9): 6,
  DateTime(2024, 5, 8): 7,
  DateTime(2024, 5, 7): 8,
  DateTime(2024, 5, 6): 9,
  DateTime(2024, 5, 5): 1,
  DateTime(2024, 5, 4): 2,
  DateTime(2024, 5, 3): 3,
  DateTime(2024, 5, 2): 4,
  DateTime(2024, 5, 1): 5,
  DateTime(2024, 4, 30): 6,
  DateTime(2024, 4, 29): 7,
  DateTime(2024, 4, 28): 8,
  DateTime(2024, 4, 27): 9,
  DateTime(2024, 4, 26): 1,
  DateTime(2024, 4, 25): 2,
  DateTime(2024, 4, 24): 3,
  DateTime(2024, 4, 23): 4,
  DateTime(2024, 4, 22): 5,
  DateTime(2024, 4, 21): 6,
  DateTime(2024, 4, 20): 7,
  DateTime(2024, 4, 19): 8,
  DateTime(2024, 4, 18): 9,
  DateTime(2024, 4, 17): 1,
  DateTime(2024, 4, 16): 2,
  DateTime(2024, 4, 15): 3,
  DateTime(2024, 4, 14): 4,
  DateTime(2024, 4, 13): 5,
  DateTime(2024, 4, 12): 6,
  DateTime(2024, 4, 11): 7,
  DateTime(2024, 4, 10): 8,
  DateTime(2024, 4, 9): 9,
  DateTime(2024, 4, 8): 1,
  DateTime(2024, 4, 7): 2,
  DateTime(2024, 4, 6): 3,
  DateTime(2024, 4, 5): 4,
  DateTime(2024, 4, 4): 5,
  DateTime(2024, 4, 3): 6,
  DateTime(2024, 4, 2): 7,
  DateTime(2024, 4, 1): 8,
  DateTime(2024, 3, 31): 9,
  DateTime(2024, 3, 30): 1,
  DateTime(2024, 3, 29): 2,
  DateTime(2024, 3, 28): 3,
  DateTime(2024, 3, 27): 4,
  DateTime(2024, 3, 26): 5,
  DateTime(2024, 3, 25): 6,
  DateTime(2024, 3, 24): 7,
  DateTime(2024, 3, 23): 8,
  DateTime(2024, 3, 22): 9,
  DateTime(2024, 3, 21): 1,
  DateTime(2024, 3, 20): 2,
  DateTime(2024, 3, 19): 3,
  DateTime(2024, 3, 18): 4,
  DateTime(2024, 3, 17): 5,
  DateTime(2024, 3, 16): 6,
  DateTime(2024, 3, 15): 7,
  DateTime(2024, 3, 14): 8,
  DateTime(2024, 3, 13): 9,
  DateTime(2024, 3, 12): 1,
  DateTime(2024, 3, 11): 2,
  DateTime(2024, 3, 10): 3,
  DateTime(2024, 3, 9): 4,
  DateTime(2024, 3, 8): 5,
  DateTime(2024, 3, 7): 6,
  DateTime(2024, 3, 6): 7,
  DateTime(2024, 3, 5): 8,
  DateTime(2024, 3, 4): 9,
  DateTime(2024, 3, 3): 1,
  DateTime(2024, 3, 2): 2,
  DateTime(2024, 3, 1): 3,
  DateTime(2024, 2, 29): 4,
  DateTime(2024, 2, 28): 5,
  DateTime(2024, 2, 27): 6,
  DateTime(2024, 2, 26): 7,
  DateTime(2024, 2, 25): 8,
  DateTime(2024, 2, 24): 9,
  DateTime(2024, 2, 23): 1,
  DateTime(2024, 2, 22): 2,
  DateTime(2024, 2, 21): 3,
  DateTime(2024, 2, 20): 4,
  DateTime(2024, 2, 19): 5,
  DateTime(2024, 2, 18): 6,
  DateTime(2024, 2, 17): 7,
  DateTime(2024, 2, 16): 8,
  DateTime(2024, 2, 15): 9,
  DateTime(2024, 2, 14): 1,
  DateTime(2024, 2, 13): 2,
};
    consecutiveDays = _calculateConsecutiveStreak(); // Calculate streak counter
  }

  // Calculate the number of consecutive days the user has completed a challenge/lesson
  int _calculateConsecutiveStreak() {
    List<DateTime> dates = streakData.keys.toList();
    dates.sort((a, b) => b.compareTo(a)); // Sort dates in descending order

    int streak = 0;
    DateTime today = DateTime.now();
    for (int i = 0; i < dates.length; i++) {
      DateTime date = dates[i];
      if (today.difference(date).inDays == streak) {
        streak++;
      } else {
        break; // Stop counting if there's a gap in the streak
      }
    }
    return streak;
  }

  // Complete daily challenge and award extra points
  Future<void> _completeDailyChallenge() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DateTime today = DateTime.now();

      // Update Firestore streaks data
      await FirebaseFirestore.instance.collection('users').doc(userId).set({
        'streaks': {
          today.toIso8601String(): FieldValue.increment(1), // Add 1 lesson/challenge completed for today
        },
        'score': FieldValue.increment(dailyChallengePoints), // Add points for completing the challenge
      }, SetOptions(merge: true));

      // Update local state and refresh heatmap
      setState(() {
        streakData[today] = (streakData[today] ?? 0) + 1;
        consecutiveDays = _calculateConsecutiveStreak(); // Update streak counter
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildGradientBackground(),
          SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),
                  const _HeaderText(),
                  const SizedBox(height: 30),
                  _buildHeatMapCard(),
                  const SizedBox(height: 40),
                  _buildDailyChallengeCard(),
                  const SizedBox(height: 40),
                  _buildStreakCounter(),  // Add streak counter here
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text(
        'Streaks Overview',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 24, color: Colors.white
        ),
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
    );
  }

  Container _buildGradientBackground() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF0D1B2A), Color(0xFF1B263B)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
    );
  }

  Padding _buildHeatMapCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: const Color(0xFF1B263B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Streak History',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              MyHeatMap(streakData: streakData),
            ],
          ),
        ),
      ),
    );
  }

  Padding _buildDailyChallengeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: const Color(0xFF1B263B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              const Text(
                'Daily Challenge',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Complete 1 lesson today to earn bonus points!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _completeDailyChallenge,
                child: const Text('Complete Challenge'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4CAF50),
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the streak counter
  Padding _buildStreakCounter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Card(
        color: const Color(0xFF1B263B),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 8,
        shadowColor: Colors.black.withOpacity(0.4),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Text(
                consecutiveDays > 0
                    ? "$consecutiveDays days in a row, you're on a roll!"
                    : "Start your streak today!",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _HeaderText extends StatelessWidget {
  const _HeaderText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Your Activity Streaks",
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
        letterSpacing: 1.2,
      ),
    );
  }
}

class MyHeatMap extends StatelessWidget {
  final Map<DateTime, int> streakData;

  const MyHeatMap({required this.streakData, super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      datasets: streakData,
      startDate: DateTime.now().subtract(const Duration(days: 365)),
      endDate: DateTime.now(),
      size: 40,
      textColor: Colors.white,
      colorMode: ColorMode.opacity,
      showText: false,
      scrollable: true,
      colorsets: const {
         1: Color.fromARGB(30, 255, 223, 0),
         2: Color.fromARGB(60, 255, 223, 0),
         3: Color.fromARGB(90, 255, 223, 0),
         4: Color.fromARGB(120, 255, 223, 0),
         5: Color.fromARGB(150, 255, 223, 0),
         6: Color.fromARGB(180, 255, 223, 0),
         7: Color.fromARGB(210, 255, 223, 0),
         8: Color.fromARGB(240, 255, 223, 0),
         9: Color.fromARGB(255, 255, 223, 0),
      },
    );
  }
}
