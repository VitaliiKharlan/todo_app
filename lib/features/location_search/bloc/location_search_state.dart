part of 'location_search_bloc.dart';

@immutable
sealed class LocationSearchState {}

final class LocationSearchInitialState extends LocationSearchState {}

class LocationSearchLoadedState extends LocationSearchState {
  LocationSearchLoadedState();
}

class LocationSearchErrorState extends LocationSearchState {
  LocationSearchErrorState(
    this.exception,
  );

  final Object? exception;
}

