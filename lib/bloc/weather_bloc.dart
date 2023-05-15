import 'package:weather_app/bloc/weather_event.dart';
import 'package:weather_app/bloc/weather_state.dart';
import 'package:bloc/bloc.dart';
import 'package:weather_app/models/forecast.dart';

import '../resources/api_repository.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiRepository apiRepository = ApiRepository();

  WeatherBloc() : super(WeatherState()) {
    on<WeatherFetched>(_onFetchWeather);
  }

  Future<void> _onFetchWeather(
      WeatherFetched event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());
    final Forecast forecast = await apiRepository.fetchForecastOneCall();
    // final ForecastDaily forecastDaily =
    //     await apiRepository.fetchForecastDaily();
    emit(WeatherLoaded(forecast: forecast));
  }
}
