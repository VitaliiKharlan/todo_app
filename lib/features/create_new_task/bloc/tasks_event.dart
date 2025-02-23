part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

class LoadTasksEvent extends TasksEvent {}

class AddTaskEvent extends TasksEvent {
  AddTaskEvent(
    this.taskTitle,
    this.taskDescription,
    this.taskDeadline,
    this.taskType,
    this.taskLocation,
  );

  final String taskTitle;
  final String? taskDescription;
  final DateTime? taskDeadline;
  final TaskType? taskType;
  final LocationDetailsModel? taskLocation;
}

class DeleteTaskEvent extends TasksEvent {
  DeleteTaskEvent(this.taskDelete);

  final Task taskDelete;
}
