import 'package:flutter_bloc/flutter_bloc.dart';

import '../../add_new_task/view/add_new_task_screen.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitialState()) {
    on<TaskLoadEvent>((event, emit) {
      // TODO: implement event handler
      print('Task Load Event');
    });
    on<TaskLoadedEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        print('Task Delete Event');

        emit(TaskLoadedState([]));
      } catch (e) {
        emit(TaskLoadingFailureState(e));
      }
    });
  }
// final List[Task] tasks;
}
