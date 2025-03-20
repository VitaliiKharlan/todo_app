import 'package:flutter/material.dart';

import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/ui/theme/app_colors.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

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
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
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
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
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
                      DateFormat("dd MMMM, 'at' hh:mm a")
                          .format(milestone),
                      style: AppTextStyle.dateProgressIndicator.copyWith(
                        fontSize: 12,
                        color: AppColors.dateProgressIndicator,
                      ),
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
