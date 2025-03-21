import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:todo_app/ui/theme/app_text_style.dart';

class TaskDeadlineFieldWidget extends StatelessWidget {
  const TaskDeadlineFieldWidget({
    super.key,
    required this.selectedDeadline,
    required this.onSelectDeadlineDate,
    required this.onSelectDeadlineTime,
  });

  final DateTime? selectedDeadline;
  final VoidCallback onSelectDeadlineDate;
  final VoidCallback onSelectDeadlineTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deadline',
          style: AppTextStyle.appBar.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
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
                onPressed: onSelectDeadlineDate,
                icon: const Icon(Icons.calendar_today),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(width: 8),
                    Text(
                      selectedDeadline == null
                          ? 'Pick Deadline Date'
                          : DateFormat('dd MMMM, EEEE')
                              .format(selectedDeadline!),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
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
              width: double.infinity,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: onSelectDeadlineTime,
                icon: const Icon(Icons.access_time),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      selectedDeadline == null
                          ? 'Pick Deadline Time'
                          : DateFormat('HH:mm').format(selectedDeadline!),
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
                style: ButtonStyle(
                  backgroundColor: WidgetStatePropertyAll(Colors.white),
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
      ],
    );
  }
}
