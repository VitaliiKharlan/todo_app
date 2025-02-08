part of 'add_new_task_bloc.dart';

// @immutable
sealed class AddNewTaskEvent {}

class AddNewTaskLoadEvent extends AddNewTaskEvent {}

class AddNewTaskLoadedEvent extends AddNewTaskEvent {
  final String taskTitle;
  final DateTime? taskDeadline;

  AddNewTaskLoadedEvent(this.taskTitle, this.taskDeadline);
}
