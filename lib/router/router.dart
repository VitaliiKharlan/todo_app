import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

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
      // AutoRoute(
      //   page: TaskRoute.page,
      //   path: '/',
      // ),
    ];
  }
}

// @AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
// class AppRouter extends RootStackRouter {
//
//   @override
//   RouteType get defaultRouteType => RouteType.material(); //.cupertino, .adaptive ..etc
//
//   @override
//   List<AutoRoute> get routes => [
//     // HomeScreen is generated as HomeRoute because
//     // of the replaceInRouteName property
//     AutoRoute(page: HomeRoute.page),
//   ];
//
//   @override
//   List<AutoRouteGuard> get guards => [
//     // optionally add root guards here
//   ];
// }
