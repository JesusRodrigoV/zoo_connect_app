import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeNotifier extends StateNotifier<ThemeMode> {
  ThemeNotifier() : super(ThemeMode.system) {
    _loadTheme();
  }

  static const _themeKey = 'app_theme';

  void _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final themeModeString = prefs.getString(_themeKey);

    if (themeModeString == 'light') {
      state = ThemeMode.light;
    } else if (themeModeString == 'dark') {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }

  void setTheme(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String? modeString;

    if (mode == ThemeMode.light) {
      modeString = 'light';
    } else if (mode == ThemeMode.dark) {
      modeString = 'dark';
    } else {
      modeString = 'system';
    }

    await prefs.setString(_themeKey, modeString);
    state = mode;
  }
}

final themeProvider = StateNotifierProvider<ThemeNotifier, ThemeMode>((ref) {
  return ThemeNotifier();
});
