import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
import 'package:todo_app/features/task/task.dart';
import 'package:todo_app/ui/ui.dart';

@RoutePage()
class TaskScreen extends StatelessWidget {
  const TaskScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          AppImages.backgroundImage,
          fit: BoxFit.cover,
        ),
        BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
          child: Container(
            color: Colors.black.withAlpha(30),
          ),
        ),
        CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverAppBar(
              pinned: true,
              snap: true,
              floating: true,
              backgroundColor: Colors.transparent,
              title: Center(
                child: Text(
                  'TODO',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              elevation: 0,
              surfaceTintColor: Colors.transparent,
            ),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
            BlocBuilder<TasksBloc, TasksState>(
              builder: (context, state) {
                if (state is TasksLoadedState) {
                  final tasks = state.tasks;
                  tasks.sort(
                      (a, b) => b.taskCreatedAt.compareTo(a.taskCreatedAt));
                  if (tasks.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text('No tasks available'),
                      ),
                    );
                  }

                  return SliverList.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final deleteTask = tasks[index];
                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: Container(
                              margin: EdgeInsets.only(bottom: 24),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const ScrollMotion(),
                            ),
                            extentRatio: 0.25,
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  context
                                      .read<TasksBloc>()
                                      .add(DeleteTaskEvent(deleteTask));
                                },
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: TaskListCard(
                            task: tasks[index],
                          ),
                        );
                      });
                }
                if (state is TasksDeletingFailureState) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        state.exception?.toString() ?? 'MAGA',
                        style: AppTextStyle.defaultListCardMain,
                      ),
                    ),
                  );
                }
                return SliverFillRemaining(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 400),
                    child: Center(
                      child: Text(
                        'Your task list is empty\n'
                        'Create a new task to get started',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.purple),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
