// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [AddNewTaskScreen]
class AddNewTaskRoute extends PageRouteInfo<void> {
  const AddNewTaskRoute({List<PageRouteInfo>? children})
    : super(AddNewTaskRoute.name, initialChildren: children);

  static const String name = 'AddNewTaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const AddNewTaskScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}

/// generated route for
/// [SettingsScreen]
class SettingsRoute extends PageRouteInfo<void> {
  const SettingsRoute({List<PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const SettingsScreen();
    },
  );
}

/// generated route for
/// [TaskDetailScreen]
class TaskDetailRoute extends PageRouteInfo<TaskDetailRouteArgs> {
  TaskDetailRoute({Key? key, required Task task, List<PageRouteInfo>? children})
    : super(
        TaskDetailRoute.name,
        args: TaskDetailRouteArgs(key: key, task: task),
        initialChildren: children,
      );

  static const String name = 'TaskDetailRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskDetailRouteArgs>();
      return TaskDetailScreen(key: args.key, task: args.task);
    },
  );
}

class TaskDetailRouteArgs {
  const TaskDetailRouteArgs({this.key, required this.task});

  final Key? key;

  final Task task;

  @override
  String toString() {
    return 'TaskDetailRouteArgs{key: $key, task: $task}';
  }
}

/// generated route for
/// [TaskScreen]
class TaskRoute extends PageRouteInfo<TaskRouteArgs> {
  TaskRoute({Key? key, required ThemeData theme, List<PageRouteInfo>? children})
    : super(
        TaskRoute.name,
        args: TaskRouteArgs(key: key, theme: theme),
        initialChildren: children,
      );

  static const String name = 'TaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskRouteArgs>();
      return TaskScreen(key: args.key, theme: args.theme);
    },
  );
}

class TaskRouteArgs {
  const TaskRouteArgs({this.key, required this.theme});

  final Key? key;

  final ThemeData theme;

  @override
  String toString() {
    return 'TaskRouteArgs{key: $key, theme: $theme}';
  }
}
