import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:async';
import 'package:intl/intl.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
import 'package:todo_app/features/location_search/bloc/location_search_bloc.dart';
import 'package:todo_app/router/router.dart';
import 'package:todo_app/ui/widgets/base_container.dart';

class TaskListCard extends StatefulWidget {
  const TaskListCard({
    super.key,
    required this.task,
    // required this.localizedName,
  });

  final Task task;

  // final String localizedName;

  @override
  State<TaskListCard> createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
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

    return GestureDetector(
      onTap: () {
        final locationDetails = widget.task.taskLocation;
        debugPrint(
            'Clicking on the task ${widget.task.taskTitle} '
                'to get detailed information about the task');

        if (locationDetails != null) {
          context.read<LocationSearchBloc>().add(
                LocationSelectEvent(locationDetails),
              );
        } else {
          debugPrint(
              'LocationSelectEvent not sent because taskLocation = null');
        }
        context.router.push(
          TaskDetailsRoute(
            task: widget.task,
            // localizedName: widget.localizedName,
            onDelete: (task) {
              context.read<TasksBloc>().add(DeleteTaskEvent(task));
              context.router.maybePop();
            },
            // context
            //     .read<TasksBloc>()
            //     .add(DeleteTaskEvent(deleteTask));
          ),
        );
      },
      child: BaseContainer(
        height: 148,
        width: double.infinity,
        color: isDeadlinePassed ? Colors.red.withAlpha(50) : theme.cardColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 32,
                  height: 32,
                  child: widget.task.taskType?.name != null
                      ? SvgPicture.asset(
                          'assets/svg/${widget.task.taskType!.name}.svg',
                          width: 24,
                          height: 24,
                          colorFilter: ColorFilter.mode(
                            widget.task.taskType!.color,
                            BlendMode.srcIn,
                          ),
                        )
                      : SizedBox.shrink(),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    widget.task.taskTitle,
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
                          DateFormat('d MMM').format(widget.task.taskCreatedAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Colors.purple,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          DateFormat('HH:mm').format(widget.task.taskCreatedAt),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.purple,
                          ),
                        ),
                        if (widget.task.taskDeadline != null) ...[
                          SizedBox(height: 12),
                          Text(
                            'Deadline: ',
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            DateFormat('d MMM')
                                .format(widget.task.taskDeadline!),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            DateFormat('HH:mm')
                                .format(widget.task.taskDeadline!),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: Colors.red,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ],
            ),
            if (widget.task.taskLocation != null)
              Text(
                widget.task.taskLocation.toString(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: Colors.purple,
                ),
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
