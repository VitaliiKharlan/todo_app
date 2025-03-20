import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/task_details/widgets/in_progress_indicator_widget.dart';
import 'package:todo_app/ui/theme/app_colors.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

class MainInformation extends StatefulWidget {
  const MainInformation({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<MainInformation> createState() => _MainInformationState();
}

class _MainInformationState extends State<MainInformation> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
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
              'Main Information',
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 20,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 12),
            Text(
              widget.task.taskTitle,
              style: AppTextStyle.appBar.copyWith(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: Colors.black),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                if (widget.task.taskType != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      color: Colors.lightBlueAccent.withAlpha(40),
                      height: 40,
                      width: 40,
                      child: Transform.scale(
                        scale: 0.5,
                        child: SvgPicture.asset(
                          'assets/svg/${widget.task.taskType!.name}.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            widget.task.taskType!.color,
                            BlendMode.srcIn,
                          ),
                          
                        ),
                      ),
                    ),
                  ),
                SizedBox(width: 8),
                ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.lightBlueAccent.withAlpha(40),
                    child: Center(
                      child: Text(
                        widget.task.taskPriority.toString(),
                        style: theme.textTheme.bodySmall?.copyWith(
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                if (widget.task.taskDeadline != null) ...[
                  SizedBox(height: 12),
                  Text(
                    DateFormat("dd MMMM, 'at' hh:mm a")
                        .format(widget.task.taskDeadline!),
                    style: AppTextStyle.dateProgressIndicator
                        .copyWith(color: AppColors.dateProgressIndicator),
                  ),
                ]
              ],
            ),
            SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'In Progress',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
                Text(
                  '${widget.task.progress}%',
                  style: theme.textTheme.bodySmall?.copyWith(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            InProgressIndicator(
              progress: widget.task.progress,
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
