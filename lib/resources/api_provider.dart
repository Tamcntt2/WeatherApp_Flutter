import 'dart:convert';

import 'package:weather_app/models/forecast.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/utils/ui_utils.dart';

import '../models/forecast_daily.dart';
import '../models/location2.dart';
import 'demo_data.dart';
import 'demo_data2.dart';

class ApiProvider {
  Future<Forecast> fetchForecast() async {
    //   String key = '1b5dcb72d707f1eca07003b425497af6';
    //   double lat = 21.030653;
    //   double lon = 105.847130;
    //   var recipesUrl = Uri.parse(
    //       'https://api.openweathermap.org/data/3.0/onecall?exclude=minutely&units=metric&lat=$lat&lon=$lon&appid=$key');
    //   final response = await http.get(recipesUrl);
    //   if (response.statusCode == 200) {
    //     final body = json.decode(response.body);
    //     return Forecast.fromJson(body);
    //   } else {
    //     throw Exception('Failed to load data from API');
    //   }
    return Forecast.fromJson(data);
  }

  Future<ForecastDaily> fetchForecastDaily() async {
    // String key = 'bf94bd3a7d84cc009f132207bdea82e6';
    // double lat = 21.030653;
    // double lon = 105.847130;
    // var recipesUrl = Uri.parse(
    //     'https://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$lon&appid=$key&units=metric');
    // final response = await http.get(recipesUrl);
    // if (response.statusCode == 200) {
    //   final body = json.decode(response.body);
    //   return ForecastDaily.fromJson(body);
    // } else {
    //   throw Exception('Failed to load data from API');
    // }
    return ForecastDaily.fromJson(data2);
  }

  Future<List<MyLocation2>> fetchLocationFromAddress(String text) async {
    var recipesUrl = Uri.parse(
        'https://nominatim.openstreetmap.org/search?format=json&city=$text&addressdetail=1');
    final response = await http.get(recipesUrl);
    if (response.statusCode == 200) {
      final body = json.decode(response.body) as List;
      return body.map((dynamic json) {
        final map = json as Map<String, dynamic>;
        return MyLocation2.fromJson(map);
      }).toList();
    } else {
      throw Exception('Failed to load data from API');
    }
  }
}
