import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/Models/task-models.dart';
import 'home.dart';

class ToDoTasks extends StatefulWidget {
  const ToDoTasks({super.key});

  @override
  State<ToDoTasks> createState() => _ToDoTasksState();
}

class _ToDoTasksState extends State<ToDoTasks> {
  List<TaskModel> toDotasks = [];
  List<TaskModel> tasksModel = [];
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
        toDotasks=tasksModel.where((task) => task.isCompleted==false).toList();

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
                    'To Do Tasks',
                    style: Theme.of(context).textTheme.displayMedium
                        ?.copyWith(fontSize: 20, fontWeight: FontWeight.w400),
                  ),
                ],
              ),
              SizedBox(height: 40),
              Expanded(
                child: ListView.builder(
                  itemCount: toDotasks.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Checkbox(
                                  value: toDotasks[index].isCompleted,
                                  onChanged: (bool? value) async {
                                    setState(() {
                                      if(value==null)
                                        toDotasks[index].isCompleted=false;
                                      else
                                        toDotasks[index].isCompleted = value!;
                                    });
                
                                    await saveTasks();
                                    print('legth==============${toDotasks.length}');
                                  },
                                  activeColor: Color(0xFF15B86C),
                                )
                            ),
                            Expanded(
                              child: Column(
                                children: [
                                  Text(
                                    toDotasks[index].title,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    toDotasks[index].desc,
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
