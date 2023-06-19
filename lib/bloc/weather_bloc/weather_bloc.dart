import 'dart:async';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/bloc/weather_bloc/weather_event.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_app/bloc/weather_bloc/weather_state.dart';
import 'package:weather_app/models/air_quality.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/location.dart';

import '../../models/forecast_daily.dart';
import '../../resources/api/api_repository.dart';
import '../../utils/current_location.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiRepository apiRepository = ApiRepository();

  WeatherBloc() : super(const WeatherState()) {
    on<WeatherCurrentFetched>(_onFetchWeather);
    on<WeatherLocationFetched>(_onFetchWeatherLocation);
    // on<LocalLocationsFetched>(_onFetchLocalLocation);
    on<LocationFavorite>(_onFavoriteLocation);
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
    final prefs = await SharedPreferences.getInstance();
    int checkDegree = prefs.getInt('degree') ?? 0;
    int checkSpeed = prefs.getInt('speed') ?? 0;
    int checkDistance = prefs.getInt('distance') ?? 0;

    emit(WeatherLoaded(
        forecast: forecast,
        airQuality: airQuality,
        forecastDaily: forecastDaily,
        myLocation: myLocation,
        checkDegree: checkDegree,
        checkDistance: checkDistance,
        checkSpeed: checkSpeed));
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
    final prefs = await SharedPreferences.getInstance();
    int checkDegree = prefs.getInt('degree') ?? 0;
    int checkSpeed = prefs.getInt('speed') ?? 0;
    int checkDistance = prefs.getInt('distance') ?? 0;

    emit(WeatherLoaded(
        forecast: forecast,
        airQuality: airQuality,
        forecastDaily: forecastDaily,
        myLocation: myLocation,
        checkDegree: checkDegree,
        checkDistance: checkDistance,
        checkSpeed: checkSpeed));
  }

  Future<void> _onFavoriteLocation(
      LocationFavorite event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final List<MyLocation> list = await apiRepository.fetchListLocation();
    bool isFavorite = false;
    MyLocation locationSelected = await apiRepository.fetchAddressFromLocation(
        double.parse(event.lat!), double.parse(event.lon!));
    for (var item in list) {
      if (item.name == locationSelected.name) {
        isFavorite = true;
        break;
      }
    }
    emit(WeatherLoaded(isFavorite: isFavorite));
  }

// Future<void> _onFetchLocalLocation(
//     LocalLocationsFetched event, Emitter<WeatherState> emit) async {}
}
