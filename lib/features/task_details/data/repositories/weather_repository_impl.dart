import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/features/task_details/data/models/weather_city_search.dart';
import 'package:todo_app/features/task_details/data/models/weather_current_conditions.dart';

import 'package:todo_app/features/task_details/data/repositories/weather_repository.dart';

class ImplWeatherRepository implements WeatherRepository {
  // final String _apiKey = 'IudhJx5rUiBJAECUtkWBxs6ep8FW1uU1'; // todo_app
  final String _apiKey = 'zryPxM5Pb0G7AJgltCiSH0rCqA8whNiq'; // todo_app_2
  final String _baseUrlCitySearch =
      'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search';
  final String _baseUrlCurrentConditions =
      'http://dataservice.accuweather.com/currentconditions/v1/';

  // final String _locationCityKey = '324505';

  @override
  Future<WeatherCitySearchModel> getCitySearch({
    required double lat,
    required double lng,
  }) async {
    debugPrint('fetchLocalizedName called with lat: $lat, lng: $lng');

    final String requestUrl = '$_baseUrlCitySearch?'
        'apikey=$_apiKey&q=$lat%2C$lng';

    debugPrint('Sending request to AccuWeather API: $requestUrl');

    final response = await http.get(Uri.parse(requestUrl));

    debugPrint('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      debugPrint('City search: ${data['LocalizedName']}; '
          '${data['Country']['LocalizedName']}; '
          '${data['Key']}');

      final citySearchLocalizedName = data['LocalizedName'];
      final citySearchCountryLocalizedName = data['Country']['LocalizedName'];
      final citySearchLocationCityKey = data['Key'];

      final citySearchData = {
        'LocalizedName': citySearchLocalizedName,
        'Country': {
          'LocalizedName': citySearchCountryLocalizedName,
        },
        'Key': citySearchLocationCityKey,
      };

      return WeatherCitySearchModel.fromJson(citySearchData);
    } else {
      throw Exception('Failed to load localized name');
    }
  }

  @override
  Future<WeatherCurrentConditionsModel> getCurrentConditions({
    required int locationCityKey,
  }) async {
    debugPrint(
        'getCurrentWeather called with locationCityKey: $locationCityKey');

    final String requestUrl = '$_baseUrlCurrentConditions'
        '$locationCityKey?apikey=$_apiKey';

    debugPrint('Sending request to get current weather: $requestUrl');

    final response = await http.get(Uri.parse(requestUrl));

    debugPrint('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body)[0];

      debugPrint('Current weather: ${data['WeatherText']}, '
          '${data['WeatherIcon']}, '
          '${data['Temperature']['Metric']['Value']}, '
          '${data['LocalObservationDateTime']}');

      final weatherCurrentDescription = data['WeatherText'];
      final weatherCurrentIcon = data['WeatherIcon'];
      final weatherCurrentTemperature = Temperature(
        metric: Metric(
          value: data['Temperature']['Metric']['Value'].round().toDouble(),
        ),
      );
      final String weatherCurrentLocalObservationDateTime =
          data['LocalObservationDateTime'];

      final weatherData = {
        'WeatherText': weatherCurrentDescription,
        'WeatherIcon': weatherCurrentIcon,
        'Temperature': {
          'Metric': {
            'Value': weatherCurrentTemperature.metric.value,
          }
        },
        'LocalObservationDateTime': weatherCurrentLocalObservationDateTime,
      };

      return WeatherCurrentConditionsModel.fromJson(weatherData);
    } else {
      throw Exception('Failed to load current weather');
    }
  }
}
