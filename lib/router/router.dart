import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:todo_app/features/task_derail/task_detail.dart';

import '../features/add_new_task/view/add_new_task_screen.dart';
import '../features/home/view/home_screen.dart';
import '../features/settings/view/settings_screen.dart';
import '../features/task/view/task_screen.dart';

part 'router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes {
    return [
      /// routes go here
      AutoRoute(
        page: HomeRoute.page,
        path: '/',
        children: [
          AutoRoute(
            page: TaskRoute.page,
            path: 'task',
          ),
          AutoRoute(
            page: SettingsRoute.page,
            path: 'settings',
          ),
          AutoRoute(
            page: AddNewTaskRoute.page,
            path: 'add_new_task',
          ),
        ],
      ),
    AutoRoute(
    page: TaskDetailRoute.page,
    path: '/task/:taskId',
      ),

    ];
  }
}


