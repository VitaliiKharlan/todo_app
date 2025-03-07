import 'package:flutter/material.dart';

import 'package:auto_route/auto_route.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/create_new_task.dart';
import 'package:todo_app/features/home/home.dart';
import 'package:todo_app/features/location_search/view/location_search_screen.dart';
import 'package:todo_app/features/settings/settings.dart';
import 'package:todo_app/features/task/task.dart';
import 'package:todo_app/features/task_details/task_details.dart';

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
            page: CreateNewTaskRoute.page,
            path: 'create_new_task',
          ),
          AutoRoute(
            page: CreateNewTaskRoute.page,
            path: 'edit_task',
          ),
        ],
      ),
      AutoRoute(
        page: LocationSearchRoute.page,
        path: '/location_search',
      ),
      AutoRoute(
        page: TaskDetailsRoute.page,
        path: '/task_details',
      ),
    ];
  }
}
