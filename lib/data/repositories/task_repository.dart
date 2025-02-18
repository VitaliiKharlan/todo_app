import 'package:todo_app/data/task_database.dart';

class TaskRepository {
  final TaskDatabase _taskDatabase = TaskDatabase();

  Future<int> addTask(Map<String, dynamic> task) {
    return _taskDatabase.insertTask(task);
  }

  Future<List<Map<String, dynamic>>> fetchTasks() async {
    final records = await _taskDatabase.getAllTasks();
    return records.map((snapshot) {
      final task = snapshot.value;

      print('Tasks loaded: ${records.map((record) => record.value)}');

      task['id'] = snapshot.key;
      return task;
    }).toList();
  }

  Future<void> updateTask(int id, Map<String, dynamic> task) {
    return _taskDatabase.updateTask(id, task);
  }

  Future<void> deleteTask(int id) {
    return _taskDatabase.deleteTask(id);
  }
}
