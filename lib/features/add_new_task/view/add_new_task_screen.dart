import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';
import 'package:todo_app/features/task/task.dart';
import 'package:todo_app/router/router.dart';
import 'package:todo_app/ui/theme/app_theme.dart';

@RoutePage()
class AddNewTaskScreen extends StatefulWidget {
  const AddNewTaskScreen({super.key});

  @override
  _AddNewTaskScreenState createState() => _AddNewTaskScreenState();
}

class _AddNewTaskScreenState extends State<AddNewTaskScreen> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _selectedDeadline;
  TaskType? _selectedTaskType;

  // passing a variable to a function
  void _addTodo(AddNewTaskBloc bloc) {
    final theme = Theme.of(context);
    final taskTitle = _controller.text.trim();
    final taskDeadline = _selectedDeadline;
    final taskType = _selectedTaskType;
    final tabsRouter = context.tabsRouter;
    if (taskTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }
    bloc.add(AddNewTaskLoadedEvent(taskTitle, taskDeadline, taskType));

    tabsRouter.setActiveIndex(0);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDeadline) {
      _selectedDeadline = picked;
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );
    if (picked != null) {
      final DateTime now = DateTime.now();
      _selectedDeadline = DateTime(
        now.year,
        now.month,
        now.day,
        picked.hour,
        picked.minute,
      );
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
      backgroundColor: Colors.blue,
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
                    ElevatedButton.icon(
                      onPressed: () => _selectDate(context),
                      icon: const Icon(Icons.calendar_today),
                      label: const Text('Pick Date'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton.icon(
                      onPressed: () => _selectTime(context),
                      icon: const Icon(Icons.access_time),
                      label: const Text('Pick Time'),
                    ),
                  ],
                ),
                if (_selectedDeadline != null) ...[
                  const SizedBox(height: 10),
                  Text('Selected Deadline: ${_selectedDeadline!.toLocal()}')
                ],
                SizedBox(height: 40),
                DropdownButton<TaskType>(
                  value: _selectedTaskType,
                  hint: const Text("Select Task Type"),
                  onChanged: (TaskType? newValue) {
                    setState(() {
                      _selectedTaskType = newValue;
                    });
                  },
                  items: TaskType.values.map((TaskType type) {
                    return DropdownMenuItem<TaskType>(
                      value: type,
                      child: Row(
                        children: [
                          Container(
                            width: 12,
                            height: 12,
                            decoration: BoxDecoration(
                              color: type.color,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(type.name),
                        ],
                      ),
                    );
                  }).toList(),
                ),
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
        return 'work';
      case TaskType.personal:
        return 'personal';
      case TaskType.shopping:
        return 'shopping';
      case TaskType.sport:
        return 'sport';
      case TaskType.urgent:
        return 'urgent';
    }
  }

  Color get color {
    switch (this) {
      case TaskType.work:
        return Colors.blue;
      case TaskType.personal:
        return Colors.green;
      case TaskType.shopping:
        return Colors.orange;
      case TaskType.sport:
        return Colors.yellow;
      case TaskType.urgent:
        return Colors.red;
    }
  }

  Widget get icon {
    switch (this) {
      case TaskType.work:
        return SvgPicture.asset('assets/svg/work.svg');
      case TaskType.personal:
        return SvgPicture.asset('assets/svg/personal.svg');
      case TaskType.shopping:
        return SvgPicture.asset('assets/svg/shopping.svg');
      case TaskType.sport:
        return SvgPicture.asset('assets/svg/sport.svg');
      case TaskType.urgent:
        return SvgPicture.asset('assets/svg/urgent.svg');
    }
  }
}

class Task {
  Task({
    required this.taskTitle,
    this.taskType,
    DateTime? createdAt,
    this.taskDeadline,
  }) : taskCreatedAt = createdAt ?? DateTime.now();

  final String taskTitle;
  final TaskType? taskType;
  final DateTime? taskDeadline;
  final DateTime taskCreatedAt;

  @override
  String toString() {
    return 'Task(title: $taskTitle)';
  }
}
