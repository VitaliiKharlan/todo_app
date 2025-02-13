import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';

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
          'assets/images/background_image.jpg',
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
                if (state is LoadedTasksState) {
                  final tasks = state.tasks;
                  tasks.sort((a, b) => b.taskCreatedAt.compareTo(a.taskCreatedAt));
                  if (tasks.isEmpty) {
                    return SliverToBoxAdapter(
                      child: Center(
                        child: Text('No tasks available'),
                      ),
                    );
                  }
                  print(state.tasks);
                  return SliverList.builder(
                      itemCount: state.tasks.length,
                      itemBuilder: (context, index) {
                        final deleteTask = tasks[index];
                        return Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const ScrollMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) {
                                  context
                                      .read<TasksBloc>()
                                      .add(DeleteTasksEvent(deleteTask));
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
                if (state is DeletingFailureTasksState) {
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
                        'Your task list is empty\nCreate a new task to get started',
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
