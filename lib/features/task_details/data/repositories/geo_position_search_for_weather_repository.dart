import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todo_app/features/task_details/data/models/geo_position_search_for_weather.dart';

class GeoPositionSearchForWeatherRepository {
  final String _apiKey = 'IudhJx5rUiBJAECUtkWBxs6ep8FW1uU1';
  final String _baseUrlGeoPositionSearchForWeather =
      'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search';

  Future<GeoPositionSearchForWeatherModel> fetchLocalizedName({
    required double lat,
    required double lng,
  }) async {
    await Future.delayed(Duration(seconds: 1));
    return GeoPositionSearchForWeatherModel(localizedName: 'Lviv');

    debugPrint('fetchLocalizedName called with lat: $lat, lng: $lng');

    final String requestUrl = '$_baseUrlGeoPositionSearchForWeather?'
        'apikey=$_apiKey&q=$lat%2C$lng';

    debugPrint('Sending request to AccuWeather API: $requestUrl');

    final response = await http.get(Uri.parse(requestUrl));

    debugPrint('Response status: ${response.statusCode}');
    // debugPrint('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);

      // debugPrint('Response from AccuWeather: $data');

      final localizedName = data;

      debugPrint('Localized name extracted: $localizedName');

      return GeoPositionSearchForWeatherModel.fromJson(localizedName);
    } else {
      throw Exception('Failed to load localized name');
    }
  }
}
