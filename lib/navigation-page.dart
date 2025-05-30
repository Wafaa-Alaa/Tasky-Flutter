import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tas/add-task.dart';
import 'package:tas/complete-tasks.dart';
import 'package:tas/profile.dart';
import 'package:tas/to-do-tasks.dart';

import 'home.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  final List<Widget> _screens=[
    Home(),
    ToDoTasks(),
    CompleteTasks(),
    Profile()
    // AddTask(),
    // CompleteTasks(),
  ];
  int _currentIndex=0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (int index){
           setState(() {
             _currentIndex=index;
             print(_currentIndex);
           });
          },
          items: [

        BottomNavigationBarItem(icon:SvgPicture.asset(
          'assets/images/home.svg',
          width: 24,
          height: 24,
        ) ,label: 'Home'),
        BottomNavigationBarItem(icon:SvgPicture.asset(
          'assets/images/todo.svg',
          width: 24,
          height: 24,
        ) ,label: 'To Do'),
        BottomNavigationBarItem(icon:SvgPicture.asset(
          'assets/images/complete.svg',
          width: 24,
          height: 24,
        ),label: 'Completed'),
        BottomNavigationBarItem(icon:SvgPicture.asset(
          'assets/images/profile.svg',
          width: 24,
          height: 24,
        ) ,label: 'Profile'),
      ]),
      body:_screens[_currentIndex],
    );
  }
}
