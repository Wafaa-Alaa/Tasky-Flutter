import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tas/core/services/sharedprefernce-manager.dart';
import 'package:tas/navigation-page.dart';

import 'core/Models/task-models.dart';
import 'core/components/custome-textfiled.dart';
import 'home.dart';

class CompleteTasks extends StatefulWidget {
  const CompleteTasks({super.key});

  @override
  State<CompleteTasks> createState() => _CompleteTasksState();
}

class _CompleteTasksState extends State<CompleteTasks> {
  List<TaskModel> tasksModel = [];
  List<TaskModel> completedTasks = [];
  List<TaskModel> toDotasks = [];
  List<TaskModel> isHighPrority = [];
  double completionPercentage = 0.0;


  @override
  void initState() {
    super.initState();
    _getData();
  }

  final SharedPreferencesProvider _prefsProvider = SharedPreferencesProvider();
  String username='';
  void _getData() async {
    String? tasks =await  _prefsProvider.getString('tasks');
    print('lalalalalalaal$tasks');
    username=(await _prefsProvider.getString('username'))!;
    if (tasks != null) {
      final tasksDecode = jsonDecode(tasks) as List<dynamic>;
      setState(() {
        tasksModel = tasksDecode.map((e) => TaskModel.fromMap(e)).toList();
        completedTasks = tasksModel.where((task) => task.isCompleted).toList();
        print('completed tasks.lenhth=======${completedTasks.length}');
        toDotasks = tasksModel.where((task) => task.isCompleted == false).toList();
        isHighPrority = tasksModel.where((task) => task.isHighPrority).toList();
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
                          MaterialPageRoute(builder: (context) => NavigationPage()),
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
                completedTasks.isEmpty
                    ? Padding(
                  padding: const EdgeInsets.only(top: 300),
                      child: Center(child: Container(
                      padding: EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey,
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        'No Complete Tasks',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 18,
                          // color: Colors.white,
                        ),
                      ),
                                        ),
                                      ),
                    ): 
                   Expanded(
                    child: ListView.builder(
                      itemCount: completedTasks.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 8),
                            child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Checkbox(
                                  value: completedTasks[index].isCompleted,
                                  onChanged: (bool? value) async {
                                    setState(() {
                                      if (value == null) {
                                        completedTasks[index].isCompleted = false;

                                      }
                                        else {

                                        completedTasks[index].isCompleted = value!;
                                        completedTasks = tasksModel.where((task) => task.isCompleted).toList();
                                        toDotasks = tasksModel.where((task) => !task.isCompleted).toList();
                                        isHighPrority = tasksModel.where((task) => task.isHighPrority).toList();
                                        completionPercentage = calculateCompletionPercentage();

                                      }
                                        });

                                    await saveTasks();
                                    print(tasksModel);
                                  },
                                  activeColor: Color(0xFF15B86C),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 4),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
                                      mainAxisAlignment: tasksModel[index].desc.isEmpty
                                          ? MainAxisAlignment.center
                                          : MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          tasksModel[index].title,
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                            decoration:  tasksModel[index].isCompleted
                                                ? TextDecoration.lineThrough
                                                : TextDecoration.none,
                                            decorationThickness: 2,
                                              decorationColor:tasksModel[index].isCompleted? Color(0xFF6A6A6A):null,
                                            color:tasksModel[index].isCompleted? Color(0xFF6A6A6A):null

                                          ),
                                        ),
                                        // SizedBox(height: 5),
                                        Text(
                                          tasksModel[index].desc,
                                          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                                              decoration:  tasksModel[index].isCompleted
                                                  ? TextDecoration.lineThrough
                                                  : TextDecoration.none,
                                              decorationThickness: 2,
                                              decorationColor:tasksModel[index].isCompleted? Color(0xFF6A6A6A):null,
                                              color:tasksModel[index].isCompleted? Color(0xFF6A6A6A):null
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Builder(
                                  builder: (context) {
                                    return IconButton(
                                      icon: Icon(
                                        Icons.more_vert,
                                        size: 30,
                                      ),
                                      onPressed: () {
                                        final RenderBox button = context.findRenderObject() as RenderBox;
                                        final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
                                        final RelativeRect position = RelativeRect.fromRect(
                                          Rect.fromPoints(
                                            button.localToGlobal(Offset.zero, ancestor: overlay),
                                            button.localToGlobal(button.size.bottomRight(Offset.zero), ancestor: overlay),
                                          ),
                                          Offset.zero & overlay.size,
                                        );

                                        showMenu<String>(
                                          context: context,
                                          position: position,
                                          color: Theme.of(context).cardTheme.color,
                                          items: [
                                            PopupMenuItem<String>(
                                              value: 'done',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.check, color: Colors.green),
                                                  SizedBox(width: 8),
                                                  Text('Done'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'undone',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.close, color: Colors.orange),
                                                  SizedBox(width: 8),
                                                  Text('Undone'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'edit',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.edit, color: Colors.blue),
                                                  SizedBox(width: 8),
                                                  Text('Edit'),
                                                ],
                                              ),
                                            ),
                                            PopupMenuItem<String>(
                                              value: 'delete',
                                              child: Row(
                                                children: [
                                                  Icon(Icons.delete, color: Colors.red),
                                                  SizedBox(width: 8),
                                                  Text('Delete'),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ).then((value) async {
                                          if (value == 'done') {
                                            setState(() {
                                              tasksModel[index].isCompleted = true;
                                              // Update in high priority list if this task exists there
                                              int highPriorityIndex = isHighPrority.indexWhere((task) => task.id == tasksModel[index].id);
                                              if (highPriorityIndex != -1) {
                                                isHighPrority[highPriorityIndex].isCompleted = true;
                                              }
                                              completedTasks = tasksModel.where((task) => task.isCompleted).toList();
                                              toDotasks = tasksModel.where((task) => !task.isCompleted).toList();
                                              completionPercentage = calculateCompletionPercentage();
                                            });
                                            await saveTasks();
                                          } else if (value == 'undone') {
                                            setState(() {
                                              tasksModel[index].isCompleted = false;
                                              // Update in high priority list if this task exists there
                                              int highPriorityIndex = isHighPrority.indexWhere((task) => task.id == tasksModel[index].id);
                                              if (highPriorityIndex != -1) {
                                                isHighPrority[highPriorityIndex].isCompleted = false;
                                              }
                                              completedTasks = tasksModel.where((task) => task.isCompleted).toList();
                                              toDotasks = tasksModel.where((task) => !task.isCompleted).toList();
                                              completionPercentage = calculateCompletionPercentage();
                                            });
                                            await saveTasks();
                                          }  else if (value == 'delete') {
                                            // Show confirmation dialog
                                            bool confirmDelete = await showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                    title: Text('Confirm Delete'),
                                                    content: Text('Are you sure you want to delete this task?'),
                                                    actions: [
                                                    TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                child: Text('Cancel'),
                                          ),
                                          TextButton(
                                          onPressed: () => Navigator.pop(context, true),
                                          child: Text('Delete', style: TextStyle(color: Colors.red)),
                                          )],
                                          ),
                                          );

                                          if (confirmDelete == true) {
                                          final updatedTasks = List<TaskModel>.from(tasksModel)
                                          ..removeAt(index);

                                          setState(() {
                                          tasksModel = updatedTasks;
                                          completedTasks = tasksModel.where((task) => task.isCompleted).toList();
                                          toDotasks = tasksModel.where((task) => !task.isCompleted).toList();
                                          isHighPrority = tasksModel.where((task) => task.isHighPrority).toList();
                                          completionPercentage = calculateCompletionPercentage();
                                          });
                                          await saveTasks();
                                          }
                                          } else if (value == 'edit') {
                                            final taskToEdit = tasksModel[index];
                                            final editedTask = await showModalBottomSheet<TaskModel>(
                                              context: context,
                                              isScrollControlled: true,
                                              backgroundColor: Colors.transparent,
                                              builder: (context) {
                                                final titleController = TextEditingController(text: taskToEdit.title);
                                                final descController = TextEditingController(text: taskToEdit.desc);
                                                bool isHighPriority = taskToEdit.isHighPrority;
                                                return StatefulBuilder(
                                                  builder: (context, setState) {


                                                    return SafeArea(
                                                      child: Padding(
                                                        padding: const EdgeInsets.symmetric(horizontal: 16),
                                                        child: Container(
                                                          decoration: BoxDecoration(
                                                            color: Theme.of(context).scaffoldBackgroundColor,
                                                            borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                                                          ),
                                                          child: Padding(
                                                            padding: EdgeInsets.only(
                                                              bottom: MediaQuery.of(context).viewInsets.bottom,
                                                            ),
                                                            child: Column(
                                                              mainAxisSize: MainAxisSize.min,
                                                              children: [
                                                                SizedBox(height: 20),
                                                                Row(
                                                                  children: [
                                                                    GestureDetector(
                                                                      onTap: () => Navigator.pop(context),
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
                                                                      'Edit Task',
                                                                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                                                        fontSize: 20,
                                                                        fontWeight: FontWeight.w400,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 40),
                                                                CustomeTextFieled(
                                                                  title: 'Task Name',
                                                                  hintText: 'Enter task name',
                                                                  controller: titleController,
                                                                  validator: (String? name) {
                                                                    if (name == null || name.isEmpty) {
                                                                      return 'Please enter task name';
                                                                    }
                                                                    return null;
                                                                  },
                                                                ),
                                                                SizedBox(height: 24),
                                                                CustomeTextFieled(
                                                                  title: 'Task Description',
                                                                  hintText: 'Enter task description',
                                                                  controller: descController,
                                                                  maxLins: 5,
                                                                ),
                                                                SizedBox(height: 24),
                                                                Row(
                                                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                  children: [
                                                                    Text(
                                                                      'High Priority',
                                                                      style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                                                        fontSize: 20,
                                                                      ),
                                                                    ),
                                                                    Switch(
                                                                      value: isHighPriority,
                                                                      onChanged: (bool value) {
                                                                        setState(() {
                                                                          isHighPriority = value;
                                                                        });
                                                                      },
                                                                    ),
                                                                  ],
                                                                ),
                                                                SizedBox(height: 24),
                                                                ElevatedButton(
                                                                  onPressed: () {
                                                                    if (titleController.text.isNotEmpty) {
                                                                      Navigator.pop(
                                                                        context,
                                                                        TaskModel(
                                                                          id: taskToEdit.id,
                                                                          title: titleController.text,
                                                                          desc: descController.text,
                                                                          isCompleted: taskToEdit.isCompleted,
                                                                          isHighPrority: isHighPriority,
                                                                        ),
                                                                      );
                                                                    }
                                                                  },
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Icon(Icons.save, color: Colors.white),
                                                                      SizedBox(width: 10),
                                                                      Text(
                                                                        'Save Changes',
                                                                        style: Theme.of(context).textTheme.displayMedium?.copyWith(
                                                                          fontSize: 16,
                                                                          color: Colors.white
                                                                        ),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                ),
                                                                SizedBox(height: 10),
                                                                Container(
                                                                  width: 108,
                                                                  height: 4,
                                                                  decoration: BoxDecoration(
                                                                    color: const Color(0xFFFFFCFC),
                                                                    borderRadius: BorderRadius.circular(12),
                                                                  ),
                                                                ),
                                                                SizedBox(height: 20),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );

                                            if (editedTask != null) {
                                              setState(() {
                                                tasksModel[index] = editedTask;
                                                // Update all derived lists
                                                completedTasks = tasksModel.where((task) => task.isCompleted).toList();
                                                toDotasks = tasksModel.where((task) => !task.isCompleted).toList();
                                                isHighPrority = tasksModel.where((task) => task.isHighPrority).toList();
                                                completionPercentage = calculateCompletionPercentage();
                                              });
                                              await saveTasks();
                                            }
                                          }
                                        });
                                      },
                                    );
                                  },
                                )
                              ],
                            ),
                            height: 60,
                            decoration: BoxDecoration(
                              color: Theme.of(context).cardTheme.color,
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
