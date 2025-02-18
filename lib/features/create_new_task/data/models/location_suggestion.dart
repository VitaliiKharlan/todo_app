import 'package:json_annotation/json_annotation.dart';

part 'location_suggestion.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocationSuggestion {
  LocationSuggestion({
    required this.description,
    required this.placeId,
  });

  final String description;
  final String placeId;

  factory LocationSuggestion.fromJson(Map<String, dynamic> json) =>
      _$LocationSuggestionFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSuggestionToJson(this);

  @override
  String toString() {
    return 'LocalWeatherSearch{'
        'name: $description, '
        'lat: $placeId, '
        '}';
  }
}
