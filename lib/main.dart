import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tas/add-task.dart';
import 'package:tas/navigation-page.dart';

import 'core/themes/dark-theme.dart';
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
      theme:darkTheme,
      home:username==null?Start():NavigationPage(),
    );
  }
}


