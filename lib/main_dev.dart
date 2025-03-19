import 'package:todo_app/app.dart';
import 'package:todo_app/main_prod.dart';
import 'package:todo_app/features/task_details/data/repositories/weather_repository.dart';
import 'package:todo_app/features/task_details/data/repositories/weather_repository_mock.dart';

Future<void> setupLocator() async {
  getIt.registerLazySingleton<WeatherRepository>(() => MockWeatherRepository());
}

void main() async {
  setupLocator();
  appRunner();
}
