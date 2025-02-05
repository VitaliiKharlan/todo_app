import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/features/settings/bloc/settings_bloc.dart';
import 'package:todo_app/features/task/bloc/task_bloc.dart';

import '../../../router/router.dart';
import '../../add_new_task/bloc/add_new_task_bloc.dart';

@RoutePage()
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});



  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);


    return AutoTabsRouter(
      routes: [
        TaskRoute(theme: theme),
        SettingsRoute(),
        AddNewTaskRoute(),
      ],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return
          //
          // MultiBlocProvider
          //
          MultiBlocProvider(
          providers: [
            BlocProvider(create: (context) => TaskBloc()),
            BlocProvider(create: (context) => SettingsBloc()),
            BlocProvider(create: (context) => AddNewTaskBloc()),
          ],
          child:
          //
              //
              // BlocProvider
              //
              // BlocProvider(
              // create: (context) => AddNewTaskBloc(),
              // child:
              //
              Scaffold(
            backgroundColor: Theme.of(context).colorScheme.surface,
            body: child,
            bottomNavigationBar: BottomNavigationBar(
              selectedItemColor: theme.primaryColor,
              unselectedItemColor: theme.hintColor,
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w500),
              currentIndex: tabsRouter.activeIndex,
              onTap: (index) => _openPage(index, tabsRouter),
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.update),
                  label: 'Task',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Settings',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.add),
                  label: 'Add new task',
                ),
              ],
            ),
            //
            // ),
            //
          ),
        );
      },
    );
  }

  void _openPage(int index, TabsRouter tabsRouter) {
    tabsRouter.setActiveIndex(index);
  }
}
