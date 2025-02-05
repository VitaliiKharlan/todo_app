import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/add_new_task/bloc/add_new_task_bloc.dart';
import 'package:todo_app/features/task/widgets/widgets.dart';
import 'package:todo_app/ui/theme/app_text_style.dart';

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
    return CustomScrollView(
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
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(80),
            child: AddNewTaskButton(theme: theme),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 24)),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 100,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: 8,
              separatorBuilder: (context, index) => SizedBox(width: 20),
              padding: EdgeInsets.only(left: 20),
              itemBuilder: (context, index) => BaseContainer(
                width: 192,
                padding: EdgeInsets.all(16),
                margin: EdgeInsets.zero,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Monday',
                      style: theme.textTheme.bodyLarge?.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.green),
                    ),
                    SizedBox(height: 10),
                    Text('27/01/2025'),
                  ],
                ),
              ),
            ),
          ),
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
              // print(state.tasks);
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
                child: CircularProgressIndicator(),
              ),
            );
          },
        ),
      ],
    );
  }
}
