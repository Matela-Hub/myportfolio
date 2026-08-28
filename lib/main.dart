import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/screens/home_screen.dart';
import 'package:myportfolio/constants/colors.dart';
import 'package:myportfolio/constants/theme_service.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeService.instance.themeMode,
      builder: (context, mode, child) {
        return MaterialApp(
          title: 'Matela Moshate Portfolio',
          debugShowCheckedModeBanner: false,
          themeMode: mode,
          theme: ThemeData(
            brightness: Brightness.light,
            scaffoldBackgroundColor: AppColors.backgroundLight,
            textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme).copyWith(
              displayLarge: const TextStyle(color: AppColors.textDark),
              bodyLarge: const TextStyle(color: AppColors.textDark),
              bodyMedium: const TextStyle(color: AppColors.textGreyLight),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.accent,
              primary: AppColors.accent,
              secondary: AppColors.secondary,
              surface: AppColors.cardBgLight,
              brightness: Brightness.light,
            ),
            useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            scaffoldBackgroundColor: AppColors.background,
            textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme).copyWith(
              displayLarge: const TextStyle(color: AppColors.textLight),
              bodyLarge: const TextStyle(color: AppColors.textLight),
              bodyMedium: const TextStyle(color: AppColors.textGrey),
            ),
            colorScheme: ColorScheme.fromSeed(
              seedColor: AppColors.accent,
              primary: AppColors.accent,
              secondary: AppColors.secondary,
              surface: AppColors.cardBg,
              brightness: Brightness.dark,
            ),
            useMaterial3: true,
            elevatedButtonTheme: ElevatedButtonThemeData(
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.accent,
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
          home: const HomeScreen(),
        );
      },
    );
  }
}
