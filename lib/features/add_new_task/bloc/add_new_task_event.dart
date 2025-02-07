part of 'add_new_task_bloc.dart';

// @immutable
sealed class AddNewTaskEvent {}

class AddNewTaskLoadEvent extends AddNewTaskEvent {}

class AddNewTaskLoadedEvent extends AddNewTaskEvent {
  final String title;
  // final DateTime? deadline;

  AddNewTaskLoadedEvent(this.title);
}
