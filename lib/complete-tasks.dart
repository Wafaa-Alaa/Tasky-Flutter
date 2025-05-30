import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/Models/task-models.dart';
import 'home.dart';

class CompleteTasks extends StatefulWidget {
  const CompleteTasks({super.key});

  @override
  State<CompleteTasks> createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  List<TaskModel> tasksModel = [];

  List<TaskModel> completedTasks = [];


  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    final SharedPreferences sharP = await SharedPreferences.getInstance();
    String? tasks = sharP.getString('tasks');
    if (tasks != null) {
      final tasksDecode = jsonDecode(tasks) as List<dynamic>;
      setState(() {
        tasksModel = tasksDecode.map((e) => TaskModel.fromMap(e)).toList();
        completedTasks = tasksModel.where((task) => task.isCompleted).toList();
        print('dattttttttttt=$tasksModel.toMap()');
      });
    }
  }
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'tasks',
      jsonEncode(tasksModel.map((e) => e.toMap()).toList()),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:SafeArea(

          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      'Completed Tasks',
                      style: Theme.of(context).textTheme.displayMedium
                          ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Expanded(
                  child: ListView.builder(
                    itemCount: completedTasks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Expanded(
                                  child: Checkbox(
                                    value: completedTasks[index].isCompleted,
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if(value==null)
                                          completedTasks[index].isCompleted=false;
                                        else
                                          completedTasks[index].isCompleted = value!;
                                      });

                                      await saveTasks();
                                      print('legth==============${completedTasks.length}');
                                    },
                                    activeColor: Color(0xFF15B86C),
                                  )
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    Text(
                                      completedTasks[index].title,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    SizedBox(height: 5),
                                    Text(
                                      completedTasks[index].desc,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
                              IconButton(
                                icon: Icon(  // You need the Icon widget here
                                  Icons.more_vert,
                                  color: Colors.white,
                                  size: 30,
                                ),
                                onPressed: () {},
                              )                        ],
                          ),
                          height: 60,
                          decoration: BoxDecoration(
                            color: Color(0xFF282828),
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        )
    );
  }
}
