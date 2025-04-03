import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
import 'package:todo_app/features/task/widgets/task_list_card_widget.dart';
import 'package:todo_app/router/router.dart';

class CardBuilderWidget extends StatelessWidget {
  const CardBuilderWidget({
    super.key,
    required this.tasks,
  });

  final List<Task> tasks;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SliverList.builder(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Slidable(
              key: ValueKey(index),
              endActionPane: ActionPane(
                motion: const ScrollMotion(),
                extentRatio: 0.4,
                children: [
                  SlidableAction(
                    onPressed: (_) {
                      context.pushRoute(
                        CreateNewTaskRoute(
                          editTask: task,
                        ),
                      );
                    },
                    backgroundColor: Colors.green,
                    foregroundColor: Colors.white,
                    icon: Icons.edit,
                    label: 'Edit',
                    spacing: 8,
                    padding: EdgeInsets.only(
                      left: 4,
                      top: 12,
                      right: 4,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  SlidableAction(
                    onPressed: (_) {
                      showDialog(
                        context: context,
                        builder: (BuildContext dialogContext) {
                          return AlertDialog(
                            title: Align(
                              alignment: Alignment.topCenter,
                              child: Text('Are you sure?'),
                            ),
                            content: Text(
                              'Do you really want '
                              '\nto delete this task?',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: Colors.black,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            actions: <Widget>[
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  dialogContext.router.maybePop();
                                },
                              ),
                              TextButton(
                                child: Text('Yes'),
                                onPressed: () {
                                  dialogContext.router.maybePop();
                                  context
                                      .read<TasksBloc>()
                                      .add(DeleteTaskEvent(task));
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                    icon: Icons.delete,
                    label: 'Delete',
                    spacing: 8,
                    padding: EdgeInsets.only(
                      left: 4,
                      top: 12,
                      right: 4,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                ],
              ),
              child: TaskListCardWidget(
                task: task,
              ),
            ),
          ),
        );
      },
    );
  }
}
