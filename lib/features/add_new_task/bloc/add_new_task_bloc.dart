import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'add_new_task_event.dart';
part 'add_new_task_state.dart';

class AddNewTaskBloc extends Bloc<AddNewTaskEvent, AddNewTaskState> {
  AddNewTaskBloc() : super(AddNewTaskInitial()) {
    on<AddNewTaskEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
