import 'package:flutter/material.dart';
import 'package:ler/database/habit_database.dart';
import 'package:ler/pages/MyHomePage.dart';
import 'package:ler/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirst();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HabitDatabase(),
      ),
      ChangeNotifierProvider(
        create: (context) => ThemeProvider(),
      ),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
