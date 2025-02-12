import 'package:flutter_bloc/flutter_bloc.dart';

import '../../create_new_task/view/create_new_task_screen.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeInitialState()) {
    on<HomeLoadEvent>((event, emit) {
      // TODO: implement event handler
      print('Loading Add New Task');
    });
    on<HomeLoadedEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        print('Loaded Add New Task');

        emit(HomeLoadedState([]));
      } catch (e) {
        emit(HomeLoadingFailureState(e));
      }
    });
  }
// final List[Task] tasks;
}
