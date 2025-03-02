import 'package:flutter/cupertino.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/create_new_task/data/repositories/task_repository.dart';
import 'package:uuid/uuid.dart';

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
      debugPrint('Load Event');

      final tasksData = await taskRepository.fetchTasks();

      final tasks = tasksData.map((data) => Task.fromMap(data)).toList();
      emit(TasksLoadedState(tasks));
    } catch (e, s) {
      debugPrint('Error fetching tasks: $e $s');
      emit(TasksLoadingFailureState(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) async {
    try {
      debugPrint('Add Event');

      List<Task> tasks = [];
      final newTask = Task(
        taskTitle: event.taskTitle,
        taskDescription: event.taskDescription,
        taskDeadline: event.taskDeadline,
        taskType: event.taskType,
        taskLocation: event.taskLocation,
        id: Uuid().v4(),
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
      debugPrint('Error adding task: $e $s');
      emit(TasksDeletingFailureState(e.toString()));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TasksState> emit) async {
    try {
      debugPrint('Delete Event');
      await taskRepository.deleteTask(event.taskDelete.taskTitle);

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
      debugPrint('Edit Event');

      if (state is TasksLoadedState) {
        final currentTasks = [...(state as TasksLoadedState).tasks];
        final taskIndex =
            currentTasks.indexWhere((e) => e.taskId == event.editTask.taskId);
        currentTasks.removeAt(taskIndex);
        currentTasks.insert(taskIndex, event.editTask);
        emit(TasksLoadedState(currentTasks));
        await taskRepository.updateTask(
          event.editTask.taskId,
          event.editTask.toMap(),
        );
      }
    } catch (e, s) {
      debugPrint('Error editing task: $e $s');
      emit(TasksEditingFailureState(e.toString()));
    }
  }
}
