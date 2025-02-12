import 'package:flutter_bloc/flutter_bloc.dart';

import '../../create_new_task/view/create_new_task_screen.dart';

part 'settings_event.dart';
part 'settings_state.dart';



class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(SettingsInitial()) {
    on<SettingsLoadEvent>((event, emit) {
      // TODO: implement event handler
      print('Loading Settings');
    });
    on<SettingsLoadedEvent>((event, emit) async {
      // TODO: implement event handler
      try {
        print('Loaded Settings');

        emit(SettingsLoadedState([]));
      } catch (e) {
        emit(SettingsLoadingFailureState(e));
      }
    });
  }
// final List[Task] tasks;
}
