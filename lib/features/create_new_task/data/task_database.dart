import 'package:sembast/sembast_io.dart';
import 'package:path_provider/path_provider.dart';

// create class TaskDatabase. it`s a Singleton
class TaskDatabase {
  static final TaskDatabase _instance = TaskDatabase._internal();
  TaskDatabase._internal();
  factory TaskDatabase() => _instance;

  Database? _database;
  final _taskStore = stringMapStoreFactory.store('tasks');

  Future<Database> get database async {
    if (_database == null) {
      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = '${dir.path}/tasks.db';
      _database = await databaseFactoryIo.openDatabase(dbPath);
    }
    return _database!;
  }

  Future<String> insertTask(Map<String, dynamic> task) async {
    return await _taskStore.add(await database, task);
  }

  Future<List<RecordSnapshot<String, Map<String, dynamic>>>> getAllTasks() async {
    return await _taskStore.find(await database);
  }

  Future<void> updateTask(String id, Map<String, dynamic> task) async {
    await _taskStore.record(id).update(await database, task);
  }

  Future<void> deleteTask(String id) async {
    await _taskStore.record(id).delete(await database);
  }
}




