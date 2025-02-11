part of 'task_bloc.dart';

// @immutable
sealed class TaskEvent {}

class TaskLoadEvent extends TaskEvent {}

class TaskLoadedEvent extends TaskEvent {}


