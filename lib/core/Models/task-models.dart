import 'package:flutter/foundation.dart';

class TaskModel {
  final int id;
  final String title;
  final String desc;
  final bool isHighPrority;

  TaskModel({
    required this.id,
    required this.desc,
    required this.isHighPrority,
    required this.title,
  });

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      id: map['id'] ?? 0, // Provide default if null
      title: map['title'] ?? '',
      desc: map['desc'] ?? '',
      isHighPrority: map['isHighPrority'] ?? false,
    );
  }
  Map<String,dynamic> toMap()
  {
    return{
      'id':this.id,
      'title':this.title,
      'Description':this.desc,
      'isHighPrority':this.isHighPrority,
    };
  }
  @override
  String toString() {
    return '{'
        'id: $id, '
        'title: "$title", '
        'desc: "$desc", '
        'isHighPrority: $isHighPrority'
        '}';
  }
}
