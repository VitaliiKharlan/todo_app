part of 'location_search_bloc.dart';

@immutable
sealed class LocationSearchEvent {}

class LocationSearchTextChangeEvent extends LocationSearchEvent {
  LocationSearchTextChangeEvent(
    this.query,
  );

  final String query;
}

class LocationSearchSelectEvent extends LocationSearchEvent {
  LocationSearchSelectEvent(
    this.location,
  );

  final List<LocationDetailsModel> location;
}
