import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_app/models/air_quality.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';

import '../resources/api_repository.dart';
import '../utils/current_location.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiRepository apiRepository = ApiRepository();

  WeatherBloc() : super(WeatherState()) {
    on<WeatherFetched>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
      WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    Position position = await CurrentLocation.getCurrentLocation();
    double lat = position.latitude;
    double lon = position.longitude;
    final Forecast forecast = await apiRepository.fetchForecastOneCall(
        lat, lon);
    final AirQuality airQuality = await apiRepository.fetchAirQuality(
        lat, lon);

    emit(WeatherLoaded(
        forecast: forecast, airQuality: airQuality));
  }
}
