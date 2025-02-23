import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/create_new_task/data/models/location_search_autocomplete.dart';

class PlaceDetailsRepository {
  final String _apiKey = 'AIzaSyAeEjvu9tDBWwAtpZYzgtTQzBhkCMQmUZc';
  final String _baseUrlLocationSearchAutocomplete =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  final String _baseUrlLocationDetails =
      'https://maps.googleapis.com/maps/api/place/details/json';

  var uuid = Uuid();

  Future<List<LocationSearchAutocompleteModel>> _fetchLocationSuggestions(
      String input) async {
    final String token = uuid.v4();

    try {
      final String requestUrl = '$_baseUrlLocationSearchAutocomplete?'
          'input=$input&key=$_apiKey&sessiontoken=$token';
      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);

      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        final predictions = data['predictions'] as List<dynamic>? ?? [];

        return predictions
            .map((json) => LocationSearchAutocompleteModel.fromJson(json))
            .toList();
      } else {
        throw Exception('Failed to load locations');
      }
      // } catch (e, s) {
      //   debugPrint(e.toString());
      //   debugPrint(s.toString());
      //   return [];
      // }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }

  Future<LocationDetailsModel> _fetchLocationLatLng(String placeId) async {
    try {
      final String requestUrl = '$_baseUrlLocationDetails?'
          'place_id=$placeId&key=$_apiKey';

      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);

      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        final location = data['result']['geometry']['location'];

        return LocationDetailsModel.fromJson(location);
      } else {
        throw Exception('Failed to load locations');
      }
      // } catch (e, s) {
      //   debugPrint(e.toString());
      //   debugPrint(s.toString());
      //   rethrow;
      // }
    } catch (e) {
      debugPrint(e.toString());
      rethrow;
    }
  }

  Future<List<LocationDetailsModel>> getPlaceDetails(String input) async {
    final suggestions = await _fetchLocationSuggestions(input);

    if (suggestions.isEmpty) return [];

    final places = await Future.wait(suggestions.map(
      (locationObject) async {
        final locationDetails =
            await _fetchLocationLatLng(locationObject.placeId);
        return LocationDetailsModel(
            description: locationObject.description,
            lat: locationDetails.lat,
            lng: locationDetails.lng);
      },
    ));

    return places;
  }
}
