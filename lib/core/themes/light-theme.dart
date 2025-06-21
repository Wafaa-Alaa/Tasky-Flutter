import 'package:flutter/material.dart';

ThemeData get lightTheme {
  return ThemeData(
    useMaterial3: true,
    brightness: Brightness.light,
    scaffoldBackgroundColor: const Color(0xFFF1F2F6),

    // Color Scheme
    colorScheme: const ColorScheme.light(
      primary: Color(0xFF15B86C), // Primary green
      secondary: Color(0xFF15B86C), // Secondary green
      surface: Color(0xFFFFFFFF), // Card backgrounds
      background: Color(0xFFF6F7F9), // Scaffold background
      onSurface: Color(0xFF000000), // Main text color
      onBackground: Color(0xFF000000), // Background text color
      error: Colors.red, // Error color
    ),

    // App Bar
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFF6F7F9),
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: Color(0xFF000000),
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      iconTheme: IconThemeData(color: Color(0xFF000000)),
    ),

    // Welcome Screen Typography
    textTheme: const TextTheme(
      // displayMedium: TextStyle(
      //   fontSize: 28,
      //   color: Color(0xFFFFFFFF),
      // ),
      displayLarge: TextStyle( // "Welcome To Tasky"
        fontSize: 28,
        fontWeight: FontWeight.w900,
        color: Colors.white,
      ),
      headlineMedium: TextStyle( // "Your productivity journey..."
          decorationThickness: 2.5,
          decorationColor: Color(0xFF6A6A6A),
          color: Color(0xFF6A6A6A)
      ),
      titleLarge: TextStyle( // Section headers like "Achieved Tasks"
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Color(0xFF000000),
      ),
      bodyLarge: TextStyle( // Regular task text
        fontSize: 17,
        fontWeight: FontWeight.w600,
        color: Color(0xFF000000),
      ),
      bodyMedium: TextStyle( // Subtle text like "3 out of 5 Done"
        fontSize: 14,
        color: Color(0xFF757575),
      ),
      labelLarge: TextStyle( // Button text
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
    ),

    // Input Fields (for "Full Name" screen)
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.all(16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: Color(0xFF15B86C),
          width: 1.5,
        ),
      ),
      hintStyle: const TextStyle(
        color: Color(0xFF9E9E9E),
      ),
      labelStyle: const TextStyle(
        color: Color(0xFF757575),
      ),
    ),

    // Buttons ("Let's Get Started" button)
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
          if (states.contains(MaterialState.disabled)) {
            return const Color(0xFF15B86C).withOpacity(0.5);
          }
          return const Color(0xFF15B86C);
        }),
        foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
        minimumSize: MaterialStateProperty.all<Size>(const Size.fromHeight(40)),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),

    // Task Cards (for task lists)
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 0,
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: const BorderSide(
          color:Color(0xFFD1DAD6),
          width:2,
        ),
      ),
    ),

    // Task Items (list tiles)
    listTileTheme: const ListTileThemeData(
      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      titleTextStyle: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Color(0xFF000000),
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xFF757575),
      ),
    ),

    // Checkboxes (for task completion)
    checkboxTheme: CheckboxThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(4),
      ),
      side: const BorderSide(
        color: Color(0xFFD1DAD6),
        width: 3,
      ),
      fillColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF15B86C);
        }
        return Colors.transparent;
      }),
    ),

    // Progress Indicator ("3 out of 5 Done")
    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: Color(0xFF15B86C),
      linearTrackColor: Color(0xFFD1DAD6),
    ),

    // Bottom Navigation Bar
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Color(0xFFF1F2F6),
      selectedItemColor: Color(0xFF15B86C),
      unselectedItemColor: Color(0xFF3A4640),
      selectedLabelStyle: TextStyle(fontSize: 12),
      unselectedLabelStyle: TextStyle(fontSize: 12),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),

    // Divider (between sections)
    dividerTheme: const DividerThemeData(
      color: Colors.grey,
      space: 16,
      thickness: 1,
    ),

    // Profile Screen Items
    chipTheme: ChipThemeData(
      backgroundColor: const Color(0xFFF1F1F1),
      labelStyle: const TextStyle(
        color: Color(0xFF000000),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      side: BorderSide.none,
    ),
  );
}