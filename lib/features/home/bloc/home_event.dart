part of 'home_bloc.dart';

// @immutable
sealed class HomeEvent {}

class LoadHomeEvent extends HomeEvent {}

class LoadedHomeEvent extends HomeEvent {}