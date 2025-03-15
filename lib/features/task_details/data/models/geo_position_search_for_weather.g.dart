// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'geo_position_search_for_weather.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GeoPositionSearchForWeatherModel _$GeoPositionSearchForWeatherModelFromJson(
        Map<String, dynamic> json) =>
    GeoPositionSearchForWeatherModel(
      localizedName: json['LocalizedName'] as String,
      countryName: GeoPositionSearchForWeatherModel._countryFromJson(
          json['Country'] as Map<String, dynamic>?),
      locationCityKey: json['Key'] as String,
    );

Map<String, dynamic> _$GeoPositionSearchForWeatherModelToJson(
        GeoPositionSearchForWeatherModel instance) =>
    <String, dynamic>{
      'LocalizedName': instance.localizedName,
      'Country': instance.countryName,
      'Key': instance.locationCityKey,
    };
