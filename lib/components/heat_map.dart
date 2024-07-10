import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  const MyHeatMap({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: HeatMap(
        datasets: {
          DateTime(2024, 7, 10): 3,
          DateTime(2024, 7, 11): 7,
          DateTime(2024, 7, 12): 10,
          DateTime(2024, 7, 13): 9,
          DateTime(2024, 7, 14): 6,
        },
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 40)),
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
      ),
    );
  }
}




