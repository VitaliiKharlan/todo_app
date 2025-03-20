import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
import 'package:todo_app/features/create_new_task/create_new_task.dart';

import 'package:todo_app/router/router.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

@RoutePage()
class CreateNewTaskScreen extends StatefulWidget {
  const CreateNewTaskScreen({
    super.key,
    this.editTask,
  });

  final Task? editTask;

  @override
  _CreateNewTaskScreenState createState() => _CreateNewTaskScreenState();
}

class _CreateNewTaskScreenState extends State<CreateNewTaskScreen> {
  late TextEditingController controllerTaskTitle;
  late TextEditingController _controllerTaskDescription;

  DateTime? _selectedDeadline;
  TaskType? _selectedTaskType;
  int? _taskPriority;
  LocationDetailsModel? _taskLocation;
  List<DateTime>? _selectedRemindTime;

  @override
  void initState() {
    super.initState();

    controllerTaskTitle =
        TextEditingController(text: widget.editTask?.taskTitle ?? '');
    _controllerTaskDescription =
        TextEditingController(text: widget.editTask?.taskDescription ?? '');

    _selectedDeadline = widget.editTask?.taskDeadline;
    _selectedRemindTime = widget.editTask?.taskRemindTime;
    _selectedTaskType = widget.editTask?.taskType;
    _taskPriority = widget.editTask?.taskPriority;
    _taskLocation = widget.editTask?.taskLocation;
  }

  _getLocationFromPreviousScreen() async {
    final result =
        await context.router.push<LocationDetailsModel>(LocationSearchRoute());
    if (result != null) {
      setState(() {
        _taskLocation = result;
      });
    }
  }

  void _clearInputFields() {
    controllerTaskTitle.clear();
    _controllerTaskDescription.clear();

    setState(() {
      _selectedDeadline = null;
      _selectedRemindTime = null;
      _selectedTaskType = null;
      _taskPriority = null;
      _taskLocation = null;
    });
  }

  // passing a variable to a function
  void _addTodo(TasksBloc bloc) {
    final taskTitle = controllerTaskTitle.text.trim();
    final taskType = _selectedTaskType;
    final taskPriority = _taskPriority;
    final taskDeadline = _selectedDeadline;
    final taskDescription = _controllerTaskDescription.text.trim();
    final taskLocation = _taskLocation;
    final taskRemindTime = _selectedRemindTime;

    final tabsRouter = context.tabsRouter;

    if (taskTitle.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a task title')),
      );
      return;
    }

