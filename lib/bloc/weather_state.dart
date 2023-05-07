import 'package:equatable/equatable.dart';

import '../models/forecast.dart';
import '../models/forecast_daily.dart';

enum WeatherStatus { initial, loading, loaded, error }

class WeatherState extends Equatable {
  final Forecast? forecast;
  final ForecastDaily? forecastDaily;

  WeatherState({this.forecastDaily, this.forecast});

  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  WeatherLoaded({super.forecast, super.forecastDaily});
}

class WeatherError extends WeatherState {
  final String? message;

  WeatherError(this.message);
}
