part of 'tasks_bloc.dart';

// @immutable
sealed class TasksState {}

final class InitialTasksState extends TasksState {}

class AddNewTaskLoadingState extends TasksState {}

class LoadedTasksState extends TasksState {
  LoadedTasksState(
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

class DeletedTasksState extends TasksState {
  DeletedTasksState(
      this.tasksDelete,
      );

  final List<String> tasksDelete;
}

class DeletingFailureTasksState extends TasksState {
  DeletingFailureTasksState(
      this.exception,
      );

  final Object? exception;
}