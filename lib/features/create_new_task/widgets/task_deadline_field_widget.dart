import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

class TaskDeadlineFieldWidget extends StatelessWidget {
  const TaskDeadlineFieldWidget({
    super.key,
    required this.selectedDeadline,
    required this.onSelectedDeadlineDate,
    required this.onSelectedDeadlineTime,
  });

  final DateTime? selectedDeadline;
  final VoidCallback onSelectedDeadlineDate;
  final VoidCallback onSelectedDeadlineTime;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Deadline',
          style: theme.textTheme.titleLarge,
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
                onPressed: onSelectedDeadlineDate,
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
                      style: selectedDeadline == null
                          ? theme.textTheme.headlineMedium
                          : theme.textTheme.headlineLarge,
                    ),
                  ],
                ),
                // ✅ style defined in ThemeData
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton.icon(
                onPressed: onSelectedDeadlineTime,
                icon: const Icon(Icons.access_time),
                label: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(width: 8),
                    Text(
                      selectedDeadline == null
                          ? 'Pick Deadline Time'
                          : DateFormat('HH:mm').format(selectedDeadline!),
                      style: selectedDeadline == null
                          ? theme.textTheme.headlineMedium
                          : theme.textTheme.headlineLarge,
                    ),
                  ],
                ),
                // ✅ style defined in ThemeData
              ),
            ),
          ],
        ),
      ],
    );
  }
}
