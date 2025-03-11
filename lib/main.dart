import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;

import 'package:todo_app/todo_app.dart';

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

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tz.initializeTimeZones();
  await initNotifications();

  await _showNotification();

  // final repository = GeoPositionSearchForWeatherRepository();
  // final geoData = await repository.fetchLocalizedName();
  // print(geoData.localizedName);

  runApp(const TodoApp());
}
