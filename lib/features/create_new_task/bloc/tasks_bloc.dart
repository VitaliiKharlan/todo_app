import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/create_new_task/bloc/entities/task_entity.dart';
import 'package:todo_app/features/create_new_task/data/repositories/task_repository.dart';


part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  final TaskRepository taskRepository;

  TasksBloc({required this.taskRepository}) : super(InitialTasksState()) {
    on<LoadTasksEvent>(_onLoadTasks);
    on<AddTaskEvent>(_onAddTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }

  Future<void> _onLoadTasks(
      LoadTasksEvent event, Emitter<TasksState> emit) async {
    try {
      print('Load Event');

      final tasksData = await taskRepository.fetchTasks();
      final tasks = tasksData.map((data) => Task.fromMap(data)).toList();
      emit(TasksLoadedState(tasks));
    } catch (e) {
      emit(TasksLoadingFailureState(e.toString()));
    }
  }

  Future<void> _onAddTask(AddTaskEvent event, Emitter<TasksState> emit) async {
    try {
      print('Add Event');

      List<Task> tasks = [];
      final newTask = Task(
        taskTitle: event.taskTitle,
        taskDescription: event.taskDescription,
        taskDeadline: event.taskDeadline,
        taskType: event.taskType,
      );

      if (state is TasksLoadedState) {
        final currentTasks = (state as TasksLoadedState).tasks;
        tasks.addAll(currentTasks);
        print('Loaded Tasks State');
      }
      tasks.add(newTask);


      emit(TasksLoadedState(tasks));
      await taskRepository.addTask(newTask.toMap());
    } catch (e,s) {
      print('Error adding task: $e $s');
      emit(TasksDeletingFailureState(e.toString()));
    }
  }

  Future<void> _onDeleteTask(
      DeleteTaskEvent event, Emitter<TasksState> emit) async {
    try {
      print('Delete Event');
      await taskRepository.deleteTask(event.taskDelete.taskTitle as int);

      if (state is TasksLoadedState) {
        final currentTasks = (state as TasksLoadedState).tasks;

        final updatedTasks =
            currentTasks.where((task) => task != event.taskDelete).toList();

        print('Task deleted: ${event.taskDelete}');
        emit(TasksLoadedState(updatedTasks));
      } else {
        print('No tasks to delete.');
        emit(TasksDeletingFailureState('No tasks available to delete.'));
      }
    } catch (e) {
      print('Error deleting task: $e');
      emit(TasksDeletingFailureState(e.toString()));
    }
  }
}
