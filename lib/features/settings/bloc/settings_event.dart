part of 'settings_bloc.dart';

// @immutable
sealed class SettingsEvent {}

class SettingsLoadEvent extends SettingsEvent {}

class SettingsLoadedEvent extends SettingsEvent {}