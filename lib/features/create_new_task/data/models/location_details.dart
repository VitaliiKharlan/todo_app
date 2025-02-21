import 'package:json_annotation/json_annotation.dart';

part 'location_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocationDetailsModel {
  LocationDetailsModel({
    required this.lat,
    required this.lng,
  });

  final double lat;
  final double lng;

  factory LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$LocationDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationDetailsModelToJson(this);

  @override
  String toString() {
    return 'LocationDetailsModel{'
        'lat: $lat, '
        'lng: $lng,'
        '}';
  }
}
