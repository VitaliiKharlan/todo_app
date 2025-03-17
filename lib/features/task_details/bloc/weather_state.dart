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
  final String countryName;
  final int locationCityKey;
  final String weatherCurrentDescription;
  final int weatherCurrentIcon;
  final double weatherCurrentTemperature;

  WeatherSelectedState(
    this.localizedName,
    this.countryName,
    this.locationCityKey,
    this.weatherCurrentDescription,
    this.weatherCurrentIcon,
    this.weatherCurrentTemperature,
  );

  @override
  List<Object> get props => [
        localizedName,
        countryName,
        locationCityKey,
        weatherCurrentDescription,
        weatherCurrentIcon,
        weatherCurrentTemperature,
      ];
}

class WeatherSelectedFailureState extends WeatherState {
  WeatherSelectedFailureState(
    this.exception,
  );

  final Object? exception;

  @override
  List<Object?> get props => [exception];
}
