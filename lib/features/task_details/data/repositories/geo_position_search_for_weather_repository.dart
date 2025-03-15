import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:todo_app/features/task_details/data/models/geo_position_search_for_weather.dart';

// https://api.accuweather.com/currentconditions/v1/{locationKey}?apikey={yourApiKey}

class GeoPositionSearchForWeatherRepository {
  final String _apiKey = 'IudhJx5rUiBJAECUtkWBxs6ep8FW1uU1';
  final String _baseUrlGeoPositionSearchForWeather =
      'http://dataservice.accuweather.com/locations/v1/cities/geoposition/search';

  Future<GeoPositionSearchForWeatherModel> fetchLocalizedName({
    required double lat,
    required double lng,
  }) async {
    // // mocking a database call
    // //
    // await Future.delayed(Duration(seconds: 1));
    // return GeoPositionSearchForWeatherModel(
    //   localizedName: 'Kyiv',
    //   countryName: 'Ukraine',
    //   locationCityKey: '324505',
    // );
    // //

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
  Future<GeoPositionSearchForWeatherModel> fetchCountryName({
    required double lat,
    required double lng,
  }) async {
    // // mocking a database call
    // //
    // await Future.delayed(Duration(seconds: 1));
    // return GeoPositionSearchForWeatherModel(
    //   localizedName: 'Lviv',
    //   countryName: 'Ukraine',
    //   locationCityKey: '324505',
    // );
    // //

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


  Future<GeoPositionSearchForWeatherModel> fetchLocationCityKey({
    required double lat,
    required double lng,
  }) async {
    // // mocking a database call
    // //
    // await Future.delayed(Duration(seconds: 1));
    // return GeoPositionSearchForWeatherModel(
    //   localizedName: 'Poltava',
    //   countryName: 'Ukraine',
    //   locationCityKey: 324505,
    // );
    // //

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
}

//   // alternative way
//   //
//   Future<GeoPositionSearchForWeatherModel> _fetchData({
//     required double lat,
//     required double lng,
//   }) async {
//     // // mocking a database call
//     // //
//     // await Future.delayed(Duration(seconds: 1));
//     // return GeoPositionSearchForWeatherModel(
//     //   localizedName: 'Kyiv',
//     //   countryName: 'Ukraine',
//     //   locationCityKey: '324505',
//     // );
//     // //
//
//     final String requestUrl = '$_baseUrlGeoPositionSearchForWeather?'
//         'apikey=$_apiKey&q=$lat%2C$lng';
//
//     debugPrint('Fetching data from: $requestUrl');
//
//     final response = await http.get(Uri.parse(requestUrl));
//
//     if (response.statusCode == 200) {
//       return GeoPositionSearchForWeatherModel.fromJson(
//           jsonDecode(response.body));
//     } else {
//       throw Exception('Failed to fetch data');
//     }
//   }
//
//   Future<String> fetchLocalizedName(
//       {required double lat, required double lng}) async {
//     final data = await _fetchData(lat: lat, lng: lng);
//     debugPrint('Localized name: ${data.localizedName}');
//     return data.localizedName;
//   }
//
//   Future<String> fetchCountryName(
//       {required double lat, required double lng}) async {
//     final data = await _fetchData(lat: lat, lng: lng);
//     debugPrint('Country name: ${data.countryName}');
//     return data.countryName;
//   }
//
//   Future<String> fetchLocationCityKey(
//       {required double lat, required double lng}) async {
//     final data = await _fetchData(lat: lat, lng: lng);
//     debugPrint('Location city key: ${data.locationCityKey}');
//     return data.locationCityKey;
//   }
// }
// //


