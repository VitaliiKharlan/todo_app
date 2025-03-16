import 'package:todo_app/main_prod.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/features/task_details/data/repositories/geo_position_search_for_weather_repository.dart';



Future<void> setupLocator() async {
  getIt.registerLazySingleton<GeoPositionSearchForWeatherRepository>(
      () => MockGeoPositionSearchForWeatherRepository());
}

void main() async {
  setupLocator();
  appRunner();
}
