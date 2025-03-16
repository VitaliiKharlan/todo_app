import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:todo_app/features/task_details/data/data.dart';

import 'package:todo_app/features/task_details/data/models/geo_position_search_for_weather.dart';

// https://api.accuweather.com/currentconditions/v1/{locationKey}?apikey={yourApiKey}

abstract class GeoPositionSearchForWeatherRepository {
  Future<GeoPositionSearchForWeatherModel> fetchLocalizedName(
      {required double lat, required double lng});

  Future<GeoPositionSearchForWeatherModel> fetchCountryName(
      {required double lat, required double lng});

  Future<GeoPositionSearchForWeatherModel> fetchLocationCityKey(
      {required double lat, required double lng});

  Future<WeatherCurrentConditionsModel> getCurrentWeather(
      {required double lat, required double lng});
}

class ImplGeoPositionSearchForWeatherRepository
    implements GeoPositionSearchForWeatherRepository {
  final String _apiKey = 'IudhJx5rUiBJAECUtkWBxs6ep8FW1uU1';
  final String _baseUrlGeoPositionSearchForWeather =
      'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search';

  @override
  Future<GeoPositionSearchForWeatherModel> fetchLocalizedName({
    required double lat,
    required double lng,
  }) async {
    debugPrint('fetchLocalizedName called with lat: $lat, lng: $lng');

    final String requestUrl = '$_baseUrlGeoPositionSearchForWeather?'
        'apikey=$_apiKey&q=$lat%2C$lng';

    debugPrint('Sending request to AccuWeather API: $requestUrl');

    final response = await http.get(Uri.parse(requestUrl));

    debugPrint('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      debugPrint('Localized name extracted: ${data['LocalizedName']}');

      return GeoPositionSearchForWeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load localized name');
    }
  }

  @override
  Future<GeoPositionSearchForWeatherModel> fetchCountryName({
    required double lat,
    required double lng,
  }) async {
    debugPrint('fetchLocalizedName called with lat: $lat, lng: $lng');

    final String requestUrl = '$_baseUrlGeoPositionSearchForWeather?'
        'apikey=$_apiKey&q=$lat%2C$lng';

    debugPrint('Sending request to AccuWeather API: $requestUrl');

    final response = await http.get(Uri.parse(requestUrl));

    debugPrint('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      debugPrint('Country extracted: ${data['Country']['LocalizedName']}');

      return GeoPositionSearchForWeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load localized name');
    }
  }

  @override
  Future<GeoPositionSearchForWeatherModel> fetchLocationCityKey({
    required double lat,
    required double lng,
  }) async {
    debugPrint('fetchLocationCityKey called with lat: $lat, lng: $lng');

    final String requestUrl = '$_baseUrlGeoPositionSearchForWeather?'
        'apikey=$_apiKey&q=$lat%2C$lng';

    debugPrint('Sending request to AccuWeather API: $requestUrl');

    final response = await http.get(Uri.parse(requestUrl));

    debugPrint('Response status: ${response.statusCode}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      debugPrint('Location city key: ${data['Key']}');

      return GeoPositionSearchForWeatherModel.fromJson(data);
    } else {
      throw Exception('Failed to load location city key');
    }
  }

  @override
  Future<WeatherCurrentConditionsModel> getCurrentWeather(
      {required double lat, required double lng}) {
    throw UnimplementedError();
  }
}

class MockGeoPositionSearchForWeatherRepository
    implements GeoPositionSearchForWeatherRepository {
  @override
  Future<GeoPositionSearchForWeatherModel> fetchLocalizedName(
      {required double lat, required double lng}) async {
    await Future.delayed(Duration(seconds: 1));
    return GeoPositionSearchForWeatherModel(
        localizedName: 'Kyiv',
        countryName: 'Ukraine',
        locationCityKey: '324505');
  }

  @override
  Future<GeoPositionSearchForWeatherModel> fetchCountryName(
      {required double lat, required double lng}) async {
    await Future.delayed(Duration(seconds: 1));
    return GeoPositionSearchForWeatherModel(
        localizedName: 'Warsaw',
        countryName: 'Poland',
        locationCityKey: '2722931');
  }

  @override
  Future<GeoPositionSearchForWeatherModel> fetchLocationCityKey(
      {required double lat, required double lng}) async {
    await Future.delayed(Duration(seconds: 1));
    return GeoPositionSearchForWeatherModel(
        localizedName: 'London', countryName: 'UK', locationCityKey: '2532685');
  }

  @override
  Future<WeatherCurrentConditionsModel> getCurrentWeather(
      {required double lat, required double lng}) async {
    await Future.delayed(Duration(seconds: 1));
    // final cityId = await fetchLocationCityKey(lat: lat, lng: lng);
    String mockData = '''
[
  {
    "LocalObservationDateTime": "2025-03-16T18:21:00+02:00",
    "EpochTime": 1742142060,
    "WeatherText": "Clear",
    "WeatherIcon": 33,
    "HasPrecipitation": false,
    "PrecipitationType": null,
    "IsDayTime": false,
    "Temperature": {
      "Metric": {
        "Value": 4.4,
        "Unit": "C",
        "UnitType": 17
      },
      "Imperial": {
        "Value": 40,
        "Unit": "F",
        "UnitType": 18
      }
    },
    "MobileLink": "http://www.accuweather.com/en/ua/kyiv/324505/current-weather/324505?lang=en-us",
    "Link": "http://www.accuweather.com/en/ua/kyiv/324505/current-weather/324505?lang=en-us"
  }
]
''';

    ///Make forecats request
    ///parse
    ///return model
    final data = json.decode(mockData)[0];
    final weatherCurrentDescription = data['WeatherText'];
    final weatherCurrentIcon = data['WeatherIcon'];

    final weatherCurrentTemperature = Temperature(

      metric: Metric(value: data['Temperature']['Metric']['Value']),
    );
    return WeatherCurrentConditionsModel(
        weatherCurrentDescription: weatherCurrentDescription,
        weatherCurrentIcon: weatherCurrentIcon,
        weatherCurrentTemperature: weatherCurrentTemperature);
  }
}
