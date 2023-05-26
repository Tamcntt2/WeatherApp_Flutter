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
  List<Object?> get props => throw UnimplementedError();
}
