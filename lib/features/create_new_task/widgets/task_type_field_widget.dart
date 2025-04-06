import 'package:flutter/material.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';


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
  void didUpdateWidget(covariant TaskTypeFieldWidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.selectedTaskType != oldWidget.selectedTaskType) {
      _selectedTaskType = widget.selectedTaskType;
    }
  }

  void _onTaskTypeSelected(TaskType type) {
    setState(() {
      _selectedTaskType = type;
    });
    widget.onTaskTypeSelected(type);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: TaskType.values.take(5).map((TaskType type) {
            return Expanded(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: _selectedTaskType == type
                      ? Colors.blue
                      : Colors.blue[100],
                  padding: const EdgeInsets.symmetric(vertical: 10),
                ).copyWith(
                  shape: WidgetStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                onPressed: () {
                  _onTaskTypeSelected(type);
                },
                child: Text(
                  type.name,
                  style: TextStyle(
                    color:
                        _selectedTaskType == type ? Colors.white : Colors.black,
                    fontSize: 8,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
