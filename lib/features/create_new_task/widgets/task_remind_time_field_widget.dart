import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

class TaskRemindDateTimeFieldWidget extends StatelessWidget {
  const TaskRemindDateTimeFieldWidget({
    super.key,
    required this.selectedRemindDateTime,
    required this.onSelectedRemindDate,
    required this.onSelectedRemindTime,
  });

  final List<DateTime>? selectedRemindDateTime;
  final VoidCallback onSelectedRemindDate;
  final VoidCallback onSelectedRemindTime;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Remind',
          style: AppTextStyle.appBar.copyWith(
            fontSize: 22,
            fontWeight: FontWeight.w800,
            color: Colors.black,
          ),
        ),
        SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          height: 40,
          child: ElevatedButton.icon(
            onPressed: onSelectedRemindDate,
            icon: const Icon(Icons.calendar_today),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 8),
                Text(
                  selectedRemindDateTime == null ||
                          selectedRemindDateTime!.isEmpty
                      ? 'Pick Remind Date'
                      : DateFormat('dd MMMM, EEEE')
                          .format(selectedRemindDateTime!.last),
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
            onPressed: onSelectedRemindTime,
            icon: const Icon(Icons.access_time),
            label: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(width: 8),
                Text(
                  selectedRemindDateTime == null ||
                          selectedRemindDateTime!.isEmpty
                      ? 'Pick Remind Time'
                      : DateFormat('HH:mm')
                          .format(selectedRemindDateTime!.last),
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
    );
  }
}
