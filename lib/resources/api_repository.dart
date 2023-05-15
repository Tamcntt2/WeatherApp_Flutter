import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/forecast_daily.dart';
import 'package:weather_app/models/location2.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Forecast> fetchForecastOneCall() {
    return _provider.fetchForecastOneCall();
  }

  Future<ForecastDaily> fetchForecastDaily() {
    return _provider.fetchForecastDaily();
  }

  Future<List<MyLocation2>> fetchListLocationFromAddress(String text) {
    return _provider.fetchListLocationFromAddress(text);
  }
}
