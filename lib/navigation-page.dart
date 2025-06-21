import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tas/add-task.dart';
import 'package:tas/complete-tasks.dart';
import 'package:tas/profile.dart';
import 'package:tas/to-do-tasks.dart';
import 'package:tas/home.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<Widget> _screens = [
    Home(),
    const ToDoTasks(),
    const CompleteTasks(),
    const Profile(),
  ];

  int _currentIndex = 0;

  ColorFilter _getColorFilter(bool isActive, BuildContext context) {
    final theme = Theme.of(context);
    return ColorFilter.mode(
      isActive
          ? theme.colorScheme.primary // Use primary color from theme for active
          : theme.bottomNavigationBarTheme.unselectedItemColor ?? Colors.grey,
      BlendMode.srcIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        backgroundColor: theme.bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.bottomNavigationBarTheme.unselectedItemColor,
        showSelectedLabels: true,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home.svg',
              width: 24,
              height: 24,
              colorFilter: _getColorFilter(_currentIndex == 0, context),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/todo.svg',
              width: 24,
              height: 24,
              colorFilter: _getColorFilter(_currentIndex == 1, context),
            ),
            label: 'To Do',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/complete.svg',
              width: 24,
              height: 24,
              colorFilter: _getColorFilter(_currentIndex == 2, context),
            ),
            label: 'Completed',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/profile.svg',
              width: 24,
              height: 24,
              colorFilter: _getColorFilter(_currentIndex == 3, context),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}