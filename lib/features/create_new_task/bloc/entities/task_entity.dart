import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

import 'package:uuid/uuid.dart';

import 'package:todo_app/ui/theme/app_svg_images.dart';

enum TaskType {
  work,
  personal,
  shopping,
  sport,
  urgent,
}

extension TaskTypeExtension on TaskType {
  String get name {
    switch (this) {
      case TaskType.work:
        return 'work';
      case TaskType.personal:
        return 'personal';
      case TaskType.shopping:
        return 'shopping';
      case TaskType.sport:
        return 'sport';
      case TaskType.urgent:
        return 'urgent';
    }
  }

  Color get color {
    switch (this) {
      case TaskType.work:
        return Colors.blue;
      case TaskType.personal:
        return Colors.green;
      case TaskType.shopping:
        return Colors.orange;
      case TaskType.sport:
        return Colors.yellow;
      case TaskType.urgent:
        return Colors.red;
    }
  }

  String get iconPath {
    switch (this) {
      case TaskType.work:
        return AppSvgImages.iconTaskTypeWork;
      case TaskType.personal:
        return AppSvgImages.iconTaskTypePersonal;
      case TaskType.shopping:
        return AppSvgImages.iconTaskTypeShopping;
      case TaskType.sport:
        return AppSvgImages.iconTaskTypeSport;
      case TaskType.urgent:
        return AppSvgImages.iconTaskTypeUrgent;
    }
  }

  static TaskType fromString(String type) {
    return TaskType.values.firstWhere((e) => e.name == type);
  }
}

class Task extends Equatable {
  Task({
    required this.taskTitle,
    this.taskDescription,
    this.taskType,
    DateTime? createdAt,
    this.taskDeadline,
  })  : taskCreatedAt = createdAt ?? DateTime.now(),
        taskId = Uuid().v4();

  final String taskId;
  final String taskTitle;
  final String? taskDescription;
  final TaskType? taskType;
  final DateTime? taskDeadline;
  final DateTime taskCreatedAt;

  // late final DateTime taskCreatedAt = DateTime.now();

  double get progress {
    if (taskDeadline == null) return 100;
    double progress = TaskCurrentTimeProgressIndicator.calculateProgress(
        taskCreatedAt, taskDeadline!);
    return progress;
  }

  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskTitle': taskTitle,
      'taskDescription': taskDescription,
      'taskType': taskType?.name,
      'taskCreatedAt': taskCreatedAt.toIso8601String(),
      'taskDeadline': taskDeadline?.toIso8601String(),

    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      taskTitle: map['taskTitle'],
      taskDescription: map['taskDescription'],
      // taskType: TaskType.work,
      taskType: map['taskType'] != null
          ? TaskTypeExtension.fromString(map['taskType'])
          : null,
      createdAt: map['taskCreatedAt'] != null
          ? DateTime.parse(map['taskCreatedAt'])
          : null,
      taskDeadline: map['taskDeadline'] != null
          ? DateTime.parse(map['taskDeadline'])
          : null,

    );
  }

  @override
  List<Object?> get props => [
        taskTitle,
        taskDescription,
        taskDeadline,
        taskType,
      ];

  @override
  String toString() {
    return 'Task(title: $taskTitle)';
  }
}

class TaskCurrentTimeProgressIndicator {
  static double calculateProgress(
      DateTime taskCreatedAt, DateTime taskDeadline) {
    final DateTime now = DateTime.now();

    if (now.isBefore(taskCreatedAt)) return 0.0;
    if (now.isAfter(taskDeadline)) return 100.0;

    final Duration totalDuration = taskDeadline.difference(taskCreatedAt);
    final Duration elapsedDuration = now.difference(taskCreatedAt);

    double progress =
        (elapsedDuration.inMilliseconds / totalDuration.inMilliseconds) * 100;

    return double.parse(progress.toStringAsFixed(2));
  }
}
