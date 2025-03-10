part of 'location_search_bloc.dart';

@immutable
sealed class LocationSearchState extends Equatable {}

final class LocationSearchInitialState extends LocationSearchState {
  @override
  List<Object?> get props => [];
}

class LocationSearchLoadingState extends LocationSearchState {
  @override
  List<Object?> get props => [];
}

class LocationSearchLoadedState extends LocationSearchState {
  LocationSearchLoadedState(
    this.suggestions,
  );

  final List<LocationDetailsModel> suggestions;

  @override
  List<Object?> get props => [suggestions];
}

class LocationSearchFailureState extends LocationSearchState {
  LocationSearchFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}

class LocationSelectedState extends LocationSearchState {
  final String localizedName;
  LocationSelectedState(this.localizedName);

  @override
  List<Object> get props => [localizedName];
}

class LocationSelectedFailureState extends LocationSearchState {
  LocationSelectedFailureState(
      this.exception,
      );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}