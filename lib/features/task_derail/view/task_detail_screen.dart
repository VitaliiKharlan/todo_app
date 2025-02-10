import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';


@RoutePage()
class TaskDetailScreen extends StatelessWidget {
  const TaskDetailScreen({
    super.key,
    required this.taskTitle,
  });

  final String taskTitle;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Task Details'),
        ),
      ),
      body: Center(
        child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Details for Task: '),
            SizedBox(height: 20),
            // Text(taskId),
            Text(taskTitle),
          ],
        ),
      ),
    );
  }
}
