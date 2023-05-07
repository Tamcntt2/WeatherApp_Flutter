import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/forecast_daily.dart';

import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Forecast> fetchForecast() {
    return _provider.fetchForecast();
  }

  Future<ForecastDaily> fetchForecastDaily() {
    return _provider.fetchForecastDaily();
  }
}
