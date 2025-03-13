import 'package:json_annotation/json_annotation.dart';

part 'geo_position_search_for_weather.g.dart';

@JsonSerializable(explicitToJson: true)
class GeoPositionSearchForWeatherModel {
  GeoPositionSearchForWeatherModel({
    required this.localizedName,
    required this.locationCityKey,
  });

  @JsonKey(name: 'LocalizedName')
  final String localizedName;

  @JsonKey(name: 'Key')
  final String locationCityKey;

  factory GeoPositionSearchForWeatherModel.fromJson(Map<String, dynamic> json) {
    return _$GeoPositionSearchForWeatherModelFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GeoPositionSearchForWeatherModelToJson(this);

  @override
  String toString() {
    return 'GeoPositionSearchForWeatherModel {'
        'name: $localizedName, '
        'key: $locationCityKey, '
        '}';
  }
}
