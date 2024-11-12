import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferences prefs;
  final String key = "theme_mode";

  ThemeProvider(this.prefs) {
    _loadThemeMode();
  }

  bool _isDarkMode = false;
  bool get isDarkMode => _isDarkMode;

  void _loadThemeMode() {
    _isDarkMode = prefs.getBool(key) ?? false;
    notifyListeners();
  }

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    prefs.setBool(key, _isDarkMode);
    notifyListeners();
  }
}
