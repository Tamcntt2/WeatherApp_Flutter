import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {}

class WeatherFetched extends WeatherEvent {
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
