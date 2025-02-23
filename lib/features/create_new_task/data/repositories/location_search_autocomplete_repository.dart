import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
import 'package:todo_app/features/create_new_task/data/models/location_search_autocomplete.dart';
import 'package:uuid/uuid.dart';

// class LocationSearchAutocompleteRepository {
//   final String _apiKey = 'AIzaSyAeEjvu9tDBWwAtpZYzgtTQzBhkCMQmUZc';
//   final String _baseUrl =
//       'https://maps.googleapis.com/maps/api/place/autocomplete/json';
//   var uuid = Uuid();
//
//   Future<List<dynamic>> fetchLocationSuggestions(String input) async {
//     final String token = uuid.v4();
//
//     try {
//       final String requestUrl =
//           '$_baseUrl?input=$input&key=$_apiKey&sessiontoken=$token';
//       final response = await http.get(Uri.parse(requestUrl));
//       final data = json.decode(response.body);
//
//       if (kDebugMode) {
//         print(data);
//       }
//
//       if (response.statusCode == 200) {
//         final predictions = data['predictions'] as List<dynamic>? ?? [];
//
//         final placeId = data['placeId'] as List<dynamic>? ?? [];
//
//         print(placeId);
//         print('AAAAAAAAAAAAA');
//         print(predictions);
//
//         return predictions
//             .map((json) => LocationSearchAutocompleteModel.fromJson(json))
//             .toList();
//       } else {
//         throw Exception('Failed to load locations');
//       }
//     } catch (e,s) {
//       debugPrint(e.toString());
//       debugPrint(s.toString());
//       return [];
//     }
//   }
// }

class PlaceDetailsRepository {
  final String _apiKey = 'AIzaSyAeEjvu9tDBWwAtpZYzgtTQzBhkCMQmUZc';
  final String _baseUrlLSA =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  final String _baseUrlLD =
      'https://maps.googleapis.com/maps/api/place/details/json';

  // final String _placeId = 'ChIJBUVa4U7P1EAR_kYBF9IxSXY';
  var uuid = Uuid();

  Future<List<LocationSearchAutocompleteModel>> _fetchLocationSuggestions(
      String input) async {
    final String token = uuid.v4();

    try {
      final String requestUrl =
          '$_baseUrlLSA?input=$input&key=$_apiKey&sessiontoken=$token';
      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);

      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        final predictions = data['predictions'] as List<dynamic>? ?? [];

        // final placeId = data['placeId'] as List<dynamic>? ?? [];

        print('AAAAAAAAAA');
        print(predictions);

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
      final String requestUrl = '$_baseUrlLD?place_id=$placeId&key=$_apiKey';

      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);

      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        final location = data['result']['geometry']['location'];

        print('BBBBBBBBBB');
        print(location);

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

    // if (suggestions.isEmpty) return [];

    // final placeId = suggestions.first.placeId;

    return places;
  }
}
