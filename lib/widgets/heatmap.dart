import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final DateTime? startDate;
  final Map<DateTime, int>? datasets;
  const MyHeatMap({super.key, required this.startDate, required this.datasets});

  @override
  Widget build(BuildContext context) {
    Map<int, Color> Colors = _pickColor(Theme.of(context).colorScheme.error);

    return HeatMap(
      startDate: startDate,
      endDate: DateTime.now(),
      datasets: datasets,
      colorMode: ColorMode.color,
      defaultColor: Theme.of(context).colorScheme.secondary,
      textColor: Theme.of(context).colorScheme.inversePrimary,
      showColorTip: false,
      showText: true,
      scrollable: true,
      size: 32,
      colorsets: Colors,
    );
  }

  Map<int, Color> _pickColor(Color color) {
    if (color == const Color.fromARGB(255, 157, 47, 184)) {
      return {
        1: const Color.fromARGB(75, 157, 47, 184),
        2: const Color.fromARGB(120, 157, 47, 184),
        3: const Color.fromARGB(150, 157, 47, 184),
        4: const Color.fromARGB(200, 157, 47, 184),
        5: const Color.fromARGB(255, 157, 47, 184),
      };
    } else if (color == const Color.fromARGB(255, 76, 77, 220)) {
      return {
        1: const Color.fromARGB(50, 76, 77, 220),
        2: const Color.fromARGB(100, 76, 77, 220),
        3: const Color.fromARGB(150, 76, 77, 220),
        4: const Color.fromARGB(200, 76, 77, 220),
        5: const Color.fromARGB(255, 76, 77, 220),
      };
    } else if (color == const Color.fromARGB(255, 38, 170, 151)) {
      return {
        1: const Color.fromARGB(50, 38, 170, 151),
        2: const Color.fromARGB(100, 38, 170, 151),
        3: const Color.fromARGB(150, 38, 170, 151),
        4: const Color.fromARGB(200, 38, 170, 151),
        5: const Color.fromARGB(255, 38, 170, 151),
      };
    } else if (color == const Color.fromARGB(255, 21, 121, 73)) {
      return {
        1: const Color.fromARGB(50, 21, 121, 73),
        2: const Color.fromARGB(100, 21, 121, 73),
        3: const Color.fromARGB(150, 21, 121, 73),
        4: const Color.fromARGB(200, 21, 121, 73),
        5: const Color.fromARGB(255, 21, 121, 73),
      };
    } else if (color == const Color.fromARGB(255, 50, 182, 72)) {
      return {
        1: const Color.fromARGB(50, 50, 182, 72),
        2: const Color.fromARGB(100, 50, 182, 72),
        3: const Color.fromARGB(150, 50, 182, 72),
        4: const Color.fromARGB(200, 50, 182, 72),
        5: const Color.fromARGB(255, 50, 182, 72),
      };
    } else if (color == const Color.fromARGB(255, 198, 124, 78)) {
      return {
        1: const Color.fromARGB(50, 198, 124, 78),
        2: const Color.fromARGB(100, 198, 124, 78),
        3: const Color.fromARGB(150, 198, 124, 78),
        4: const Color.fromARGB(200, 198, 124, 78),
        5: const Color.fromARGB(255, 198, 124, 78),
      };
    }
    return {
      1: const Color.fromARGB(50, 20, 195, 29),
      2: const Color.fromARGB(100, 20, 195, 29),
      3: const Color.fromARGB(150, 20, 195, 29),
      4: const Color.fromARGB(200, 20, 195, 29),
      5: const Color.fromARGB(255, 20, 195, 29),
    };
  }
}
