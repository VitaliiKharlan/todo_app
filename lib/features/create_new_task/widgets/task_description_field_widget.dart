import 'package:flutter/material.dart';

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
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'Description',
          style: theme.textTheme.titleLarge,
        ),
        SizedBox(height: 12),
        TextField(
          controller: widget.controllerTaskDescription,
          style: theme.textTheme.headlineLarge,
          maxLines: null,
          keyboardType: TextInputType.multiline,
          textAlignVertical: TextAlignVertical.top,
          decoration: InputDecoration(
            hintText: widget.controllerTaskDescription.text.isEmpty
                ? 'Enter a Description'
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
