import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/features/add_new_task/view/add_new_task_screen.dart';

import 'base_container.dart';

class TaskListCard extends StatelessWidget {
  const TaskListCard({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BaseContainer(
      height: 48,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 20).copyWith(bottom: 24),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.home,
            color: Colors.deepPurple,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              task.title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.purple,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(
            // width: 48,
            width: 72,
            child: Center(
              child: Column(
                children: [
                  SizedBox(height: 4),
                  Text(
                    DateFormat('d MMM').format(task.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w800,
                      color: Colors.purple,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    DateFormat('HH:mm').format(task.createdAt),
                    style: theme.textTheme.bodySmall?.copyWith(
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                      color: Colors.purple,
                    ),
                  ),
                  if (task.deadline != null) ...[
                    SizedBox(height: 8),
                    Text(
                      'Deadline: ${DateFormat('d MMM').format(task.deadline!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Deadline: ${DateFormat('HH:mm').format(task.deadline!)}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.red,
                      ),
                    ),
                  ]
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
