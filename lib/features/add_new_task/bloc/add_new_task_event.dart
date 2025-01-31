part of 'add_new_task_bloc.dart';

// @immutable
sealed class AddNewTaskEvent {}

class LoadAddNewTaskEvent extends AddNewTaskEvent {}

class LoadedAddNewTaskEvent extends AddNewTaskEvent {}


