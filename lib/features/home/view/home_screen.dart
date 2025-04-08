import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/create_new_task/data/data.dart';
import 'package:todo_app/router/router.dart';
import 'package:todo_app/features/create_new_task/bloc/tasks_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final taskRepository = TaskRepository();
  final placeDetailsRepository = PlaceDetailsRepository();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AutoTabsRouter(
      routes: [
        TaskRoute(theme: theme),
        SettingsRoute(),
        CreateNewTaskRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TasksBloc(taskRepository: taskRepository)
                ..add(
                  LoadTasksEvent(),
                ),
            ),
          ],
          child: Scaffold(
            backgroundColor: theme.colorScheme.surface,
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: theme.primaryColor,
              selectedLabelStyle: theme.textTheme.labelLarge,
              unselectedItemColor: theme.hintColor,
              unselectedLabelStyle: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.normal,
              ),
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) => _openPage(index, tabsRouter),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.task),
                  label: 'Task',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add_card),
                  label: 'Create new task',
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}
