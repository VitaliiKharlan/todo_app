import 'package:flutter/material.dart';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:todo_app/features/create_new_task/data/data.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/task_details/data/repositories/geo_position_search_for_weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final PlaceDetailsRepository placeDetailsRepository;
  final GeoPositionSearchForWeatherRepository
      geoPositionSearchForWeatherRepository;

  WeatherBloc(
    this.placeDetailsRepository,
    this.geoPositionSearchForWeatherRepository,
  ) : super(WeatherInitialState()) {
    on<WeatherSelectEvent>(_onLocationSelect);
  }

  Future<void> _onLocationSelect(
      WeatherSelectEvent event, Emitter<WeatherState> emit) async {
    debugPrint('Weather Select Event');
    emit(WeatherLoadingState());

    try {
      final localizedNameForWeatherData =
          await geoPositionSearchForWeatherRepository.fetchLocalizedName(
        lat: event.locationDetailsModel.lat ?? 0.0,
        lng: event.locationDetailsModel.lng ?? 0.0,
      );

      debugPrint(
          'This Is Success: ${localizedNameForWeatherData.localizedName}');
      emit(WeatherSelectedState(localizedNameForWeatherData.localizedName));
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(WeatherSelectedFailureState(e.toString()));
    }
  }
}
