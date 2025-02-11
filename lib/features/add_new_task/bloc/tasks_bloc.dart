import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/add_new_task_screen.dart';

part 'tasks_event.dart';

part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  TasksBloc() : super(InitialTasksState()) {
    on<LoadTasksEvent>((event, emit) async {
      try {
        print('Load Event');

        List<Task> tasks = [];
        final task = Task(
          taskTitle: event.taskTitle,
          taskDescription: event.taskDescription,
          taskDeadline: event.taskDeadline,
          taskType: event.taskType,
        );

        if (state is LoadedTasksState) {
          final currentTasks = (state as LoadedTasksState).tasks;
          tasks.addAll(currentTasks);
          print('Loaded Tasks State');
        }
        tasks.add(task);

        emit(LoadedTasksState(tasks));
      } catch (e) {
        print('Error adding task: $e');
        emit(DeletingFailureTasksState(e.toString()));
      }
    });

//
    on<DeleteTasksEvent>((event, emit) {
      try {
        print('Delete Event');

        if (state is LoadedTasksState) {
          final currentTasks = (state as LoadedTasksState).tasks;

          final updatedTasks = currentTasks
              .where((task) => task.taskTitle != event.taskDelete)
              .toList();

          updatedTasks.remove(event.taskDelete);

          print('Task deleted: ${event.taskDelete}');
          emit(LoadedTasksState(updatedTasks));
        } else {
          print('No tasks to delete.');
          emit(DeletingFailureTasksState('No tasks available to delete.'));
        }
      } catch (e) {
        print('Error deleting task: $e');
        emit(DeletingFailureTasksState(e.toString()));
      }
    });
  }
}
