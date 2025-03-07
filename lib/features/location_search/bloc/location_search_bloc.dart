import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/create_new_task/data/data.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';

part 'location_search_event.dart';

part 'location_search_state.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final PlaceDetailsRepository placeDetailsRepository;

  LocationSearchBloc(this.placeDetailsRepository)
      : super(LocationSearchInitialState()) {
    on<LocationSearchTextChangeEvent>(_onTextChange);
  }

  Future<void> _onTextChange(LocationSearchTextChangeEvent event,
      Emitter<LocationSearchState> emit) async {
    if (event.query.isEmpty) {
      emit(LocationSearchInitialState());
      return;
    }

    emit(LocationSearchLoadingState());

    try {
      debugPrint('Location Search Text Change Event');
      final suggestions =
          await placeDetailsRepository.getPlaceDetails(event.query);

      emit(LocationSearchLoadedState(suggestions));
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);

      emit(LocationSearchFailureState(e.toString()));
    }
  }
}
