


import 'package:todo_app/features/task_details/data/repositories/geo_position_search_for_weather_repository.dart';

import 'app.dart';
import 'main_prod.dart';

Future<void> setupLocator() async {
  getIt.registerLazySingleton<GeoPositionSearchForWeatherRepository>(
          () => MockGeoPositionSearchForWeatherRepository());
}

void main() async {
  setupLocator();
  appRunner();
}
