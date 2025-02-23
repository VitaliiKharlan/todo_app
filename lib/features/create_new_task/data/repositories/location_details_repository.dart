// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:http/http.dart' as http;
// import 'package:todo_app/features/create_new_task/data/models/location_details.dart';
//
// class LocationDetailsRepository {
//   final String _placeId = 'ChIJBUVa4U7P1EAR_kYBF9IxSXY';
//   final String _apiKey = 'AIzaSyAeEjvu9tDBWwAtpZYzgtTQzBhkCMQmUZc';
//   final String _baseUrl =
//       'https://maps.googleapis.com/maps/api/place/details/json';
//
//   Future<LocationDetailsModel> fetchLocationLatLng() async {
//     try {
//       final String requestUrl = '$_baseUrl?place_id=$_placeId&key=$_apiKey';
//
//       final response = await http.get(Uri.parse(requestUrl));
//       final data = json.decode(response.body);
//
//       if (kDebugMode) {
//         print(data);
//       }
//
//       if (response.statusCode == 200) {
//         final location = data['result']['geometry']['location'];
//
//         print('BBBBBB');
//         print(location);
//
//         return LocationDetailsModel.fromJson(location);
//       } else {
//         throw Exception('Failed to load locations');
//       }
//       // } catch (e, s) {
//       //   debugPrint(e.toString());
//       //   debugPrint(s.toString());
//       //   rethrow;
//       // }
//     } catch (e) {
//       debugPrint(e.toString());
//       rethrow;
//     }
//   }
// }
