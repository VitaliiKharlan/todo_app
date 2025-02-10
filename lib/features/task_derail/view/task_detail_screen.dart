import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/features/add_new_task/view/add_new_task_screen.dart';
import 'package:todo_app/ui/theme/app_theme.dart';

@RoutePage()
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Center(
          child: Text(
            'Task Details',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 20,
          top: 20,
          right: 20,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(task.taskTitle,
                style: themeData.textTheme.bodyLarge
                    ?.copyWith(fontSize: 32, fontWeight: FontWeight.w800)),
            SizedBox(height: 20),
            Row(
              children: [
                SvgPicture.asset(
                  'assets/svg/${task.taskType!.name}.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    task.taskType!.color,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(width: 24),
                if (task.taskDeadline != null) ...[
                  SizedBox(height: 12),
                  Text(
                    DateFormat("dd MMMM, 'at' hh:mm a")
                        .format(task.taskDeadline!),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.red,
                    ),
                  ),
                ]
              ],
            ),
            SizedBox(height: 32),
            Text(
              'In Progress',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 40),
            SizedBox(height: 20),
            Text(
              'Overview',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Description  description description description description '
              'description description description description description '
              'description description description description description '
              'description description description description description '
              'description description description description description '
              'description description description description description '
              'description description description description description '
              'description description description description description ',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Members',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 56),
            Text(
              'Tasks',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
