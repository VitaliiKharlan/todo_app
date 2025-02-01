part of 'task_bloc.dart';

// @immutable
sealed class TaskEvent {}

class LoadTaskEvent extends TaskEvent {}

class LoadedTaskEvent extends TaskEvent {}
