import 'package:json_annotation/json_annotation.dart';

part 'location_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LocationDetails {
  LocationDetails();

// factory LocationDetails.fromJson(Map<String, dynamic> json) =>
//     _$LocationDetailsFromJson(json);
//
// Map<String, dynamic> toJson() => _$LocationDetailsToJson(this);
//
// @override
// String toString() {
//   return 'LocationDetails{'
//       '}';
// }
}
