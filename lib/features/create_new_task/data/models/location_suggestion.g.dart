// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_suggestion.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationSuggestion _$LocationSuggestionFromJson(Map<String, dynamic> json) =>
    LocationSuggestion(
      description: json['description'] as String,
      placeId: json['place_id'] as String,
    );

Map<String, dynamic> _$LocationSuggestionToJson(LocationSuggestion instance) =>
    <String, dynamic>{
      'description': instance.description,
      'place_id': instance.placeId,
    };
