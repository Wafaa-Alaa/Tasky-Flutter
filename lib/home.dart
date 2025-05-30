import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tas/add-task.dart';
import 'package:tas/core/Models/task-models.dart';
import 'package:tas/start.dart';

class Home extends StatefulWidget {
  Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<TaskModel> tasksModel = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> toDotasks = [];
  List<TaskModel> isHighPrority=[];
  double completionPercentage = 0.0;
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
        toDotasks=tasksModel.where((task) => task.isCompleted==false).toList();
        isHighPrority=tasksModel.where((task) => task.isHighPrority).toList();
        completionPercentage = calculateCompletionPercentage();
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
  double calculateCompletionPercentage() {
    if (tasksModel.isEmpty) return 0.0;
    int completedCount = tasksModel.where((task) => task.isCompleted).length;
    return (completedCount / tasksModel.length) * 100;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
        child: Column(
          children: [
            SizedBox(width: 375, height: 52),
            Row(
              children: [
                Image.asset(
                  'assets/images/Thumbnail.png',
                  width: 60,
                  height: 60,
                ),
                SizedBox(width: 20),
                Column(
                  children: [
                    Text(
                      'Good Evening ,Usama ',
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium?.copyWith(fontSize: 20),
                    ),
                    Text(
                      'One task at a time.One step\n closer. ',
                      style: Theme.of(
                        context,
                      ).textTheme.displayMedium?.copyWith(fontSize: 16),
                    ),
                  ],
                ),
                SizedBox(width: 100),
                CircleAvatar(
                  backgroundColor: const Color(0xFF282828),
                  radius: 17,
                  child: SvgPicture.asset(
                    'assets/images/Icon.svg',
                    width: 18, // Image width
                    height: 18, // Image height
                  ),
                ),
              ],
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Yuhuu ,Your work Is ',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 32),
              ),
            ),
            SizedBox(height: 4),
            Row(
              children: [
                Text(
                  'almost done ! ',
                  style: Theme.of(
                    context,
                  ).textTheme.displayMedium?.copyWith(fontSize: 32),
                ),
                SvgPicture.asset(
                  'assets/images/hand3.svg',
                  width: 32,
                  height: 32,
                ),
              ],
            ),
            SizedBox(height: 16,),
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF282828),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Achieved Tasks',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8),
                        Text(
                          '${completedTasks.length} Out of ${tasksModel.length} Done',
                          style: Theme.of(context).textTheme.displayMedium?.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Stack(
                    children: [
                      // Gray background for incomplete portion
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          value: 1.0, // Always full circle
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(Colors.grey.withOpacity(0.3)),
                          strokeWidth: 2,
                        ),
                      ),
                      // Green progress for completed portion
                      SizedBox(
                        height: 40,
                        width: 40,
                        child: CircularProgressIndicator(
                          value: calculateCompletionPercentage() / 100,
                          backgroundColor: Colors.transparent,
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF15B86C)),
                          strokeWidth: 2,
                        ),
                      ),
                      // Percentage text in center
                      Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.transparent,
                        ),
                        child: Center(
                          child: Text(
                            '${calculateCompletionPercentage().toStringAsFixed(0)}%',
                            style: Theme.of(context).textTheme.displayMedium?.copyWith(
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 12,),
            Expanded(

              child: Container(
                width: double.infinity, // Takes full width
                constraints: BoxConstraints(
                    minHeight: 200, // Minimum height
                    maxHeight: double.infinity, ),
                decoration: BoxDecoration(
                  color: Color(0xFF282828),
                  borderRadius: BorderRadius.circular(8),
                ),
                // color: ,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'High Priority Tasks',
                        style: Theme.of(
                          context,
                        ).textTheme.displayMedium?.copyWith(fontSize: 22,color: Color(0xFF15B86C)),
                      ),
                      SizedBox(height: 8,),
                      Expanded(
                        child: ListView.builder(
                          itemCount: isHighPrority.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  Checkbox(
                                    value: isHighPrority[index].isCompleted,
                                    onChanged: (bool? value) async {
                                      setState(() {
                                        if(value==null)
                                          isHighPrority[index].isCompleted=false;
                                        else
                                          isHighPrority[index].isCompleted = value!;
                                      });
                        
                                      await saveTasks();
                                      print('legth==============${isHighPrority.length}');
                                    },
                                    activeColor: Color(0xFF15B86C),
                                  ),
                                  Text(
                                    isHighPrority[index].title,
                                    style: TextStyle(color: Colors.white),
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
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'My Tasks',
                style: Theme.of(
                  context,
                ).textTheme.displayMedium?.copyWith(fontSize: 22),
              ),
            ),
            SizedBox(
              height: 400,
              child: ListView.builder(
                itemCount: tasksModel.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Container(
                      child: Row(
                        children: [
                          Expanded(
                            child: Checkbox(
                              value: tasksModel[index].isCompleted,
                              onChanged: (bool? value) async {
                                setState(() {
                                  if(value==null)
                                    tasksModel[index].isCompleted=false;
                                  else
                                  tasksModel[index].isCompleted = value!;
                                });

                                 await saveTasks();
                                 print(tasksModel);
                              },
                              activeColor: Color(0xFF15B86C),
                            )
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  tasksModel[index].title,
                                  style: TextStyle(color: Colors.white),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  tasksModel[index].desc,
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

            SizedBox(
              width: 167,
              height: 40,
              child: FloatingActionButton(
                backgroundColor: Color(0xFF15B86C),
                onPressed: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return AddTask();
                      },
                    ),
                  );
                  _getData();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Text('+',style: Theme.of(context).textTheme.displayMedium?.copyWith(
                    //   fontSize:12 ,
                    // ),),
                    Icon(Icons.add, color: Colors.white),
                    SizedBox(width: 8),
                    Row(
                      children: [
                        Text(
                          'Add New Task',
                          style: Theme.of(
                            context,
                          ).textTheme.displayMedium?.copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
