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
      final localizedNameForWeatherData =
          await _geoPositionSearchForWeatherRepository.fetchLocalizedName(
        lat: event.locationDetailsModel.lat ?? 0.0,
        lng: event.locationDetailsModel.lng ?? 0.0,
      );
      final countryNameForWeatherData =
          await _geoPositionSearchForWeatherRepository.fetchCountryName(
        lat: event.locationDetailsModel.lat ?? 0.0,
        lng: event.locationDetailsModel.lng ?? 0.0,
      );
      final locationCityKeyForWeatherData =
          await _geoPositionSearchForWeatherRepository.fetchLocationCityKey(
        lat: event.locationDetailsModel.lat ?? 0.0,
        lng: event.locationDetailsModel.lng ?? 0.0,
      );
      final weatherData = event.weatherCurrentConditionsModel;

      debugPrint(
          'This Is Success: ${localizedNameForWeatherData.localizedName}');
      debugPrint('This Is Success: ${countryNameForWeatherData.countryName}');
      debugPrint(
          'This Is Success: ${locationCityKeyForWeatherData.locationCityKey}');

      emit(WeatherSelectedState(
        localizedNameForWeatherData.localizedName,
        countryNameForWeatherData.countryName,
        int.tryParse(locationCityKeyForWeatherData.locationCityKey) ?? 0,
        weatherData.weatherCurrentTemperature.metric.value,
      ));
      // emit(WeatherSelectedState(weatherData));
    } catch (e, s) {
      debugPrint('Error: $e');
      debugPrintStack(stackTrace: s);
      emit(WeatherSelectedFailureState(e.toString()));
    }
  }

// // alternative way
// //
// Future<void> _onLocationForWeatherSelect(
//     WeatherSelectEvent event, Emitter<WeatherState> emit) async {
//   debugPrint('Weather Select Event');
//   emit(WeatherLoadingState());
//
//   try {
//     final lat = event.locationDetailsModel.lat ?? 0.0;
//     final lng = event.locationDetailsModel.lng ?? 0.0;
//
//     final localizedName = await _geoPositionSearchForWeatherRepository
//         .fetchLocalizedName(lat: lat, lng: lng);
//     final countryName = await _geoPositionSearchForWeatherRepository
//         .fetchCountryName(lat: lat, lng: lng);
//     final cityKey = await _geoPositionSearchForWeatherRepository
//         .fetchLocationCityKey(lat: lat, lng: lng);
//
//     debugPrint('Localized Name: $localizedName');
//     debugPrint('Country Name: $countryName');
//     debugPrint('City Key: $cityKey');
//
//     emit(WeatherSelectedState(
//         localizedName, countryName, int.tryParse(cityKey) ?? 0));
//   } catch (e, s) {
//     debugPrint('Error: $e');
//     debugPrintStack(stackTrace: s);
//     emit(WeatherSelectedFailureState(e.toString()));
//   }
// }
// //
}
