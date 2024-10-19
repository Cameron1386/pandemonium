import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class StreaksPage extends StatelessWidget {
  const StreaksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          _buildGradientBackground(),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                const _HeaderText(),
                const SizedBox(height: 30),
                _buildHeatMapCard(),
                const SizedBox(height: 40),
                _buildViewDetailsButton(),
              ],
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
              const MyHeatMap(),
            ],
          ),
        ),
      ),
    );
  }

  ElevatedButton _buildViewDetailsButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        elevation: 10,
      ),
      onPressed: () {
        // Add functionality for showing streak details
      },
      child: const Text(
        'View Detailed Streaks',
        style: TextStyle(fontSize: 16, color: Colors.white),
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
  const MyHeatMap({super.key});

  // Custom dataset with meaningful data points
  Map<DateTime, int> _customDataset() {
    return {
      DateTime(2023, 10, 1): 5,
      DateTime(2023, 10, 2): 7,
      DateTime(2023, 10, 3): 2,
      DateTime(2023, 10, 4): 9,
      DateTime(2023, 10, 5): 1,
      DateTime(2023, 10, 6): 3,
      DateTime(2023, 10, 7): 6,
      DateTime(2023, 10, 8): 8,
      // Add more meaningful data here for different dates
      // This represents actual streak or event data
      DateTime(2024, 1, 5): 4,
      DateTime(2024, 3, 18): 9,
      DateTime(2024, 5, 10): 3,
      DateTime(2024, 6, 20): 7,
      // Repeat or customize as per actual usage data
    };
  }

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      datasets: _customDataset(),
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
