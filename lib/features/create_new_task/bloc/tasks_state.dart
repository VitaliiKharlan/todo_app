part of 'tasks_bloc.dart';

@immutable
sealed class TasksState {}

final class InitialTasksState extends TasksState {}

class AddNewTaskLoadingState extends TasksState {}

class TasksLoadedState extends TasksState {
  TasksLoadedState(
    this.tasks,
  );

  final List<Task> tasks;
}

class TasksLoadingFailureState extends TasksState {
  TasksLoadingFailureState(
    this.exception,
  );

  final Object? exception;
}

class TasksDeletingFailureState extends TasksState {
  TasksDeletingFailureState(
    this.exception,
  );

  final Object? exception;
}
