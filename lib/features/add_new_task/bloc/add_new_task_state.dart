part of 'add_new_task_bloc.dart';

// @immutable
sealed class AddNewTaskState {}

final class AddNewTaskInitialState extends AddNewTaskState {}

class AddNewTaskLoadingState extends AddNewTaskState {}

class AddNewTaskLoadedState extends AddNewTaskState {
  AddNewTaskLoadedState(
    this.tasks,
  );

  final List<Task> tasks;
  // var data = Data(tasks []);
}

class AddNewTaskLoadingFailureState extends AddNewTaskState {
  AddNewTaskLoadingFailureState(
    this.exception,
  );

  final Object? exception;
}
