part of 'tasks_bloc.dart';

// @immutable
sealed class TasksState {}

final class InitialTasksState extends TasksState {}

class AddNewTaskLoadingState extends TasksState {}

class TasksLoadedState extends TasksState {
  TasksLoadedState(
    this.tasks,
  );

  final List<Task> tasks;
}

class LoadingFailureTasksState extends TasksState {
  LoadingFailureTasksState(
    this.exception,
  );

  final Object? exception;
}

class DeletingFailureTasksState extends TasksState {
  DeletingFailureTasksState(
    this.exception,
  );

  final Object? exception;
}
