import 'package:flutter/material.dart';

import 'dart:convert';

import 'package:todo_app/features/task_details/data/data.dart';

class MockWeatherRepository implements WeatherRepository {
  @override
  Future<WeatherCitySearchModel> getCitySearch(
      {required double lat, required double lng}) async {
    await Future.delayed(Duration(milliseconds: 500));
    String mockData = '''
[
  {
    "Version": 1,
    "Key": "324505",
    "Type": "City",
    "Rank": 20,
    "LocalizedName": "Kyiv",
    "EnglishName": "Kyiv",
    "PrimaryPostalCode": "",
    "Region": {
      "ID": "EUR",
      "LocalizedName": "Europe",
      "EnglishName": "Europe"
    },
    "Country": {
      "ID": "UA",
      "LocalizedName": "Ukraine",
      "EnglishName": "Ukraine"
    },
    "AdministrativeArea": {
      "ID": "30",
      "LocalizedName": "Kyiv",
      "EnglishName": "Kyiv",
      "Level": 1,
      "LocalizedType": "City",
      "EnglishType": "City",
      "CountryID": "UA"
    },
    "TimeZone": {
      "Code": "EET",
      "Name": "Europe/Kiev",
      "GmtOffset": 2,
      "IsDaylightSaving": false,
      "NextOffsetChange": "2025-03-30T01:00:00Z"
    },
    "GeoPosition": {
      "Latitude": 50.45,
      "Longitude": 30.524,
      "Elevation": {
        "Metric": {
          "Value": 136,
          "Unit": "m",
          "UnitType": 5
        },
        "Imperial": {
          "Value": 446,
          "Unit": "ft",
          "UnitType": 0
        }
      }
    },
    "IsAlias": false,
    "SupplementalAdminAreas": [],
    "DataSets": [
      "AirQualityCurrentConditions",
      "AirQualityForecasts",
      "Alerts",
      "DailyPollenForecast",
      "ForecastConfidence",
      "FutureRadar",
      "MinuteCast"
    ]
  }
]
''';

    final data = jsonDecode(mockData)[0];
    final weatherLocalizedName = data['LocalizedName'];
    final weatherCountryLocalizedName = data['Country']['LocalizedName'];
    final weatherCityKey = data['Key'];

    return WeatherCitySearchModel(
      localizedName: weatherLocalizedName,
      countryName: weatherCountryLocalizedName,
      locationCityKey: weatherCityKey,
    );
  }

  @override
  Future<WeatherCurrentConditionsModel> getCurrentConditions(
      {required double lat,
      required double lng,
      required int locationCityKey}) async {
    await Future.delayed(Duration(milliseconds: 500));
    // final cityId = await fetchLocationCityKey(lat: lat, lng: lng);
    String mockData = '''
[
  {
    "LocalObservationDateTime": "2025-03-16T22:46:00+02:00",
    "EpochTime": 1742157960,
    "WeatherText": "Clear",
    "WeatherIcon": 10,
    "HasPrecipitation": false,
    "PrecipitationType": null,
    "IsDayTime": false,
    "Temperature": {
      "Metric": {
        "Value": 5.2,
        "Unit": "C",
        "UnitType": 17
      },
      "Imperial": {
        "Value": 33,
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

    final data = jsonDecode(mockData)[0];
    final weatherCurrentDescription = data['WeatherText'];
    final weatherCurrentIcon = data['WeatherIcon'];
    final weatherCurrentTemperature = Temperature(
      metric: Metric(
        value: data['Temperature']['Metric']['Value'].round().toDouble(),
      ),
    );

    final String dateTimeString = data['LocalObservationDateTime'];
    final DateTime weatherCurrentLocalObservationDateTime =
        DateTime.parse(dateTimeString).toLocal();

    return WeatherCurrentConditionsModel(
      weatherCurrentDescription: weatherCurrentDescription,
      weatherCurrentIcon: weatherCurrentIcon,
      weatherCurrentTemperature: weatherCurrentTemperature,
      weatherCurrentLocalObservationDateTime:
          weatherCurrentLocalObservationDateTime,
    );
  }
}
