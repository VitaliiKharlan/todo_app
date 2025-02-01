import 'package:flutter_bloc/flutter_bloc.dart';

import '../view/add_new_task_screen.dart';

part 'add_new_task_event.dart';

part 'add_new_task_state.dart';

class AddNewTaskBloc extends Bloc<AddNewTaskEvent, AddNewTaskState> {
  AddNewTaskBloc() : super(AddNewTaskInitialState()) {
    on<LoadAddNewTaskEvent>((event, emit) {
      // TODO: implement event handler
      print('Loading Add New Task');
    });
    on<LoadedAddNewTaskEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        print('Loaded Add New Task');

        emit(AddNewTaskLoadedState([]));
      } catch (e) {
        emit(AddNewTaskLoadingFailureState(e));
      }
    });
  }
// final List[Task] tasks;
}
