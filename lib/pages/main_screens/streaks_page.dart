import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class StreaksPage extends StatelessWidget {
  const StreaksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      ),
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          // Gradient Background
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF8EC5FC), Color(0xFFE0C3FC)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          // Main content with heatmap
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                // Header text
                const Text(
                  "Your Activity Streaks",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 30),
                // HeatMap wrapped in a card
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    elevation: 10,
                    shadowColor: Colors.black.withOpacity(0.25),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: MyHeatMap(),
                    ),
                  ),
                ),
                const SizedBox(height: 40),
                // Button to show streak details (example of adding interaction)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: const Color(0xFF6200EE),
                    elevation: 10,
                  ),
                  onPressed: () {
                    // Add functionality for showing streak details
                  },
                  child: const Text(
                    'View Detailed Streaks',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      datasets: {
        DateTime(2024, 7, 10): 3,
        DateTime(2024, 7, 11): 7,
        // (additional data points removed for brevity)
        DateTime(2025, 4, 7): 7,
      },
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 365)),
      size: 40,
      textColor: Colors.black,
      colorMode: ColorMode.opacity,
      showText: false,
      scrollable: true,
      colorsets: const {
        1: Color.fromARGB(20, 2, 179, 8),
        2: Color.fromARGB(40, 2, 179, 8),
        3: Color.fromARGB(60, 2, 179, 8),
        4: Color.fromARGB(80, 2, 179, 8),
        5: Color.fromARGB(100, 2, 179, 8),
        6: Color.fromARGB(120, 2, 179, 8),
        7: Color.fromARGB(150, 2, 179, 8),
        8: Color.fromARGB(180, 2, 179, 8),
        9: Color.fromARGB(220, 2, 179, 8),
        10: Color.fromARGB(255, 2, 179, 8),
      },
    );
  }
}
