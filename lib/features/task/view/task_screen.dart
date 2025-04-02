import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/bloc/theme/theme_cubit.dart';
import 'dart:ui';

import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';
import 'package:todo_app/features/task/task.dart';
import 'package:todo_app/router/router.dart';
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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Center(
          child: Text(
            'TODO',
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
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
              color: Colors.black.withAlpha(30),
            ),
          ),
          ScrollbarTheme(
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
                    const SliverToBoxAdapter(
                      child: SizedBox(height: 24),
                    ),
                    SliverToBoxAdapter(
                      child: _SearchTextField(
                        controller: searchController,
                        onChanged: (query) {
                          context.read<TasksBloc>().add(SearchTaskEvent(query));
                        },
                      ),
                    ),
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
                                  child: Text('No tasks available'),
                                ),
                              ),
                            );
                          }

                          return SliverList.builder(
                              itemCount: tasks.length,
                              itemBuilder: (context, index) {
                                final task = tasks[index];
                                final deleteTask = tasks[index];
                                final editTask = tasks[index];
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
                                                  editTask: editTask,
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          SlidableAction(
                                            onPressed: (_) {
                                              context.read<TasksBloc>().add(
                                                    DeleteTaskEvent(deleteTask),
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
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                        ],
                                      ),
                                      child: TaskListCard(
                                        task: task,
                                      ),
                                    ),
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
                                style: TextStyle(
                                  color: Colors.purple,
                                ),
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
        ],
      ),
    );
  }
}

class MenuButtonWidget extends StatelessWidget {
  const MenuButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final brightnessValue = context.read<ThemeCubit>();
    final brightnessValueIsLight = brightnessValue.state.isLight;
    return IconButton(
      icon: Icon(Icons.menu),
      onPressed: () {
        showMenu(
          context: context,
          position: RelativeRect.fromLTRB(0, 20, 0, 0),
          items: [
            PopupMenuItem<String>(
              value: 'Change app color',
              child: Text('Change app color'),
              onTap: () {
                _setThemeBrightness(brightnessValue, brightnessValueIsLight);
              },
            ),
            PopupMenuItem<String>(
              value: 'Change app typography',
              child: Text('Change app typography'),
            ),
            PopupMenuItem<String>(
              value: 'Change app language',
              child: Text('Change app language'),
            ),
            PopupMenuItem<String>(
              value: 'Select sorting priorities',
              child: Text('Select sorting priorities'),
            ),
          ],
          elevation: 8.0,
        ).then((value) {
          if (value != null) {
            debugPrint('Selected: $value');
          }
        });
      },
    );
  }

  void _setThemeBrightness(
      ThemeCubit brightnessValue, bool brightnessValueIsLight) {
    brightnessValue.setThemeBrightness(
        brightnessValueIsLight ? Brightness.dark : Brightness.light);
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
