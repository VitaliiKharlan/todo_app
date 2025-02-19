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
    // this.selectedLocation,
  );

  final List<Task> tasks;
  // final String? selectedLocation;

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
