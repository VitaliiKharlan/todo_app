import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:get_it/get_it.dart';
import 'package:todo_app/features/task_details/data/repositories/geo_position_search_for_weather_repository.dart';

import 'package:todo_app/todo_app.dart';

import 'main_prod.dart';

void appRunner() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  await initNotifications();

  await setupLocator();

  if (getIt.isRegistered<GeoPositionSearchForWeatherRepository>()) {
    debugPrint('GeoPositionSearchForWeatherRepository is registered');
  } else {
    debugPrint('GeoPositionSearchForWeatherRepository is NOT registered');
  }

  await _showNotification();

  runApp(const TodoApp());
}

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> initNotifications() async {
  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('@mipmap/ic_launcher');

  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: DarwinInitializationSettings());

  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> _showNotification() async {
  const androidDetails = AndroidNotificationDetails(
    'task_channel',
    'Task Notifications',
    channelDescription: 'Task reminders',
    importance: Importance.high,
    priority: Priority.high,
  );

  const platformDetails = NotificationDetails(android: androidDetails);

  debugPrint('Scheduling notification');

  await flutterLocalNotificationsPlugin.show(
    0, // unique identifier
    'Hello!',
    'This notification appeared when the application todo_app was launched.',
    platformDetails,
  );
}
