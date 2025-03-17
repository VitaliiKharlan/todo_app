import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/services/date_time_converter.dart';

part 'weather_current_conditions.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherCurrentConditionsModel {
  WeatherCurrentConditionsModel({
    required this.weatherCurrentDescription,
    required this.weatherCurrentIcon,
    required this.weatherCurrentTemperature,
    required this.weatherCurrentLocalObservationDateTime,
  });

  @JsonKey(name: 'WeatherText')
  final String weatherCurrentDescription;

  @JsonKey(name: 'WeatherIcon')
  final int weatherCurrentIcon;

  @JsonKey(name: 'Temperature')
  final Temperature weatherCurrentTemperature;

  @JsonKey(name: 'LocalObservationDateTime')
  @DateTimeConverter()
  final DateTime weatherCurrentLocalObservationDateTime;

  factory WeatherCurrentConditionsModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherCurrentConditionsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$WeatherCurrentConditionsModelToJson(this);

  @override
  String toString() {
    return 'WeatherCurrentConditionsModel{weatherCurrentDescription: '
        '$weatherCurrentDescription, '
        'weatherCurrentIcon: $weatherCurrentIcon, '
        'weatherCurrentTemperature: $weatherCurrentTemperature, '
        'weatherCurrentLocalObservationDateTime: $weatherCurrentLocalObservationDateTime}';
  }
}

@JsonSerializable()
class Temperature {
  Temperature({
    required this.metric,
  });

  @JsonKey(name: 'Metric')
  final Metric metric;

  factory Temperature.fromJson(Map<String, dynamic> json) {
    return _$TemperatureFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$TemperatureToJson(this);
  }

  @override
  String toString() {
    return 'Temperature{metric: $metric}';
  }
}

@JsonSerializable()
class Metric {
  Metric({
    required this.value,
  });

  @JsonKey(name: 'Value')
  final double value;

  factory Metric.fromJson(Map<String, dynamic> json) {
    return _$MetricFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$MetricToJson(this);
  }

  @override
  String toString() {
    return 'Metric{value: $value}';
  }
}
