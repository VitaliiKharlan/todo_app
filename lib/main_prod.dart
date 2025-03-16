import 'package:get_it/get_it.dart';
import 'package:todo_app/app.dart';
import 'package:todo_app/features/task_details/data/repositories/geo_position_search_for_weather_repository.dart';




final getIt = GetIt.instance;



Future<void> setupLocator() async {
  getIt.registerLazySingleton<GeoPositionSearchForWeatherRepository>(
          () => ImplGeoPositionSearchForWeatherRepository());
}

void main() async {
setupLocator();
appRunner();
}
