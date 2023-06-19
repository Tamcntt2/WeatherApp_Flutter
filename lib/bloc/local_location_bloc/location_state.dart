import 'package:equatable/equatable.dart';
import 'package:weather_app/models/location.dart';

enum LocationStatus { initial, loading, loaded, error }

class LocationState extends Equatable {
  final List<MyLocation>? list;

  // final bool? isFavorite;

  const LocationState({this.list});

  @override
// TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}

class LocationInitial extends LocationState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  const LocationLoaded({super.list});
}

class LocationError extends LocationState {
  final String? message;

  const LocationError(this.message);
}
