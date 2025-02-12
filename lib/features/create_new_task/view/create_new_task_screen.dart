import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';

import 'package:todo_app/ui/theme/app_svg_images.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

@RoutePage()
class CreateNewTaskScreen extends StatefulWidget {
  const CreateNewTaskScreen({super.key});

  @override
  _CreateNewTaskScreenState createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  final TextEditingController _controllerTaskTitle = TextEditingController();
  final TextEditingController _controllerTaskDescription =
      TextEditingController();
  DateTime? _selectedDeadline;
  TaskType? _selectedTaskType;
  // final RadioGroupController myController = RadioGroupController();

  // passing a variable to a function
  void _addTodo(TasksBloc bloc) {
    // final theme = Theme.of(context);
    final taskTitle = _controllerTaskTitle.text.trim();
    final taskDescription = _controllerTaskDescription.text.trim();
    final taskDeadline = _selectedDeadline;
    final taskType = _selectedTaskType;
    final tabsRouter = context.tabsRouter;
    if (taskTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }
    // bloc.add(AddNewTaskLoadedEvent(taskTitle,  taskDeadline, taskType));
    bloc.add(LoadTasksEvent(
      taskTitle,
      taskDescription,
      taskDeadline,
      taskType,
    ));

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
    final bloc = BlocProvider.of<TasksBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 12),
            SizedBox(
              width: 40,
              height: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  color: Colors.grey.withAlpha(20),
                  child: Center(
                    child: IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(right: 32),
                  child: Text(
                    'Create New Task',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 12,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 8),
            Text(
              'Task Name',
              style: AppTextStyle.appBar.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _controllerTaskTitle,
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.withAlpha(80), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 12),
            Text(
              'Category',
              style: AppTextStyle.appBar.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 12),
            Text(
              'Date & Time',
              style: AppTextStyle.appBar.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    onPressed: () => _selectDate(context),
                    icon: const Icon(Icons.calendar_today),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // Выровнять по левому краю
                      children: const [
                        // Icon(Icons.access_time),
                        SizedBox(width: 8), // Отступ между иконкой и текстом
                        Text('Pick Time'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor:
                          WidgetStatePropertyAll(Colors.black.withAlpha(60)),
                      side: WidgetStatePropertyAll(
                        BorderSide(
                          color: Colors.grey.withAlpha(80),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: 200,
                  child: ElevatedButton.icon(
                    onPressed: () => _selectTime(context),
                    icon: const Icon(Icons.access_time),
                    label: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      // Выровнять по левому краю
                      children: const [
                        // Icon(Icons.access_time),
                        SizedBox(width: 8), // Отступ между иконкой и текстом
                        Text('Pick Time'),
                      ],
                    ),
                    style: ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll(Colors.white),
                      foregroundColor:
                          WidgetStatePropertyAll(Colors.black.withAlpha(60)),
                      side: WidgetStatePropertyAll(
                        BorderSide(
                          color: Colors.grey.withAlpha(80),
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (_selectedDeadline != null) ...[
              const SizedBox(height: 10),
              Text('Selected Deadline: ${_selectedDeadline!.toLocal()}')
            ],
            SizedBox(height: 20),
            Text(
              'Description',
              style: AppTextStyle.appBar.copyWith(
                  fontSize: 22,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            SizedBox(height: 12),
            TextField(
              controller: _controllerTaskDescription,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 28),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Colors.grey.withAlpha(80), width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => _addTodo(bloc),
                style: ElevatedButton.styleFrom(
                  textStyle: TextStyle(fontSize: 18),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue,
                ).copyWith(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(12),
                    ),
                  ),
                ),
                child: Text('Create Task'),
              ),
            ),
          ],
        ),
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
        return SvgPicture.asset(AppSvgImages.iconTaskTypeWork);
      case TaskType.personal:
        return SvgPicture.asset(AppSvgImages.iconTaskTypePersonal);
      case TaskType.shopping:
        return SvgPicture.asset(AppSvgImages.iconTaskTypeShopping);
      case TaskType.sport:
        return SvgPicture.asset(AppSvgImages.iconTaskTypeSport);
      case TaskType.urgent:
        return SvgPicture.asset(AppSvgImages.iconTaskTypeUrgent);
    }
  }
}

class Task {
  Task({
    required this.taskTitle,
    this.taskDescription,
    this.taskType,
    DateTime? createdAt,
    this.taskDeadline,
  }) : taskCreatedAt = createdAt ?? DateTime.now();

  final String taskTitle;
  final String? taskDescription;
  final TaskType? taskType;
  final DateTime? taskDeadline;
  final DateTime taskCreatedAt;

  @override
  String toString() {
    return 'Task(title: $taskTitle)';
  }
}
