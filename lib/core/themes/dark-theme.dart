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
        if (states.contains(MaterialState.disabled)) {
          return Colors.grey[600]!;
        }
        return Colors.white;
      }),
      trackOutlineColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFF15B86C).withOpacity(0.5);
        }
        return Colors.white;
      }),
      trackOutlineWidth: MaterialStateProperty.all<double>(1.5),
    ),
     dividerTheme: const DividerThemeData(
      color: Color(0xFFE0E0E0),
      space: 16,
      thickness: 1,
    ),
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: const TextStyle(color: Color(0xFF9E9E9E)),
      filled: true,
      fillColor: const Color(0xFF282828),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Color(0xFF15B86C), width: 1.5),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: Colors.red),
      ),
    ),
    textSelectionTheme: const TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Color(0x6615B86C),
    ),
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
    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 28,
        color: Color(0xFFFFFFFF),
      ),
      titleLarge: TextStyle( // Section headers like "Achieved Tasks"
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      headlineMedium: TextStyle( // "Your productivity journey..."
          decorationThickness: 2.5,
          decorationColor: Color(0xFF6A6A6A),
          color: Color(0xFF6A6A6A)
      ),
      bodyLarge: TextStyle( // Regular task text
        fontSize: 17,
        fontWeight: FontWeight.w600,
        // color: Color(0xFF000000),
      ),
    ),
    cardTheme: CardThemeData(
      color: Color(0xFF282828),
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
    colorScheme: ColorScheme.dark(
      primary: const Color(0xFF15B86C),
      secondary: const Color(0xFF15B86C),
      surface: const Color(0xFF181818),
      onSurface: Colors.white,
      error: Colors.red,
    ),
  );
}