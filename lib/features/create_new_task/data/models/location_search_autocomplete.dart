import 'package:json_annotation/json_annotation.dart';

part 'location_search_autocomplete.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocationSearchAutocompleteModel {
  LocationSearchAutocompleteModel({
    required this.description,
    required this.placeId,
  });

  final String description;
  final String placeId;

  factory LocationSearchAutocompleteModel.fromJson(Map<String, dynamic> json) =>
      _$LocationSearchAutocompleteModelFromJson(json);

  Map<String, dynamic> toJson() => _$LocationSearchAutocompleteModelToJson(this);

  @override
  String toString() {
    return 'LocationSearchAutocompleteModel{'
        'name: $description, '
        'lat: $placeId, '
        '}';
  }
}
