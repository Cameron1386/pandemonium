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
    _fetchStreakData();
  }

  // Fetch streak data from Firestore
  Future<void> _fetchStreakData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(userId).get();

      if (userDoc.exists && userDoc.data() != null) {
        Map<String, dynamic> streaks = userDoc['streaks'] ?? {};
        setState(() {
          streakData = _convertStreakData(streaks);
          consecutiveDays = _calculateConsecutiveStreak();
        });
      }
    }
  }

  // Convert Firestore streak data to DateTime map for the heatmap
  Map<DateTime, int> _convertStreakData(Map<String, dynamic> streaks) {
    Map<DateTime, int> result = {};
    streaks.forEach((key, value) {
      DateTime date = DateTime.parse(key);
      result[date] = value;
    });
    return result;
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
          fontSize: 24,
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
