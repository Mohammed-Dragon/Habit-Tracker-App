import 'package:flutter/material.dart';
import 'package:ler/themes/color_provider.dart';
import 'package:ler/themes/dark_mode.dart';
import 'package:ler/themes/light_mode.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeProvider() {
    loadTheme();
  }

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme(ColorProvider colorProvider) {
    if (_themeData == lightMode) {
      darkMode = darkMode.copyWith(
        colorScheme: darkMode.colorScheme.copyWith(
          error: colorProvider.selectedColor,
        ),
      );
      themeData = darkMode;
      _saveTheme(true);
    } else {
      lightMode = lightMode.copyWith(
        colorScheme: lightMode.colorScheme.copyWith(
          error: colorProvider.selectedColor,
        ),
      );
      themeData = lightMode;
      _saveTheme(false);
    }
  }

  void _saveTheme(bool isDarkMode) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', isDarkMode);
  }

  Future<void> loadTheme() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isDarkMode = prefs.getBool('isDarkMode') ?? false;
    if (isDarkMode) {
      themeData = darkMode;
    } else {
      themeData = lightMode;
    }
  }
}
