// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationDetailsModel _$LocationDetailsModelFromJson(
        Map<String, dynamic> json) =>
    LocationDetailsModel(
      description: json['description'] as String?,
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$LocationDetailsModelToJson(
        LocationDetailsModel instance) =>
    <String, dynamic>{
      'description': instance.description,
      'lat': instance.lat,
      'lng': instance.lng,
    };
