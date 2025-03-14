import 'package:json_annotation/json_annotation.dart';

part 'geo_position_search_for_weather.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoPositionSearchForWeatherModel {
  GeoPositionSearchForWeatherModel({
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

  factory GeoPositionSearchForWeatherModel.fromJson(Map<String, dynamic> json) {
    return _$GeoPositionSearchForWeatherModelFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GeoPositionSearchForWeatherModelToJson(this);

  @override
  String toString() {
    return '$localizedName, $countryName, $locationCityKey';
  }
}

