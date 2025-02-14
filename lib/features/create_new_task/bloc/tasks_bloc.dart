import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/create_new_task_screen.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(InitialTasksState()) {
    on<AddTaskEvent>((event, emit) async {
      try {
        print('Load Event');

        List<Task> tasks = [];
        final task = Task(
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
        tasks.add(task);
        // tasks.sort((a, b) => b.taskCreatedAt.compareTo(a.taskCreatedAt));

        emit(TasksLoadedState(tasks));
      } catch (e) {
        print('Error adding task: $e');
        emit(TasksDeletingFailureState(e.toString()));
      }
    });

    on<DeleteTaskEvent>((event, emit) {
      try {
        print('Delete Event');

        if (state is TasksLoadedState) {
          final currentTasks = (state as TasksLoadedState).tasks;

          //  first
          // final updatedTasks =
          //     currentTasks.remove(event.taskDelete) as List<Task>;

          // second
          // List<Task> updatedTasks = List.of(currentTasks);
          // updatedTasks.remove(event.taskDelete);

          // third
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
    });
  }
}
