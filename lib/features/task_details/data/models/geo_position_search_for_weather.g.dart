// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_position_search_for_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoPositionSearchForWeatherModel _$GeoPositionSearchForWeatherModelFromJson(
        Map<String, dynamic> json) =>
    GeoPositionSearchForWeatherModel(
      localizedName: json['LocalizedName'] as String,
      locationCityKey: json['Key'] as String,
    );

Map<String, dynamic> _$GeoPositionSearchForWeatherModelToJson(
        GeoPositionSearchForWeatherModel instance) =>
    <String, dynamic>{
      'LocalizedName': instance.localizedName,
      'Key': instance.locationCityKey,
    };
