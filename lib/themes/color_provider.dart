import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ler/themes/dark_mode.dart';
import 'package:ler/themes/light_mode.dart';
import 'package:ler/themes/theme_provider.dart';

class ColorProvider extends ChangeNotifier {
  Color _selectedColor = const Color.fromARGB(255, 20, 195, 29);

  ColorProvider() {
    loadThemeColor();
  }

  Color get selectedColor => _selectedColor;

  void updateThemeColor(Color color, bool isDarkMode, BuildContext context) {
    _selectedColor = color;
    _saveThemeColor(color);

    if (isDarkMode) {
      darkMode = darkMode.copyWith(
        colorScheme: darkMode.colorScheme.copyWith(
          error: _selectedColor,
        ),
      );
    } else {
      lightMode = lightMode.copyWith(
        colorScheme: lightMode.colorScheme.copyWith(
          error: _selectedColor,
        ),
      );
    }
    final themeProvider = context.read<ThemeProvider>();
    themeProvider.themeData = isDarkMode ? darkMode : lightMode;

    notifyListeners();
  }

  void _saveThemeColor(Color color) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setInt('selectedColor', color.value);
    print(color.value);
  }

  Future<void> loadThemeColor() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int colorValue = prefs.getInt('selectedColor') ??
        const Color.fromARGB(255, 20, 195, 29).value;
    _selectedColor = Color(colorValue);
    notifyListeners();
  }
}
