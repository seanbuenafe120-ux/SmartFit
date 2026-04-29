import 'package:flutter/material.dart';
import 'constants.dart';
import 'main_screen.dart';
import 'screens/login.dart';
import 'screens/gym_lobby.dart';
import 'screens/workout.dart';
import 'screens/profile.dart';
import 'screens/about.dart';

void main() => runApp(const GymApp());

class GymApp extends StatelessWidget {
  const GymApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: GymAppColors.darkBg,
        primaryColor: GymAppColors.primaryBlue,
        fontFamily: 'Poppins',
        colorScheme: const ColorScheme.dark(
          primary: GymAppColors.primaryBlue,
          secondary: GymAppColors.accentCyan,
          surface: GymAppColors.cardBg,
          onSurface: GymAppColors.textPrimary,
          error: GymAppColors.accentRed,
        ),
        cardTheme: CardThemeData(
          color: GymAppColors.cardBg,
          elevation: 0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
          margin: EdgeInsets.zero,
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: GymAppColors.cardBg,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.white10, width: 1.5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: Colors.white10, width: 1.5),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: const BorderSide(color: GymAppColors.primaryBlue, width: 2),
          ),
          labelStyle: const TextStyle(color: GymAppColors.textSecondary),
          hintStyle: const TextStyle(color: GymAppColors.textSecondary),
          contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
          prefixIconColor: GymAppColors.primaryBlue,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: GymAppColors.primaryBlue,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            elevation: 8,
            shadowColor: GymAppColors.primaryBlue.withOpacity(0.4),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            side: const BorderSide(color: GymAppColors.primaryBlue, width: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
            textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: GymAppColors.textPrimary,
            letterSpacing: 1.2,
          ),
          iconTheme: IconThemeData(color: GymAppColors.primaryBlue),
        ),
      ),
      home: const LoginScreen(),
    );
  }
}
