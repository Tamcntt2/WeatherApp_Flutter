import 'package:equatable/equatable.dart';
import 'package:weather_app/models/location.dart';

abstract class LocationEvent extends Equatable {}

class LocationFetched extends LocationEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LocationAdded extends LocationEvent {
  MyLocation? location;

  LocationAdded({this.location});

  @override
  // TODO: implement props
  List<Object?> get props => [location];
}

class LocationDeleted extends LocationEvent {
  MyLocation? location;

  LocationDeleted({this.location});

  @override
  // TODO: implement props
  List<Object?> get props => [location];
}


