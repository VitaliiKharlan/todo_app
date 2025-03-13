import 'package:json_annotation/json_annotation.dart';

part 'geo_position_search_for_weather.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class GeoPositionSearchForWeatherModel {
  GeoPositionSearchForWeatherModel({
    required this.localizedName,
  });

  @JsonKey(name: 'LocalizedName')
  final String localizedName;

  factory GeoPositionSearchForWeatherModel.fromJson(Map<String, dynamic> json) {
    return _$GeoPositionSearchForWeatherModelFromJson(json);
  }

  Map<String, dynamic> toJson() =>
      _$GeoPositionSearchForWeatherModelToJson(this);

  @override
  String toString() {
    return 'GeoPositionSearchForWeatherModel {'
        'name: $localizedName, '
        '}';
  }
}
