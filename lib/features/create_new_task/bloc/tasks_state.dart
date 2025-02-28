part of 'tasks_bloc.dart';

@immutable
sealed class TasksState extends Equatable {}

final class InitialTasksState extends TasksState {
  @override
  List<Object?> get props => [];
}

class AddNewTaskLoadingState extends TasksState {
  @override
  List<Object?> get props => [];
}

class TasksLoadedState extends TasksState {
  TasksLoadedState(
    this.tasks,
  );

  final List<Task> tasks;

  @override
  List<Object?> get props => [tasks];
}

class TasksLoadingFailureState extends TasksState {
  TasksLoadingFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

class TasksDeletingFailureState extends TasksState {
  TasksDeletingFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

class TasksEditingFailureState extends TasksState {
  final Object? exception;

  TasksEditingFailureState(this.exception);

  @override
  List<Object?> get props => [exception];
}
