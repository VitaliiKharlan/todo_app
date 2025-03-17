import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> scheduleNotification(
      String id, String title, DateTime deadline) async {
    tz.TZDateTime deadlineTZ = tz.TZDateTime.from(deadline, tz.local);
    tz.TZDateTime reminderTime = deadlineTZ.subtract(const Duration(hours: 1));

    const androidDetails = AndroidNotificationDetails(
      'task_channel',
      'Task Notifications',
      channelDescription: 'Task reminders',
      importance: Importance.high,
      priority: Priority.high,
    );

    final now = tz.TZDateTime.now(tz.local);
    if (reminderTime.isBefore(now)) {
      debugPrint("Reminder time is in the past, adjusting...");
      reminderTime = now.add(const Duration(minutes: 1));
    }

    if (deadlineTZ.isBefore(now)) {
      debugPrint("Deadline time is in the past, adjusting...");
      deadlineTZ = now.add(const Duration(minutes: 1));
    }

    const platformDetails = NotificationDetails(android: androidDetails);

    debugPrint('One hour notice before completion '
        '"$title" at $reminderTime');

    await _notificationsPlugin.zonedSchedule(
      id.hashCode,
      'Reminder',
      'Will end in 1 hour: $title',
      reminderTime,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );

    debugPrint('Notification after time ends '
        '"$title" at $deadlineTZ');

    await _notificationsPlugin.zonedSchedule(
      id.hashCode + 1,
      'Task completed',
      'Time is up for: $title',
      deadlineTZ,
      platformDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancelNotification(String taskId) async {
    await _notificationsPlugin.cancel(int.parse(taskId));
  }
}
