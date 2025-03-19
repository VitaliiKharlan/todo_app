part of 'weather_bloc.dart';

@immutable
sealed class WeatherEvent {}

class WeatherSelectEvent extends WeatherEvent {
  WeatherSelectEvent(
    this.locationDetailsModel,
    // this.geoPositionSearchForWeatherModel,
    this.weatherCurrentConditionsModel,
  );

  final LocationDetailsModel locationDetailsModel;
  // final GeoPositionSearchForWeatherModel geoPositionSearchForWeatherModel;
  final WeatherCurrentConditionsModel weatherCurrentConditionsModel;
}
