import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
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

  void _clearInputFields() {
    _controllerTaskTitle.clear();
    _controllerTaskDescription.clear();
    setState(() {
      _selectedDeadline = null;
      _selectedTaskType = null;
    });
  }

  // passing a variable to a function
  void _addTodo(TasksBloc bloc) {
    final taskTitle = _controllerTaskTitle.text.trim();
    final taskType = _selectedTaskType;
    final taskDeadline = _selectedDeadline;
    final taskDescription = _controllerTaskDescription.text.trim();

    final tabsRouter = context.tabsRouter;

    if (taskTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }
    if (taskType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task type')),
      );
      return;
    }
    if (taskDeadline == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task deadline')),
      );
      return;
    }
    if (taskDescription.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task description')),
      );
      return;
    }

    bloc.add(AddTaskEvent(
      taskTitle,
      taskDescription,
      taskDeadline,
      taskType,
    ));

    _clearInputFields();

    tabsRouter.setActiveIndex(0);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDeadline ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDeadline) {
      setState(() {
        _selectedDeadline = picked.copyWith(
            hour: _selectedDeadline?.hour, minute: _selectedDeadline?.minute);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedDeadline != null
          ? TimeOfDay.fromDateTime(_selectedDeadline!)
          : TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDeadline = DateTime(
          _selectedDeadline!.year,
          _selectedDeadline!.month,
          _selectedDeadline!.day,
          picked.hour,
          picked.minute,
        );
      });
    } else if (picked != null && _selectedDeadline != null) {
      final DateTime now = DateTime.now();
      setState(() {
        _selectedDeadline = DateTime(
          now.year,
          now.month,
          now.day,
          picked.hour,
          picked.minute,
        );
      });
    } else {
      print('super');
    }
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<TasksBloc>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
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
                        AutoTabsRouter.of(context).setActiveIndex(0);
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
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Task Name',
                    style: AppTextStyle.appBar.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  TextField(
                    controller: _controllerTaskTitle,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withAlpha(80),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Category',
                    style: AppTextStyle.appBar.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: TaskType.values.take(5).map((TaskType type) {
                      return Expanded(
                        child: Row(
                          children: [
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: _selectedTaskType == type
                                    ? Colors.blue
                                    : Colors.blue[100],
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10),
                              ).copyWith(
                                shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                setState(() {
                                  _selectedTaskType = type;
                                });
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    type.name,
                                    style: TextStyle(
                                      color: _selectedTaskType == type
                                          ? Colors.white
                                          : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(width: 4),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 32),
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
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => _selectDate(context),
                          icon: const Icon(Icons.calendar_today),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 8),
                              Text(
                                _selectedDeadline == null
                                    ? 'Pick Date'
                                    : DateFormat('dd MMMM, EEEE')
                                        .format(_selectedDeadline!),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.black.withAlpha(60),
                            ),
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
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => _selectTime(context),
                          icon: const Icon(Icons.access_time),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 8),
                              Text(
                                _selectedDeadline == null
                                    ? 'Pick Time'
                                    : DateFormat('HH:mm')
                                        .format(_selectedDeadline!),
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            foregroundColor: WidgetStatePropertyAll(
                              Colors.black.withAlpha(60),
                            ),
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
                  SizedBox(height: 20),
                ],
              ),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 24,
                        horizontal: 8,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey.withAlpha(80),
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.red,
                          width: 2,
                        ),
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
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      child: Text('Create Task'),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// enum TaskType {
//   work,
//   personal,
//   shopping,
//   sport,
//   urgent,
// }
//
// extension TaskTypeExtension on TaskType {
//   String get name {
//     switch (this) {
//       case TaskType.work:
//         return 'work';
//       case TaskType.personal:
//         return 'personal';
//       case TaskType.shopping:
//         return 'shopping';
//       case TaskType.sport:
//         return 'sport';
//       case TaskType.urgent:
//         return 'urgent';
//     }
//   }
//
//   Color get color {
//     switch (this) {
//       case TaskType.work:
//         return Colors.blue;
//       case TaskType.personal:
//         return Colors.green;
//       case TaskType.shopping:
//         return Colors.orange;
//       case TaskType.sport:
//         return Colors.yellow;
//       case TaskType.urgent:
//         return Colors.red;
//     }
//   }
//
//   String get iconPath {
//     switch (this) {
//       case TaskType.work:
//         return AppSvgImages.iconTaskTypeWork;
//       case TaskType.personal:
//         return AppSvgImages.iconTaskTypePersonal;
//       case TaskType.shopping:
//         return AppSvgImages.iconTaskTypeShopping;
//       case TaskType.sport:
//         return AppSvgImages.iconTaskTypeSport;
//       case TaskType.urgent:
//         return AppSvgImages.iconTaskTypeUrgent;
//     }
//   }
//
//   static TaskType fromString(String type) {
//     return TaskType.values.firstWhere((e) => e.name == type);
//   }
// }
//
// class Task {
//   Task({
//     required this.taskTitle,
//     this.taskDescription,
//     this.taskType,
//     DateTime? createdAt,
//     this.taskDeadline,
//   }) : taskCreatedAt = createdAt ?? DateTime.now();
//
//   final String taskTitle;
//   final String? taskDescription;
//   final TaskType? taskType;
//   final DateTime? taskDeadline;
//   final DateTime taskCreatedAt;
//
//   // late final DateTime taskCreatedAt = DateTime.now();
//
//   double get progress {
//     if (taskDeadline == null) return 100;
//     double progress = TaskCurrentTimeProgressIndicator.calculateProgress(
//         taskCreatedAt, taskDeadline!);
//     return progress;
//   }
//
//   Map<String, dynamic> toMap() {
//     return {
//       'taskTitle': taskTitle,
//       'taskDescription': taskDescription,
//       'taskType': taskType?.name,
//       'taskDeadline': taskDeadline?.toIso8601String(),
//       'taskCreatedAt': taskCreatedAt.toIso8601String(),
//     };
//   }
//
//   factory Task.fromMap(Map<String, dynamic> map) {
//     return Task(
//       taskTitle: map['taskTitle'],
//       taskDescription: map['taskDescription'],
//       // taskType: TaskType.work,
//       taskType: map['taskType'] != null
//           ? TaskTypeExtension.fromString(map['taskType'])
//           : null,
//       taskDeadline: map['taskDeadline'] != null
//           ? DateTime.parse(map['taskDeadline'])
//           : null,
//       createdAt: map['taskCreatedAt'] != null
//           ? DateTime.parse(map['taskCreatedAt'])
//           : null,
//     );
//   }
//
//   @override
//   String toString() {
//     return 'Task(title: $taskTitle)';
//   }
// }
//
// class TaskCurrentTimeProgressIndicator {
//   static double calculateProgress(
//       DateTime taskCreatedAt, DateTime taskDeadline) {
//     final DateTime now = DateTime.now();
//
//     if (now.isBefore(taskCreatedAt)) return 0.0;
//     if (now.isAfter(taskDeadline)) return 100.0;
//
//     final Duration totalDuration = taskDeadline.difference(taskCreatedAt);
//     final Duration elapsedDuration = now.difference(taskCreatedAt);
//
//     double progress =
//         (elapsedDuration.inMilliseconds / totalDuration.inMilliseconds) * 100;
//
//     return double.parse(progress.toStringAsFixed(2));
//   }
// }
