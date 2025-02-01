part of 'settings_bloc.dart';

// @immutable
sealed class SettingsState {}

final class SettingsInitial extends SettingsState {}



final class SettingsInitialState extends SettingsState {}

class SettingsLoadingState extends SettingsState {}

class SettingsLoadedState extends SettingsState {
  SettingsLoadedState(
      this.tasks,
      );

  final List<Task> tasks;
}

class SettingsLoadingFailureState extends SettingsState {
  SettingsLoadingFailureState(
      this.exception,
      );

  final Object? exception;
}