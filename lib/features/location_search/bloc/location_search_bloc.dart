import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/create_new_task/data/repositories/place_details_repository.dart';

part 'location_search_event.dart';

part 'location_search_state.dart';

class LocationSearchBloc
    extends Bloc<LocationSearchEvent, LocationSearchState> {
  final PlaceDetailsRepository _placeDetailsRepository;

  LocationSearchBloc(
    this._placeDetailsRepository,
  ) : super(LocationSearchInitialState()) {
    on<LocationSearchTextChangeEvent>(_onTextChange);
    on<LocationSelectEvent>(_onLocationSelect);
  }

  Future<void> _onTextChange(LocationSearchTextChangeEvent event,
      Emitter<LocationSearchState> emit) async {
    debugPrint('Location Search Text Change Event');
    if (event.query.isEmpty) {
      emit(LocationSearchInitialState());
      return;
    }

    emit(LocationSearchLoadingState());

    try {
      final suggestions =
          await _placeDetailsRepository.getPlaceDetails(event.query);

      emit(LocationSearchLoadedState(suggestions));
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);

      emit(LocationSearchFailureState(e.toString()));
    }
  }

  Future<void> _onLocationSelect(
      LocationSelectEvent event, Emitter<LocationSearchState> emit) async {
    debugPrint('Location Select Event');
  }
}
