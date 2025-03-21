import 'package:flutter/material.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

class TaskTypeFieldWidget extends StatefulWidget {
  const TaskTypeFieldWidget({
    super.key,
    this.selectedTaskType,
    required this.onTaskTypeSelected,
  });

  final TaskType? selectedTaskType;
  final ValueChanged<TaskType> onTaskTypeSelected;

  @override
  State<TaskTypeFieldWidget> createState() => _TaskTypeFieldWidgetState();
}

class _TaskTypeFieldWidgetState extends State<TaskTypeFieldWidget> {
  TaskType? _selectedTaskType;

  @override
  void initState() {
    super.initState();
    _selectedTaskType = widget.selectedTaskType;
  }

  void _onTaskTypeSelected(TaskType type) {
    setState(() {
      _selectedTaskType = type;
    });
    widget.onTaskTypeSelected(type);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: AppTextStyle.appBar.copyWith(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: TaskType.values.take(5).map((TaskType type) {
            return Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: widget.selectedTaskType == type
                            ? Colors.blue
                            : Colors.blue[100],
                        padding: const EdgeInsets.symmetric(vertical: 10),
                      ).copyWith(
                        shape: WidgetStatePropertyAll(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                      onPressed: () {
                        _onTaskTypeSelected(type);
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
                              fontSize: 8,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
