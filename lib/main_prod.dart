import 'package:get_it/get_it.dart';

import 'package:todo_app/app.dart';
import 'package:todo_app/features/task_details/data/repositories/weather_repository.dart';
import 'package:todo_app/features/task_details/data/repositories/weather_repository_impl.dart';

final getIt = GetIt.instance;

Future<void> setupLocator() async {
  getIt.registerLazySingleton<WeatherRepository>(
      () => ImplWeatherRepository());
}

void main() async {
  await setupLocator();
  appRunner();
}
