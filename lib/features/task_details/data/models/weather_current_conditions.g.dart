// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_current_conditions.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherCurrentConditionsModel _$WeatherCurrentConditionsModelFromJson(
        Map<String, dynamic> json) =>
    WeatherCurrentConditionsModel(
      weatherCurrentDescription: json['WeatherText'] as String,
      weatherCurrentIcon: (json['WeatherIcon'] as num).toInt(),
      weatherCurrentTemperature:
          Temperature.fromJson(json['Temperature'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$WeatherCurrentConditionsModelToJson(
        WeatherCurrentConditionsModel instance) =>
    <String, dynamic>{
      'WeatherText': instance.weatherCurrentDescription,
      'WeatherIcon': instance.weatherCurrentIcon,
      'Temperature': instance.weatherCurrentTemperature.toJson(),
    };

Temperature _$TemperatureFromJson(Map<String, dynamic> json) => Temperature(
      metric: Metric.fromJson(json['Metric'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$TemperatureToJson(Temperature instance) =>
    <String, dynamic>{
      'Metric': instance.metric,
    };

Metric _$MetricFromJson(Map<String, dynamic> json) => Metric(
      value: (json['Value'] as num).toDouble(),
    );

Map<String, dynamic> _$MetricToJson(Metric instance) => <String, dynamic>{
      'Value': instance.value,
    };
