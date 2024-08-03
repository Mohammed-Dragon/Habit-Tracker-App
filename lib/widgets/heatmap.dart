import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatMap extends StatelessWidget {
  final DateTime? startDate;
  final Map<DateTime, int>? datasets;
  const MyHeatMap({super.key, required this.startDate, required this.datasets});

  @override
  Widget build(BuildContext context) {
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
      colorsets: const {
        1: Color.fromARGB(50, 20, 195, 29),
        2: Color.fromARGB(100, 20, 195, 29),
        3: Color.fromARGB(150, 20, 195, 29),
        4: Color.fromARGB(200, 20, 195, 29),
        5: Color.fromARGB(255, 20, 195, 29),
      },
    );
  }
}
