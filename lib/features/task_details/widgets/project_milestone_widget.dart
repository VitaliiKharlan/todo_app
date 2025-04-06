import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';


class ProjectMilestoneWidget extends StatefulWidget {
  const ProjectMilestoneWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<ProjectMilestoneWidget> createState() => _ProjectMilestoneWidgetState();
}

class _ProjectMilestoneWidgetState extends State<ProjectMilestoneWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Color(0x1F000000),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Project Milestone',
              style: theme.textTheme.titleLarge,
            ),
            if (widget.task.taskRemindTime != null &&
                widget.task.taskRemindTime!.isNotEmpty) ...[
              SizedBox(height: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: widget.task.taskRemindTime!.map((milestone) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text(
                      DateFormat("dd MMMM, 'at' hh:mm a").format(milestone),
                      style: theme.textTheme.titleSmall,
                    ),
                  );
                }).toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
