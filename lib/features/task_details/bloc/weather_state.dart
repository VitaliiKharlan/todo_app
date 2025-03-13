part of 'weather_bloc.dart';

@immutable
sealed class WeatherState extends Equatable {}

final class WeatherInitialState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherLoadingState extends WeatherState {
  @override
  List<Object?> get props => [];
}

class WeatherSelectedState extends WeatherState {
  final String localizedName;
  final int locationCityKey;

  WeatherSelectedState(
    this.localizedName,
    this.locationCityKey,
  );

  @override
  List<Object> get props => [localizedName];
}

class WeatherSelectedFailureState extends WeatherState {
  WeatherSelectedFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
