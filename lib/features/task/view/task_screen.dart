import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';
import 'package:todo_app/features/task/widgets/widgets.dart';

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
            BlocBuilder<AddNewTaskBloc, AddNewTaskState>(
              builder: (context, state) {
                if (state is AddNewTaskLoadingState) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is AddNewTaskLoadedState) {
                  final tasks = state.tasks;
                  if (tasks.isEmpty) {
                    return Center(child: Text('No tasks available'));
                  }
                  print(state.tasks);
                  return SliverList.builder(
                    itemCount: state.tasks.length,
                    itemBuilder: (context, index) => TaskListCard(
                      task: tasks[index],
                    ),
                  );
                }
                if (state is AddNewTaskLoadingFailureState) {
                  return SliverFillRemaining(
                    child: Center(
                      child: Text(
                        state.exception?.toString() ?? 'MAGA',
                        style: AppTextStyle.defaultSemiBoldLargeTitle,
                      ),
                    ),
                  );
                }
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Your task list is empty\nAdd a new task to get started',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.purple),
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
