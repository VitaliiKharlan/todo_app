import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/create_new_task/data/repositories/task_repository.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;
  List<Task> _displayedTasks = [];

  TasksBloc({required this.taskRepository}) : super(InitialTasksState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<EditTaskEvent>(_onEditTask);
    on<SearchTaskEvent>(_onSearchTask);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TasksState> emit) async {
    try {
      debugPrint('Load Tasks Event');

      final tasksData = await taskRepository.fetchTasks();

      if (tasksData.isEmpty) {
        debugPrint('No tasks found in the repository');
      } else {
        debugPrint('Fetched ${tasksData.length} tasks');
      }

      final tasks = tasksData.map((data) => Task.fromMap(data)).toList();
      tasks.sort((a, b) => b.taskCreatedAt.compareTo(a.taskCreatedAt));
      _displayedTasks = tasks;

      emit(TasksLoadedState(tasks));
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(TasksLoadingFailureState(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) async {
    try {
      debugPrint('Add Tasks Event');

      List<Task> tasks = [];
      final newTask = Task(
        taskId: Uuid().v4(),
        taskTitle: event.taskTitle,
        taskType: event.taskType,
        taskPriority: event.taskPriority,
        taskDeadline: event.taskDeadline,
        taskDescription: event.taskDescription,
        taskLocation: event.taskLocation,
        taskRemindTime: event.taskRemindTime,
      );

      if (state is TasksLoadedState) {
        final currentTasks = (state as TasksLoadedState).tasks;
        tasks.addAll(currentTasks);
        debugPrint('Loaded Tasks State');
      }
      tasks.add(newTask);
      _displayedTasks = tasks;

      if (tasks.isNotEmpty) {
        tasks.sort((a, b) => b.taskCreatedAt.compareTo(a.taskCreatedAt));
      }

      emit(TasksLoadedState(tasks));
      await taskRepository.addTask(newTask.toMap());
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(TasksDeletingFailureState(e.toString()));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TasksState> emit) async {
    try {
      debugPrint('Delete Tasks Event');
      await taskRepository.deleteTask(event.taskDelete.taskId);

      if (state is TasksLoadedState) {
        final currentTasks = (state as TasksLoadedState).tasks;

        final updatedTasks =
            currentTasks.where((task) => task != event.taskDelete).toList();
        _displayedTasks = updatedTasks;

        debugPrint('Task deleted: ${event.taskDelete}');
        emit(TasksLoadedState(updatedTasks));
      } else {
        debugPrint('No tasks to delete.');
        emit(TasksDeletingFailureState('No tasks available to delete.'));
      }
    } catch (e, s) {
      debugPrint('Error deleting task: $e $s');
      emit(TasksDeletingFailureState(e.toString()));
    }
  }

  Future<void> _onEditTask(
      EditTaskEvent event, Emitter<TasksState> emit) async {
    try {
      debugPrint('Edit Tasks Event');

      if (state is TasksLoadedState) {
        final currentState = state as TasksLoadedState;

        final updatedTask = event.oldTask.copyWith(
          taskTitle: event.taskTitle,
          taskType: event.taskType,
          taskPriority: event.taskPriority,
          taskDeadline: event.taskDeadline,
          taskDescription: event.taskDescription,
          taskLocation: event.taskLocation,
          taskRemindTime: event.taskRemindTime,
        );

        await taskRepository.updateTask(
          updatedTask.taskId,
          updatedTask.toMap(),
        );

        final updatedTasks = currentState.tasks.map((task) {
          return task.taskId == event.oldTask.taskId ? updatedTask : task;
        }).toList();

        emit(TasksLoadedState(updatedTasks));
      }
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(TasksEditingFailureState(e.toString()));
    }
  }

  Future<void> _onSearchTask(
      SearchTaskEvent event, Emitter<TasksState> emit) async {
    try {
      if (state is TasksLoadedState) {
        final query = event.query.toLowerCase().trim();

        if (query.isEmpty) {
          emit(TasksLoadedState(_displayedTasks));
        } else {
          final filteredTasks = _displayedTasks.where((task) {
            final taskTitle = task.taskTitle.toLowerCase();
            final words = taskTitle.split(' ');
            return words.any((word) => word.startsWith(query));
          }).toList();

          emit(TasksLoadedState(filteredTasks));
        }
      }
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(TasksEditingFailureState(e.toString()));
    }
  }
}