    if (widget.editTask == null) {
      // Create New Task
      bloc.add(AddTaskEvent(
        taskTitle,
        taskType,
        taskPriority,
        taskDeadline,
        taskDescription,
        taskLocation,
        taskRemindTime,
      ));
    } else {
      // Edit Task
      bloc.add(EditTaskEvent(
        oldTask: widget.editTask!,
        taskTitle: controllerTaskTitle.text.trim(),
        taskType: _selectedTaskType,
        taskPriority: _taskPriority,
        taskDeadline: _selectedDeadline,
        taskDescription: _controllerTaskDescription.text.trim(),
        taskLocation: _taskLocation,
        taskRemindTime: _selectedRemindTime,
      ));
    }

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
      debugPrint('super');
    }
  }

  Future<void> _selectRemindDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedRemindTime?.isNotEmpty ?? false
          ? _selectedRemindTime!.first
          : DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      setState(() {
        _selectedRemindTime ??= [];
        _selectedRemindTime!.add(picked.copyWith(
          hour: _selectedRemindTime?.isNotEmpty == true
              ? _selectedRemindTime!.last.hour
              : DateTime.now().hour,
          minute: _selectedRemindTime?.isNotEmpty == true
              ? _selectedRemindTime!.last.minute
              : DateTime.now().minute,
        ));
      });
    }
  }

  Future<void> _selectRemindTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime:
          _selectedRemindTime != null && _selectedRemindTime!.isNotEmpty
              ? TimeOfDay.fromDateTime(_selectedRemindTime!.last)
              : TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedRemindTime ??= [];
        if (_selectedRemindTime!.isNotEmpty) {
          _selectedRemindTime!.last = DateTime(
            _selectedRemindTime!.last.year,
            _selectedRemindTime!.last.month,
            _selectedRemindTime!.last.day,
            picked.hour,
            picked.minute,
          );
        } else if (_selectedRemindTime != null) {
          final DateTime now = DateTime.now();
          setState(() {
            _selectedRemindTime!.add(DateTime(
              DateTime.now().year,
              DateTime.now().month,
              DateTime.now().day,
              picked.hour,
              picked.minute,
            ));
          });
        }
      });
    } else {
      debugPrint('super Remind Time');
    }
  }

  void _openPriorityDialog() async {
    final selectedPriority = await showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return PriorityDialogWidget(
          taskPriority: _taskPriority,
        );
      },
    );

    if (selectedPriority != null) {
      setState(() {
        _taskPriority = selectedPriority;
      });
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
                    // 'Create New Task',
                    widget.editTask == null ? 'Create New Task' : 'Edit Task',
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
                  TaskNameFieldWidget(
                    controllerTaskTitle: controllerTaskTitle,
                  ),
                  SizedBox(height: 32),
                  TaskTypeFieldWidget(
                    selectedTaskType: _selectedTaskType,
                    onTaskTypeSelected: (TaskType type) {
                      setState(() {
                        _selectedTaskType = type;
                      });
                    },
                  ),
                  SizedBox(height: 32),
                  Text(
                    'Priority',
                    style: AppTextStyle.appBar.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        _openPriorityDialog();
                      },
                      icon: const Icon(Icons.priority_high),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            _taskPriority == null
                                ? 'Pick a priority'
                                : _taskPriority.toString(),
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        foregroundColor: WidgetStateProperty.all(
                          Colors.black.withAlpha(60),
                        ),
                        side: WidgetStateProperty.all(
                          BorderSide(
                            color: Colors.grey.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        overlayColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        shadowColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        elevation: WidgetStateProperty.all<double>(0.1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
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
                  Text(
                    'Pick a place',
                    style: AppTextStyle.appBar.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton.icon(
                      onPressed: () => {
                        _getLocationFromPreviousScreen(),
                      },
                      icon: const Icon(Icons.location_city),
                      label: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Text(
                            _taskLocation == null
                                ? 'Pick a place'
                                : _taskLocation?.description ?? '',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(Colors.white),
                        foregroundColor: WidgetStateProperty.all(
                          Colors.black.withAlpha(60),
                        ),
                        side: WidgetStateProperty.all(
                          BorderSide(
                            color: Colors.grey.withAlpha(80),
                            width: 2,
                          ),
                        ),
                        overlayColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        shadowColor:
                            WidgetStateProperty.all<Color>(Colors.white),
                        elevation: WidgetStateProperty.all<double>(0.1),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    'Remind me',
                    style: AppTextStyle.appBar.copyWith(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Colors.black),
                  ),
                  SizedBox(height: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: double.infinity,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => _selectRemindDate(context),
                          icon: const Icon(Icons.calendar_today),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              const SizedBox(width: 8),
                              Text(
                                _selectedRemindTime == null ||
                                        _selectedRemindTime!.isEmpty
                                    ? 'Pick Remind Date'
                                    : DateFormat('dd MMMM, EEEE')
                                        .format(_selectedRemindTime!.last),
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
                        width: 240,
                        height: 40,
                        child: ElevatedButton.icon(
                          onPressed: () => _selectRemindTime(context),
                          icon: const Icon(Icons.access_time),
                          label: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              SizedBox(width: 8),
                              Text(
                                _selectedRemindTime == null ||
                                        _selectedRemindTime!.isEmpty
                                    ? 'Pick Remind Time'
                                    : DateFormat('HH:mm')
                                        .format(_selectedRemindTime!.last),
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
                      child: Text(widget.editTask == null
                          ? 'Create Task'
                          : 'Save Changes'),
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
