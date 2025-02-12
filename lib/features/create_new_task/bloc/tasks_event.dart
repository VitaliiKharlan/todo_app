part of 'tasks_bloc.dart';

// @immutable
sealed class TasksEvent {}

// class LoadTasksEvent extends TasksEvent {}

class LoadTasksEvent extends TasksEvent {
  LoadTasksEvent(
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

class DeleteTasksEvent extends TasksEvent {
  DeleteTasksEvent(this.taskDelete);

  final Task taskDelete;
}