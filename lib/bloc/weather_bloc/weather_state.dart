import 'package:equatable/equatable.dart';
import 'package:weather_app/models/location.dart';

import '../../models/air_quality.dart';
import '../../models/forecast.dart';
import '../../models/forecast_daily.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final Forecast? forecast;
  final ForecastDaily? forecastDaily;
  final AirQuality? airQuality;
  final MyLocation? myLocation;
  final int? checkDegree;
  final int? checkDistance;
  final int? checkSpeed;
  final bool? isFavorite;

  const WeatherState(
      {this.forecastDaily,
      this.forecast,
      this.airQuality,
      this.myLocation,
      this.checkDegree,
      this.checkDistance,
      this.checkSpeed,
      this.isFavorite});

  @override
// TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  const WeatherLoaded(
      {super.forecast,
      super.forecastDaily,
      super.airQuality,
      super.myLocation,
      super.checkDistance,
      super.checkDegree,
      super.checkSpeed,
      super.isFavorite});
}

class WeatherError extends WeatherState {
  final String? message;

  const WeatherError(this.message);
}
