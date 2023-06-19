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

// class LocalLocationsFetched extends WeatherEvent {
//   LocalLocation location;
//
//   LocalLocationsFetched({required this.location});
//
//   @override
//   // TODO: implement props
//   List<Object?> get props => [location];
// }

class LocationFavorite extends WeatherEvent {
  String? lat;
  String? lon;

  LocationFavorite(this.lat, this.lon);

  @override
  // TODO: implement props
  List<Object?> get props => [lat, lon];
}
