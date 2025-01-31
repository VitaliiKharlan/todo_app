part of 'add_new_task_bloc.dart';

// @immutable
sealed class AddNewTaskState {}

final class AddNewTaskInitial extends AddNewTaskState {}

class AddNewTaskLoading extends AddNewTaskState {}

class AddNewTaskLoaded extends AddNewTaskState {
  AddNewTaskLoaded(this.task);

  final String task;
}
