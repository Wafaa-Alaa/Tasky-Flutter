import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tas/add-task.dart';
import 'package:tas/navigation-page.dart';

import 'home.dart';
import 'start.dart';

void main() async {
 WidgetsFlutterBinding.ensureInitialized();
 final SharedPreferences sharP = await SharedPreferences.getInstance();
  String? username=sharP.getString('username');
  runApp( MyApp(username: username));
}

class MyApp extends StatelessWidget {
   MyApp({super.key,required this.username});
  String? username;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF181818),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF181818),
          selectedIconTheme:IconThemeData( color: Color(0xFF15B86C)),
          unselectedIconTheme:IconThemeData( color: Colors.white),
          type: BottomNavigationBarType.fixed,
        ),
        switchTheme: SwitchThemeData(
          // Track colors
          trackColor:WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return Color(0xFF15B86C) ;// Active track color
            }
            return Colors.grey; // Inactive track color
          }),

          // Thumb colors
          thumbColor:WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return Colors.white; // Active thumb color
            }
            return Colors.white; // Inactive thumb color
          }),
          trackOutlineColor: WidgetStateProperty.resolveWith<Color>((states) {
            return Colors.white;// Border color (adjust opacity as needed)
          }),
          trackOutlineWidth: WidgetStateProperty.resolveWith<double>((states) {
            return 1.5; // Border width
          }),
        ),
        inputDecorationTheme: InputDecorationTheme(
          hintStyle: TextStyle(color: Color(0xFF9E9E9E)),
          filled: true,
          fillColor: Color(0xFF6D6D6D),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide.none,
          ),
        ),
        textSelectionTheme: TextSelectionThemeData(
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
        textTheme: TextTheme(
          displayMedium: TextStyle(
            fontSize: 28,
            color: Color(0xFFFFFFFF),
          ),
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:username==null?Start():NavigationPage(),
    );
  }
}


