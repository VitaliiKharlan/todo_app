import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';
import 'package:todo_app/features/task/task.dart';

@RoutePage()
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final List<Task> _todoList = [];
  final TextEditingController _controller = TextEditingController();
  DateTime? selectedDeadline;

  // passing a variable to a function
  void _addTodo(AddNewTaskBloc bloc) {
    final taskTitle = _controller.text.trim();
    if (taskTitle.isNotEmpty) {
      bloc.add(AddNewTaskLoadedEvent(taskTitle));
      //
      // Navigator.of(context)
      //
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => TaskScreen(theme: theme)));
      //
      //
      // auto_route
      //
      // context.router.push(TaskScreenRoute());
      //
    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != selectedDeadline) {
      selectedDeadline = picked;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (picked != null) {
      final DateTime now = DateTime.now();
      selectedDeadline =
          DateTime(now.year, now.month, now.day, picked.hour, picked.minute);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AddNewTaskBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'Add New Task',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter a task',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: Text('Pick Date'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () => _selectTime(context),
                      child: const Text('Pick Time'),
                    ),
                  ],
                ),
                SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () => _addTodo(bloc),
                      child: Text('Add'),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _todoList.length,
              itemBuilder: (context, index) {
                final todo = _todoList[index];
                return ListTile(
                  title: Text(todo.title),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

enum TaskType {
  work,
  personal,
  shopping,
  sport,
  urgent,
}

extension TaskTypeExtension on TaskType {
  String get name {
    switch (this) {
      case TaskType.work:
        return 'Work';
      case TaskType.personal:
        return 'Personal';
      case TaskType.shopping:
        return 'Shopping';
      case TaskType.sport:
        return 'Sport';
      case TaskType.urgent:
        return 'Urgent';
    }
  }

  Color get color {
    switch (this) {
      case TaskType.work:
        return Colors.blue;
      case TaskType.personal:
        return Colors.green;
      case TaskType.shopping:
        return Colors.red;
      case TaskType.sport:
        return Colors.red;
      case TaskType.urgent:
        return Colors.red;
    }
  }
}

class Task {
  Task({
    required this.title,
    this.taskType,
    DateTime? createdAt,
    this.deadline,
  }) : createdAt = createdAt ?? DateTime.now();

  final String title;
  final TaskType? taskType;
  final DateTime? deadline;
  final DateTime createdAt;

  @override
  String toString() {
    return 'Task(title: $title)';
  }
}
