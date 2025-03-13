import 'package:todo_app/features/create_new_task/data/task_database.dart';
import 'package:todo_app/services/notification_service.dart';

class TaskRepository {
  final TaskDatabase _taskDatabase = TaskDatabase();

  Future<String> addTask(Map<String, dynamic> task) async {
    final String taskId = await _taskDatabase.insertTask(task);

    if (task['taskDeadline'] != null) {
      DateTime deadline = DateTime.parse(task['taskDeadline']);
      await NotificationService.scheduleNotification(
          taskId, task['taskTitle'], deadline);
    }

    return taskId;
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final records = await _taskDatabase.getAllTasks();
    return records.map((snapshot) {
      final task = snapshot.value;

      return task;
    }).toList();
  }

  Future<void> updateTask(String id, Map<String, dynamic> task) async {
    if (task['taskDeadline'] != null) {
      DateTime deadline = DateTime.parse(task['taskDeadline']);

      await NotificationService.scheduleNotification(
          id, task['taskTitle'], deadline);
    }

    return _taskDatabase.updateTask(id, task);
  }

  Future<void> deleteTask(String id) {
    return _taskDatabase.deleteTask(id);
  }
}
