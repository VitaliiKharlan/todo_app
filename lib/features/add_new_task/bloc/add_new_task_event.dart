part of 'add_new_task_bloc.dart';

// @immutable
sealed class AddNewTaskEvent {}

class AddNewTaskLoadEvent extends AddNewTaskEvent {}

class AddNewTaskLoadedEvent extends AddNewTaskEvent {
  AddNewTaskLoadedEvent(
    this.taskTitle,
    this.taskDescription,
    this.taskDeadline,
    this.taskType,
  );

  final String taskTitle;
  final String? taskDescription;
  final DateTime? taskDeadline;
  final TaskType? taskType;
}
