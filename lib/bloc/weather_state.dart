import 'package:equatable/equatable.dart';

import '../models/air_quality.dart';
import '../models/forecast.dart';
import '../models/forecast_daily.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final Forecast? forecast;
  final ForecastDaily? forecastDaily;
  final AirQuality? airQuality;

  WeatherState({this.forecastDaily, this.forecast, this.airQuality});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  WeatherLoaded({super.forecast, super.forecastDaily, super.airQuality});
}

class WeatherError extends WeatherState {
  final String? message;

  WeatherError(this.message);
}
