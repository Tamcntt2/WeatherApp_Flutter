import 'package:weather_app/models/air_quality.dart';
import 'package:weather_app/models/forecast.dart';
import 'package:weather_app/models/forecast_daily.dart';
import 'package:weather_app/models/location2.dart';
import 'package:weather_app/models/local_notification.dart';

import '../../models/location.dart';
import 'api_provider.dart';

class ApiRepository {
  final _provider = ApiProvider();

  Future<Forecast> fetchForecastOneCall(double lat, double lon) {
    return _provider.fetchForecastOneCall(lat, lon);
  }

  Future<ForecastDaily> fetchForecastDaily(double lat, double lon) {
    return _provider.fetchForecastDaily(lat, lon);
  }

  Future<List<MyLocation2>> fetchListLocationFromAddress(String text) {
    return _provider.fetchListLocationFromAddress(text);
  }

  Future<AirQuality> fetchAirQuality(double lat, double lon) {
    return _provider.fetchAirQuality(lat, lon);
  }

  Future<MyLocation> fetchAddressFromLocation(double lat, double lon) {
    return _provider.fetchAddressFromLocation(lat, lon);
  }

  Future<List<LocalNotification>> fetchListNotification() {
    return _provider.fetchListNotification();
  }

  Future<List<MyLocation>> fetchListLocation() {
    return _provider.fetchListLocation();
  }
}
