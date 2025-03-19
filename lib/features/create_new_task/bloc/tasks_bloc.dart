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

  TasksBloc({required this.taskRepository}) : super(InitialTasksState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
    on<EditTaskEvent>(_onEditTask);
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
        taskDescription: event.taskDescription,
        taskDeadline: event.taskDeadline,
        taskType: event.taskType,
        taskLocation: event.taskLocation,
        taskRemindTime: event.taskRemindTime,
      );

      if (state is TasksLoadedState) {
        final currentTasks = (state as TasksLoadedState).tasks;
        tasks.addAll(currentTasks);
        debugPrint('Loaded Tasks State');
      }
      tasks.add(newTask);

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
          taskDescription: event.taskDescription,
          taskType: event.taskType,
          taskDeadline: event.taskDeadline,
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
}
