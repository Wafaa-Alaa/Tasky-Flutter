import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'core/Models/task-models.dart';
import 'core/components/custome-textfiled.dart';

class TaskEditBottomSheet extends StatefulWidget {
  final TaskModel initialTask;
  final Function(TaskModel) onSave;

  const TaskEditBottomSheet({
    super.key,
    required this.initialTask,
    required this.onSave,
  });

  @override
  State<TaskEditBottomSheet> createState() => _TaskEditBottomSheetState();
}

class _TaskEditBottomSheetState extends State<TaskEditBottomSheet> {
  late final TextEditingController _nameController;
  late final TextEditingController _descController;
  late bool _isHighPriority;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialTask.title);
    _descController = TextEditingController(text: widget.initialTask.desc);
    _isHighPriority = widget.initialTask.isHighPrority;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
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
                  const SizedBox(width: 16),
                  Text(
                    'Edit Task',
                    style: Theme.of(context).textTheme.displayMedium?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              CustomeTextFieled(
                title: 'Task Name',
                hintText: 'Enter task name',
                controller: _nameController,
                validator: (String? name) {
                  if (name == null || name.isEmpty) {
                    return 'Please enter task name';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              CustomeTextFieled(
                title: 'Task Description',
                hintText: 'Enter task description',
                controller: _descController,
                maxLins: 5,
              ),
              const SizedBox(height: 24),
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
                    value: _isHighPriority,
                    onChanged: (bool value) {
                      setState(() {
                        _isHighPriority = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState?.validate() ?? false) {
                    final editedTask = TaskModel(
                      id: widget.initialTask.id,
                      title: _nameController.text,
                      desc: _descController.text,
                      isHighPrority: _isHighPriority,
                      isCompleted: widget.initialTask.isCompleted,
                    );
                    widget.onSave(editedTask);
                    Navigator.pop(context);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.save, color: Colors.white),
                    const SizedBox(width: 10),
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
              const SizedBox(height: 10),
              Container(
                width: 108,
                height: 4,
                decoration: BoxDecoration(
                  color: const Color(0xFFFFFCFC),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}