import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:todo_app/features/create_new_task/data/models/location_suggestion.dart';
import 'package:uuid/uuid.dart';

class LocationSearchAutocompleteRepository {
  final String _apiKey = 'AIzaSyAeEjvu9tDBWwAtpZYzgtTQzBhkCMQmUZc';
  final String _baseUrl =
      'https://maps.googleapis.com/maps/api/place/autocomplete/json';
  var uuid = Uuid();

  Future<List<dynamic>> fetchLocationSuggestions(String input) async {
    final String token = uuid.v4();

    try {
      final String requestUrl =
          '$_baseUrl?input=$input&key=$_apiKey&sessiontoken=$token';
      final response = await http.get(Uri.parse(requestUrl));
      final data = json.decode(response.body);

      if (kDebugMode) {
        print(data);
      }

      if (response.statusCode == 200) {
        final predictions = data['predictions'] as List<dynamic>? ?? [];
        return predictions.map((json) => LocationSuggestion.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load locations');
      }
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
