import 'package:flutter/material.dart';

class AppColors {
  // Dark Theme
  static const Color background = Color(0xFF121212);
  static const Color cardBg = Color(0xFF1E1E1E);
  static const Color textLight = Colors.white;
  static const Color textGrey = Color(0xFFAAAAAA);

  // Light Theme
  static const Color backgroundLight = Color(0xFFF5F5F5);
  static const Color cardBgLight = Color(0xFFFFFFFF);
  static const Color textDark = Color(0xFF212121);
  static const Color textGreyLight = Color(0xFF757575);

  // Shared
  static const Color accent = Color(0xFFFFB300);
  static const Color secondary = Color(0xFFFF6F00);
  
  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF121212), Color(0xFF1E1E1E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
