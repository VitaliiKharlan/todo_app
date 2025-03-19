part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class WeatherSelectEvent extends WeatherEvent {
  WeatherSelectEvent(
    this.locationDetailsModel,
  );

  final LocationDetailsModel locationDetailsModel;
}
