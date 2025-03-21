import 'package:flutter/material.dart';

import 'package:todo_app/ui/theme/app_text_style.dart';

class TaskDescriptionFieldWidget extends StatefulWidget {
  const TaskDescriptionFieldWidget({
    super.key,
    required this.controllerTaskDescription,
  });

  final TextEditingController controllerTaskDescription;

  @override
  State<TaskDescriptionFieldWidget> createState() =>
      _TaskDescriptionFieldWidgetState();
}

class _TaskDescriptionFieldWidgetState
    extends State<TaskDescriptionFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: AppTextStyle.appBar.copyWith(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        SizedBox(height: 12),
        TextField(
          controller: widget.controllerTaskDescription,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: widget.controllerTaskDescription.text.isEmpty
                ? 'Enter a Description'
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
