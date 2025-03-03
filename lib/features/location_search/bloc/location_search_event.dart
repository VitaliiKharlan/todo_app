part of 'location_search_bloc.dart';

@immutable
sealed class LocationSearchEvent {}

class LocationSearchTextChangeEvent extends LocationSearchEvent {
  LocationSearchTextChangeEvent();
}

class LocationSearchSelectEvent extends LocationSearchEvent {
  LocationSearchSelectEvent();
}
