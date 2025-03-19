// import 'package:flutter/material.dart';
//
// import 'dart:convert';
// import 'package:http/http.dart' as http;

import 'package:todo_app/features/task_details/data/data.dart';

abstract class WeatherRepository {
  Future<WeatherCitySearchModel> getCitySearch({
    required double lat,
    required double lng,
  });

  Future<WeatherCurrentConditionsModel> getCurrentConditions({
    required int locationCityKey,
  });
}
