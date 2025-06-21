import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tas/core/services/sharedprefernce-manager.dart';

class ThemeController extends ChangeNotifier {
  static final ThemeController _instance = ThemeController._internal();
  factory ThemeController() => _instance;
  ThemeController._internal();

  final ValueNotifier<ThemeMode> themeNotifier = ValueNotifier(ThemeMode.dark);
  final SharedPreferencesProvider _prefsProvider = SharedPreferencesProvider();
  
  ThemeMode get themeMode => themeNotifier.value;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> toggleTheme() async {
    themeNotifier.value = isDarkMode ? ThemeMode.light : ThemeMode.dark;
    await _prefsProvider.setBool('isDarkMode', themeNotifier.value == ThemeMode.dark);
    notifyListeners();
  }

  Future<void> loadTheme() async {
    final isDark = await _prefsProvider.getBool('isDarkMode') ?? false;
    themeNotifier.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}