// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [CreateNewTaskScreen]
class CreateNewTaskRoute extends PageRouteInfo<void> {
  const CreateNewTaskRoute({List<PageRouteInfo>? children})
    : super(CreateNewTaskRoute.name, initialChildren: children);

  static const String name = 'CreateNewTaskRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const CreateNewTaskScreen();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({Key? key, List<PageRouteInfo>? children})
    : super(
        HomeRoute.name,
        args: HomeRouteArgs(key: key),
        initialChildren: children,
      );

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<HomeRouteArgs>(
        orElse: () => const HomeRouteArgs(),
      );
      return HomeScreen(key: args.key);
    },
  );
}

class HomeRouteArgs {
  const HomeRouteArgs({this.key});

  final Key? key;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key}';
  }
}

/// generated route for
/// [LocationSearchAutocompleteScreen]
class LocationSearchAutocompleteRoute extends PageRouteInfo<void> {
  const LocationSearchAutocompleteRoute({List<PageRouteInfo>? children})
    : super(LocationSearchAutocompleteRoute.name, initialChildren: children);

  static const String name = 'LocationSearchAutocompleteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const LocationSearchAutocompleteScreen();
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
/// [TaskDetailsScreen]
class TaskDetailsRoute extends PageRouteInfo<TaskDetailsRouteArgs> {
  TaskDetailsRoute({
    Key? key,
    required Task task,
    required void Function(Task) onDelete,
    List<PageRouteInfo>? children,
  }) : super(
         TaskDetailsRoute.name,
         args: TaskDetailsRouteArgs(key: key, task: task, onDelete: onDelete),
         initialChildren: children,
       );

  static const String name = 'TaskDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<TaskDetailsRouteArgs>();
      return TaskDetailsScreen(
        key: args.key,
        task: args.task,
        onDelete: args.onDelete,
      );
    },
  );
}

class TaskDetailsRouteArgs {
  const TaskDetailsRouteArgs({
    this.key,
    required this.task,
    required this.onDelete,
  });

  final Key? key;

  final Task task;

  final void Function(Task) onDelete;

  @override
  String toString() {
    return 'TaskDetailsRouteArgs{key: $key, task: $task, onDelete: $onDelete}';
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
