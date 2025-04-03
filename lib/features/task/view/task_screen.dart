import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
import 'package:todo_app/features/task/task.dart';
import 'package:todo_app/ui/ui.dart';
export 'package:todo_app/main_prod.dart' show useMockData;

@RoutePage()
class TaskScreen extends StatefulWidget {
  const TaskScreen({
    super.key,
    required this.theme,
  });

  final ThemeData theme;

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final ScrollController scrollController = ScrollController();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'TODO',
            style: theme.appBarTheme.titleTextStyle,
          ),
        ),
        leading: MenuButtonWidget(),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: CircleAvatar(
              backgroundImage: AssetImage(AppImages.profileImage),
              radius: 20,
            ),
          ),
        ],
        flexibleSpace: ClipRect(
          child: Stack(
            children: [
              Positioned.fill(
                child: Image.asset(
                  AppImages.backgroundImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: kToolbarHeight,
                ),
              ),
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 5.0,
                    sigmaY: 5.0,
                  ),
                  child: Container(
                    color: Colors.black.withAlpha(30),
                  ),
                ),
              ),
            ],
          ),
        ),
        toolbarHeight: kToolbarHeight,
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            AppImages.backgroundImage,
            fit: BoxFit.cover,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
            child: Container(
              color: Color(0x1A0000FF),
            ),
          ),
          Column(
            children: [
              SizedBox(height: 24),
              _SearchTextField(
                controller: searchController,
                onChanged: (query) {
                  context.read<TasksBloc>().add(SearchTaskEvent(query));
                },
              ),
              SizedBox(height: 24),
              Expanded(
                child: ScrollbarTheme(
                  data: ScrollbarThemeData(
                    thumbColor: WidgetStateProperty.all(Colors.blue[100]),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 2),
                    child: Scrollbar(
                      controller: scrollController,
                      thumbVisibility: true,
                      trackVisibility: true,
                      thickness: 8,
                      child: CustomScrollView(
                        controller: scrollController,
                        physics: const BouncingScrollPhysics(),
                        slivers: [
                          BlocBuilder<TasksBloc, TasksState>(
                            builder: (context, state) {
                              if (state is TasksLoadedState) {
                                final tasks = state.tasks;
                                tasks.sort((a, b) =>
                                    b.taskCreatedAt.compareTo(a.taskCreatedAt));

                                if (tasks.isEmpty) {
                                  return SliverToBoxAdapter(
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Center(
                                        child: Column(
                                          children: [
                                            Text(
                                              'No tasks available',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                fontSize: 18,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Text(
                                              'try looking for something else',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                fontSize: 18,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                }

                                return CardBuilderWidget(
                                    tasks: tasks, theme: theme);
                              }
                              if (state is TasksDeletingFailureState) {
                                return SliverFillRemaining(
                                  child: Center(
                                    child: Text(
                                      state.exception?.toString() ??
                                          'something went wrong',
                                      style: theme.textTheme.bodyMedium,
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
                                      style: theme.textTheme.bodyMedium,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const _SearchTextField({
    required this.controller,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        decoration: InputDecoration(
          labelText: 'Search tasks...',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
        ),
      ),
    );
  }
}
