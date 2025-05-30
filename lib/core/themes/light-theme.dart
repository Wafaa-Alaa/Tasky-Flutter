import 'package:flutter/material.dart';

ThemeData get lightTheme {
  return ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF5F5F5),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFFFFFFF),
      selectedIconTheme: IconThemeData(color: Color(0xFF15B86C)),
      unselectedIconTheme: IconThemeData(color: Color(0xFF757575)),
      type: BottomNavigationBarType.fixed,
    ),
    switchTheme: SwitchThemeData(
      trackColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF15B86C).withOpacity(0.5);
        }
        return const Color(0xFFE0E0E0); // Replaced Colors.grey.shade300
      }),
      thumbColor: MaterialStateProperty.all(Colors.white),
      trackOutlineColor: MaterialStateProperty.all(const Color(0xFFBDBDBD)), // Replaced Colors.grey.shade400
      trackOutlineWidth: MaterialStateProperty.all(1.5),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
      filled: true,
      fillColor: Color(0xFFFFFFFF),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: Color(0xFFE0E0E0)),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Color(0xFF15B86C),
      selectionColor: Color(0x6615B86C), // Hex for 40% opacity
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF15B86C),
        foregroundColor: Colors.white,
        minimumSize: const Size.fromHeight(40),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(100)),
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
        color: Color(0xFF000000),
      ),
    ),
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF15B86C),
      secondary: Color(0xFF15B86C),
      surface: Color(0xFFFFFFFF),
    ),
  );
}