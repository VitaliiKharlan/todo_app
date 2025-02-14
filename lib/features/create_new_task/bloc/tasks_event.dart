part of 'tasks_bloc.dart';

// @immutable
sealed class TasksEvent {}

class AddTaskEvent extends TasksEvent {
  AddTaskEvent(
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

class DeleteTaskEvent extends TasksEvent {
  DeleteTaskEvent(this.taskDelete);

  final Task taskDelete;
}
