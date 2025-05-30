import 'package:flutter/material.dart';

ThemeData get darkTheme {
  return ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xFF181818),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: const Color(0xFF181818),
      selectedIconTheme: const IconThemeData(color: Color(0xFF15B86C)),
      unselectedIconTheme: const IconThemeData(color: Colors.white),
      type: BottomNavigationBarType.fixed,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF15B86C);
        }
        return Colors.grey;
      }),
      thumbColor: MaterialStateProperty.resolveWith<Color>((states) {
        return Colors.white;
      }),
      trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
        return Colors.white;
      }),
      trackOutlineWidth: MaterialStateProperty.resolveWith<double>((states) {
        return 1.5;
      }),
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
      filled: true,
      fillColor: const Color(0xFF6D6D6D),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF15B86C),
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(40),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
        textStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    ),
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 28,
        color: Color(0xFFFFFFFF),
      ),
    ),
    colorScheme: const ColorScheme.dark(
      primary: Color(0xFF15B86C),
      secondary: Color(0xFF15B86C),
      surface: Color(0xFF181818),
    ),
  );
}