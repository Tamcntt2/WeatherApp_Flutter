import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_app/models/air_quality.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';

import '../models/forecast_daily.dart';
import '../resources/api/api_repository.dart';
import '../utils/current_location.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiRepository apiRepository = ApiRepository();

  WeatherBloc() : super(WeatherState()) {
    on<WeatherCurrentFetched>(_onFetchWeather);
    on<WeatherLocationFetched>(_onFetchWeatherLocation);
  }

  Future<void> _onFetchWeather(
      WeatherCurrentFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    Position position = await CurrentLocation.getCurrentLocation();
    double lat = position.latitude;
    double lon = position.longitude;
    final Forecast forecast =
        await apiRepository.fetchForecastOneCall(lat, lon);
    final AirQuality airQuality = await apiRepository.fetchAirQuality(lat, lon);
    final ForecastDaily forecastDaily =
        await apiRepository.fetchForecastDaily(lat, lon);
    final MyLocation myLocation =
        await apiRepository.fetchAddressFromLocation(lat, lon);

    emit(WeatherLoaded(
        forecast: forecast,
        airQuality: airQuality,
        forecastDaily: forecastDaily,
        myLocation: myLocation));
  }

  Future<void> _onFetchWeatherLocation(
      WeatherLocationFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    double lat = event.lat;
    double lon = event.lon;
    final Forecast forecast =
        await apiRepository.fetchForecastOneCall(lat, lon);
    final AirQuality airQuality = await apiRepository.fetchAirQuality(lat, lon);
    final ForecastDaily forecastDaily =
        await apiRepository.fetchForecastDaily(lat, lon);
    final MyLocation myLocation =
    await apiRepository.fetchAddressFromLocation(lat, lon);

    emit(WeatherLoaded(
        forecast: forecast,
        airQuality: airQuality,
        forecastDaily: forecastDaily, myLocation: myLocation));
  }
}
