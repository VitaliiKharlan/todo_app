import 'package:flutter/material.dart';

import 'package:todo_app/features/create_new_task/data/task_database.dart';

class TaskRepository {
  final TaskDatabase _taskDatabase = TaskDatabase();

  Future<String> addTask(Map<String, dynamic> task) {
    return _taskDatabase.insertTask(task);
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final records = await _taskDatabase.getAllTasks();
    return records.map((snapshot) {
      final task = snapshot.value;

      debugPrint('Tasks loaded: ${records.map((record) => record.value)}');

      return task;
    }).toList();
  }

  Future<void> updateTask(String id, Map<String, dynamic> task) {
    return _taskDatabase.updateTask(id, task);
  }

  Future<void> deleteTask(String id) {
    return _taskDatabase.deleteTask(id);
  }
}
