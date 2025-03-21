import 'package:flutter/material.dart';

import 'package:todo_app/features/create_new_task/widgets/priority_dialog_widget.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

class TaskPriorityFieldWidget extends StatefulWidget {
  const TaskPriorityFieldWidget({
    super.key,
    required this.taskPriority,
    required this.onPrioritySelected,
  });

  final int? taskPriority;
  final ValueChanged<int?> onPrioritySelected;

  @override
  State<TaskPriorityFieldWidget> createState() =>
      _TaskPriorityFieldWidgetState();
}

class _TaskPriorityFieldWidgetState extends State<TaskPriorityFieldWidget> {
  int? _selectedPriority;

  @override
  void initState() {
    super.initState();
    _selectedPriority = widget.taskPriority;
  }

  void _openPriorityDialog() async {
    final selectedPriority = await showDialog<int?>(
      context: context,
      builder: (BuildContext context) {
        return PriorityDialogWidget(
          taskPriority: _selectedPriority,
        );
      },
    );

    if (selectedPriority != null) {
      setState(() {
        _selectedPriority = selectedPriority;
      });

      widget.onPrioritySelected(selectedPriority);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
          style: AppTextStyle.appBar.copyWith(
              fontSize: 22, fontWeight: FontWeight.w800, color: Colors.black),
        ),
        SizedBox(height: 12),
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
                  widget.taskPriority == null
                      ? 'Pick a priority'
                      : widget.taskPriority.toString(),
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
              overlayColor: WidgetStateProperty.all<Color>(Colors.white),
              shadowColor: WidgetStateProperty.all<Color>(Colors.white),
              elevation: WidgetStateProperty.all<double>(0.1),
            ),
          ),
        ),
      ],
    );
  }
}
