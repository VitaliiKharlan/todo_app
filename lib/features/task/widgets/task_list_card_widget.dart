import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
import 'package:todo_app/router/router.dart';
import 'package:todo_app/ui/widgets/base_container.dart';

class TaskListCardWidget extends StatefulWidget {
  const TaskListCardWidget({
    super.key,
    required this.task,
  });

  final Task task;

  @override
  State<TaskListCardWidget> createState() => _TaskListCardWidgetState();
}

class _TaskListCardWidgetState extends State<TaskListCardWidget> {
  late Timer _timer;
  DateTime _currentTime = DateTime.now();

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 60), _onTick);
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _onTick(Timer timer) {
    setState(() {
      _currentTime = DateTime.now();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final now = _currentTime;
    final isDeadlinePassed = widget.task.taskDeadline != null &&
        now.isAfter(widget.task.taskDeadline!);

    final titleTextStyle = theme.textTheme.bodySmall;
    final taskPriorityTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 20,
      fontWeight: FontWeight.w700,
    );
    final createAtDateTimeTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );
    final deadlineDateTimeTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 12,
      fontWeight: FontWeight.w700,
    );
    final taskLocationTextStyle = theme.textTheme.bodySmall?.copyWith(
      fontSize: 14,
      fontWeight: FontWeight.w500,
    );;

    return GestureDetector(
      onTap: () {
        context.router.push(
          TaskDetailsRoute(
            task: widget.task,
            onDelete: (task) {
              context.read<TasksBloc>().add(DeleteTaskEvent(task));
              context.router.maybePop();
            },
          ),
        );
      },
      child: BaseContainer(
        height: 160,
        width: double.infinity,
        color: isDeadlinePassed
            ? Color(0x32F44336)
            : theme.colorScheme.onPrimary,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      widget.task.taskType?.name != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Color(0x2829B6F6),
                                height: 40,
                                width: 40,
                                child: Transform.scale(
                                  scale: 0.75,
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
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Container(
                                color: Color(0x2829B6F6),
                                height: 40,
                                width: 40,
                              ),
                            ),
                      SizedBox(height: 12),
                      ClipOval(
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Color(0xFF40C4FF),
                          child: Center(
                            child: Text(
                              widget.task.taskPriority != null
                                  ? widget.task.taskPriority.toString()
                                  : '',
                              style: taskPriorityTextStyle,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        widget.task.taskTitle,
                        style: titleTextStyle,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                    child: Center(
                      child: Column(
                        children: [
                          SizedBox(height: 4),
                          Text(
                            DateFormat('d MMM')
                                .format(widget.task.taskCreatedAt),
                            style: createAtDateTimeTextStyle,
                          ),
                          SizedBox(height: 2),
                          Text(
                            DateFormat('HH:mm')
                                .format(widget.task.taskCreatedAt),
                            style: createAtDateTimeTextStyle?.copyWith(
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (widget.task.taskDeadline != null) ...[
                            SizedBox(height: 12),
                            Text(
                              'Deadline:',
                              style: deadlineDateTimeTextStyle,
                            ),
                            SizedBox(height: 2),
                            Text(
                              DateFormat('d MMM')
                                  .format(widget.task.taskDeadline!),
                              style: deadlineDateTimeTextStyle,
                            ),
                            SizedBox(height: 2),
                            Text(
                              DateFormat('HH:mm')
                                  .format(widget.task.taskDeadline!),
                              style: deadlineDateTimeTextStyle?.copyWith(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 12),
            if (widget.task.taskLocation != null)
              Text(
                widget.task.taskLocation.toString(),
                style: taskLocationTextStyle,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
