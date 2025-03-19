import 'package:json_annotation/json_annotation.dart';

part 'location_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocationDetailsModel {
  LocationDetailsModel({
    required this.description,
    required this.lat,
    required this.lng,
  });

  final String? description;
  final double? lat;
  final double? lng;

  factory LocationDetailsModel.fromJson(Map<String, dynamic> json) {
    return _$LocationDetailsModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$LocationDetailsModelToJson(this);

  @override
  String toString() {
    String formattedLat = lat != null ? lat!.toStringAsFixed(5) : 'null';
    String formattedLng = lng != null ? lng!.toStringAsFixed(5) : 'null';

    return '$description, \nlat: $formattedLat, lng: $formattedLng';

    //
    // stupid output of data
    //
    // return 'LocationDetailsModel {'
    //     'description: $description, '
    //     'lat: $lat, '
    //     'lng: $lng, '
    //     '}';
    //
  }
}
