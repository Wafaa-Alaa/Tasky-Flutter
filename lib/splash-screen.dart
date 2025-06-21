import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tas/core/themes/dark-theme.dart';
import 'package:tas/core/themes/light-theme.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark 
          ? darkTheme.scaffoldBackgroundColor 
          : lightTheme.scaffoldBackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/images/Vector.svg',
              width: 80,
              height: 80,
              // color: isDark ? Colors.white : Colors.black,
            ),
            const SizedBox(height: 20),
                     ],
        ),
      ),
    );
  }
}