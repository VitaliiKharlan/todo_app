import 'package:json_annotation/json_annotation.dart';

part 'weather_city_search.g.dart';

@JsonSerializable(explicitToJson: true)
class WeatherCitySearchModel {
  WeatherCitySearchModel({
    required this.localizedName,
    required this.countryName,
    required this.locationCityKey,
  });

  @JsonKey(name: 'LocalizedName')
  final String localizedName;

  @JsonKey(name: 'Country', fromJson: _countryFromJson)
  final String countryName;

  @JsonKey(name: 'Key')
  final String locationCityKey;

  static String _countryFromJson(Map<String, dynamic>? json) {
    return json?['LocalizedName'] ?? 'Unknown';
  }

  factory WeatherCitySearchModel.fromJson(Map<String, dynamic> json) {
    return _$WeatherCitySearchModelFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$WeatherCitySearchModelToJson(this);

  @override
  String toString() {
    return '$localizedName, $countryName, $locationCityKey';
  }
}

