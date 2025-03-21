import 'package:flutter/material.dart';

import 'package:todo_app/ui/theme/app_text_style.dart';

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Task Name',
          style: AppTextStyle.appBar.copyWith(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        SizedBox(height: 12),
        TextField(
          controller: widget.controllerTaskTitle,
          decoration: InputDecoration(
            hintText: widget.controllerTaskTitle.text.isEmpty
                ? 'Enter a Task Name'
                : '',
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Colors.black.withAlpha(80),
            ),
            contentPadding: EdgeInsets.symmetric(
              vertical: 20,
              horizontal: 12,
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
      ],
    );
  }
}
