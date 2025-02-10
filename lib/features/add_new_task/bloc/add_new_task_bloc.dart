import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/add_new_task_screen.dart';

part 'add_new_task_event.dart';

part 'add_new_task_state.dart';

class AddNewTaskBloc extends Bloc<AddNewTaskEvent, AddNewTaskState> {
  AddNewTaskBloc() : super(AddNewTaskInitialState()) {
    on<AddNewTaskLoadEvent>((event, emit) {
      print('Add New Task Load Event');
      emit(AddNewTaskLoadedState([]));
    });

    on<AddNewTaskLoadedEvent>((event, emit) async {
      try {
        print('Add New Task Loaded Event');

        List<Task> tasks = [];
        final task = Task(
          taskId: '',
          taskTitle: event.taskTitle,
          taskDeadline: event.taskDeadline,
          taskType: event.taskType,
        );

        if (state is AddNewTaskLoadedState) {
          final currentTasks = (state as AddNewTaskLoadedState).tasks;
          tasks.addAll(currentTasks);
          print('Add New Task Loaded State');
        }
        tasks.add(task);

        emit(AddNewTaskLoadedState(tasks));
      } catch (e) {
        print('Error adding task: $e');
        emit(AddNewTaskLoadingFailureState(e.toString()));
      }
    });
  }
}
