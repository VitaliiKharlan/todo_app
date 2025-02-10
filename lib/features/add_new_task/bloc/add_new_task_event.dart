part of 'add_new_task_bloc.dart';

// @immutable
sealed class AddNewTaskEvent {}

class AddNewTaskLoadEvent extends AddNewTaskEvent {}

class AddNewTaskLoadedEvent extends AddNewTaskEvent {
  AddNewTaskLoadedEvent(

    this.taskTitle,
    this.taskDeadline,
    this.taskType,
  );


  final String taskTitle;
  final DateTime? taskDeadline;
  final TaskType? taskType;
}
