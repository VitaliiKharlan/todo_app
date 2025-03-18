import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:todo_app/features/create_new_task/data/data.dart';
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/task_details/data/data.dart';
import 'package:todo_app/features/task_details/data/repositories/geo_position_search_for_weather_repository.dart';

part 'weather_event.dart';

part 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GeoPositionSearchForWeatherRepository
      _geoPositionSearchForWeatherRepository;

  WeatherBloc(
    this._geoPositionSearchForWeatherRepository,
  ) : super(WeatherInitialState()) {
    on<WeatherSelectEvent>(_onLocationForWeatherSelect);
  }

  Future<void> _onLocationForWeatherSelect(
      WeatherSelectEvent event, Emitter<WeatherState> emit) async {
    debugPrint('Weather Select Event');
    emit(WeatherLoadingState());

    try {
      final citySearch =
      await _geoPositionSearchForWeatherRepository.getCitySearch(
        lat: event.locationDetailsModel.lat ?? 0.0,
        lng: event.locationDetailsModel.lng ?? 0.0,
      );
      //
      // final localizedNameForWeatherData =
      //     await _geoPositionSearchForWeatherRepository.fetchLocalizedName(
      //   lat: event.locationDetailsModel.lat ?? 0.0,
      //   lng: event.locationDetailsModel.lng ?? 0.0,
      // );
      // final countryNameForWeatherData =
      //     await _geoPositionSearchForWeatherRepository.fetchCountryName(
      //   lat: event.locationDetailsModel.lat ?? 0.0,
      //   lng: event.locationDetailsModel.lng ?? 0.0,
      // );
      // final locationCityKeyForWeatherData =
      //     await _geoPositionSearchForWeatherRepository.fetchLocationCityKey(
      //   lat: event.locationDetailsModel.lat ?? 0.0,
      //   lng: event.locationDetailsModel.lng ?? 0.0,
      // );
      //
      final currentWeather =
          await _geoPositionSearchForWeatherRepository.getCurrentWeather(
        lat: event.locationDetailsModel.lat ?? 0.0,
        lng: event.locationDetailsModel.lng ?? 0.0,
      );

      // final weatherData = event.weatherCurrentConditionsModel;

      debugPrint(
          'This Is Success: ${citySearch.localizedName} ');
      debugPrint('This Is Success: ${citySearch.countryName} ');
      debugPrint(
          'This Is Success: ${citySearch.locationCityKey} ');
      debugPrint(
          'This Is Success: ${currentWeather.weatherCurrentDescription}, '
              '${currentWeather.weatherCurrentIcon}, '
              '${currentWeather.weatherCurrentTemperature.metric.value} '
              '${currentWeather.weatherCurrentLocalObservationDateTime} ');

      emit(WeatherSelectedState(
        citySearch.localizedName,
        citySearch.countryName,
        int.tryParse(citySearch.locationCityKey) ?? 0,
        currentWeather.weatherCurrentDescription,
        currentWeather.weatherCurrentIcon,
        currentWeather.weatherCurrentTemperature.metric.value,
        currentWeather.weatherCurrentLocalObservationDateTime,
      ));
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(WeatherSelectedFailureState(e.toString()));
    }
  }
}
