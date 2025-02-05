part of 'home_bloc.dart';

// @immutable
sealed class HomeEvent {}

class HomeLoadEvent extends HomeEvent {}

class HomeLoadedEvent extends HomeEvent {}