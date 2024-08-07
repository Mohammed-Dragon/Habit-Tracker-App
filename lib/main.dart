import 'package:flutter/material.dart';
import 'package:ler/database/habit_database.dart';
import 'package:ler/pages/SplashScreen.dart';
import 'package:ler/themes/color_provider.dart';
import 'package:ler/themes/dark_mode.dart';
import 'package:ler/themes/light_mode.dart';
import 'package:ler/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirst();

  final themeProvider = ThemeProvider();
  final colorProvider = ColorProvider();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HabitDatabase(),
        ),
        ChangeNotifierProvider(
          create: (context) => themeProvider,
        ),
        ChangeNotifierProvider(
          create: (context) => colorProvider,
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final colorProvider = Provider.of<ColorProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    ThemeData themeData = themeProvider.isDarkMode ? darkMode : lightMode;
    themeData = themeData.copyWith(
      colorScheme: themeData.colorScheme.copyWith(
        error: colorProvider.selectedColor,
      ),
    );

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: themeData,
    );
  }
}
