import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tas/core/Models/task-models.dart';
import 'package:tas/core/components/custome-textfiled.dart';
import 'package:tas/core/services/sharedprefernce-manager.dart';
import 'package:tas/navigation-page.dart';

import 'home.dart';

class AddTask extends StatefulWidget {
  AddTask({super.key});

  @override
  State<AddTask> createState() => _AddTaskState();
}

class _AddTaskState extends State<AddTask> {
  final TextEditingController controllerName = TextEditingController();

  final TextEditingController controllerDes = TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  bool isHeightPrority = false;

  final SharedPreferencesProvider _prefsProvider = SharedPreferencesProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: _key,
            child: Column(
              children: [
                SizedBox(width: 375, height: 52),
                Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Home()),
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: const Color(0xFF282828),
                        radius: 17,
                        child: SvgPicture.asset(
                          'assets/images/Icon2.svg',
                          width: 18,
                          height: 18,
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Text(
                      'New Task',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                CustomeTextFieled(
                  title: 'Task Name',
                  hintText: 'Finish UI design for login screen',
                  controller: controllerName,
                  validator: (String? name) {
                    if (name == null || name.isEmpty)
                      return 'Please Enter Task Name';
                    return null;
                  },
                ),
                SizedBox(height: 24),
                CustomeTextFieled(
                  title: 'Task Description',
                  hintText:
                      'Finish onboarding UI and hand off to\n devs by Thursday.',
                  controller: controllerDes,
                  maxLins: 5,
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'High Priority ',
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium?.copyWith(fontSize: 20),
                    ),
                    Switch(
                      value: isHeightPrority,
                      onChanged: (bool value) {
                        setState(() {
                          isHeightPrority = value;
                        });
                      },
                    ),
                  ],
                ),
                SizedBox(height: 200),
                ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState?.validate() ?? false) {
                      // Get existing tasks
                      String? tasksString = await _prefsProvider.getString('tasks');
                      List<dynamic> listTasks = [];

                      if (tasksString != null) {
                        listTasks = jsonDecode(tasksString);
                      }

                      // Create new task
                      TaskModel task = TaskModel(
                        id: listTasks.length + 1,
                        desc: controllerDes.text,
                        isHighPrority: isHeightPrority,
                        title: controllerName.text,
                        isCompleted: false,
                      );

                      // Add new task
                      listTasks.add(task.toMap());

                      // Save tasks
                      await _prefsProvider.setString('tasks', jsonEncode(listTasks));

                      // Clear fields and pop
                      controllerName.clear();
                      controllerDes.clear();
                      print('data saved lolololo');
                      // Navigator.pop(context);// This will now work
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) =>NavigationPage()),
                      );
                    }
                  },

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.add, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'Add Task',
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium?.copyWith(fontSize: 16,color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  width: 108,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Color(0xFFFFFCFC),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
