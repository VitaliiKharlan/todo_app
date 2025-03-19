// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_city_search.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherCitySearchModel _$WeatherCitySearchModelFromJson(
        Map<String, dynamic> json) =>
    WeatherCitySearchModel(
      localizedName: json['LocalizedName'] as String,
      countryName: WeatherCitySearchModel._countryFromJson(
          json['Country'] as Map<String, dynamic>?),
      locationCityKey: json['Key'] as String,
    );

Map<String, dynamic> _$WeatherCitySearchModelToJson(
        WeatherCitySearchModel instance) =>
    <String, dynamic>{
      'LocalizedName': instance.localizedName,
      'Country': instance.countryName,
      'Key': instance.locationCityKey,
    };
