part of 'task_bloc.dart';

// @immutable
sealed class TaskState {}

final class TaskInitial extends TaskState {}

final class TaskInitialState extends TaskState {}

class TaskLoadingState extends TaskState {}

class TaskLoadedState extends TaskState {
  TaskLoadedState(
      this.tasks,
      );

  final List<Task> tasks;
}

class TaskLoadingFailureState extends TaskState {
  TaskLoadingFailureState(
      this.exception,
      );

  final Object? exception;
}

