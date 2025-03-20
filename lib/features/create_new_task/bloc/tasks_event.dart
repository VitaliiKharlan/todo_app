part of 'tasks_bloc.dart';

@immutable
sealed class TasksEvent {}

class LoadTasksEvent extends TasksEvent {}

class AddTaskEvent extends TasksEvent {
  AddTaskEvent(
    this.taskTitle,
    this.taskType,
    this.taskPriority,
    this.taskDeadline,
    this.taskDescription,
    this.taskLocation,
    this.taskRemindTime,
  );

  final String taskTitle;
  final TaskType? taskType;
  final int taskPriority;
  final DateTime? taskDeadline;
  final String? taskDescription;
  final LocationDetailsModel? taskLocation;
  final List<DateTime>? taskRemindTime;
}

class DeleteTaskEvent extends TasksEvent {
  DeleteTaskEvent(
    this.taskDelete,
  );

  final Task taskDelete;
}

class EditTaskEvent extends TasksEvent {
  EditTaskEvent({
    required this.oldTask,
    required this.taskTitle,
    this.taskType,
    required this.taskPriority,
    this.taskDeadline,
    this.taskDescription,
    this.taskLocation,
    this.taskRemindTime,
  });

  final Task oldTask;
  final String taskTitle;
  final TaskType? taskType;
  final int taskPriority;
  final DateTime? taskDeadline;
  final String? taskDescription;
  final LocationDetailsModel? taskLocation;
  final List<DateTime>? taskRemindTime;
}
