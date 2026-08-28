import 'package:flutter/material.dart';

class ThemeService {
  ThemeService._();
  static final instance = ThemeService._();

  final ValueNotifier<ThemeMode> themeMode = ValueNotifier(ThemeMode.dark);

  void toggleTheme() {
    themeMode.value = themeMode.value == ThemeMode.dark 
        ? ThemeMode.light 
        : ThemeMode.dark;
  }
}
