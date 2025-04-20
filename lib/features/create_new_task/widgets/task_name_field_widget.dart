import 'package:flutter/material.dart';

class TaskNameFieldWidget extends StatefulWidget {
  const TaskNameFieldWidget({
    super.key,
    required this.controllerTaskTitle,
  });

  final TextEditingController controllerTaskTitle;

  @override
  State<TaskNameFieldWidget> createState() => _TaskNameFieldWidgetState();
}

class _TaskNameFieldWidgetState extends State<TaskNameFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Task Name',
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 12),
        TextField(
          controller: widget.controllerTaskTitle,
          style: theme.textTheme.headlineLarge,
          decoration: InputDecoration(
            hintText: widget.controllerTaskTitle.text.isEmpty
                ? 'Enter a Task Name'
                : '',
            hintStyle: theme.textTheme.headlineMedium,
            contentPadding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 12,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0x40A9A9A9),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Color(0xFFF44336),
                width: 2,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ],
    );
  }
}
