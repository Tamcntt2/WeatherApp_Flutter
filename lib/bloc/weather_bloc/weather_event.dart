import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class WeatherCurrentFetched extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class WeatherLocationFetched extends WeatherEvent {
  double lat;
  double lon;

  WeatherLocationFetched({required this.lat, required this.lon});

  @override
  // TODO: implement props
  List<Object?> get props => [lat, lon];
}

class WeatherSetting extends WeatherEvent {
  int checkDegree;
  int checkSpeed;
  int checkDistance;

  WeatherSetting(
      {required this.checkDegree,
      required this.checkSpeed,
      required this.checkDistance});

  @override
  // TODO: implement props
  List<Object?> get props => [checkDegree, checkSpeed, checkDistance];
}
