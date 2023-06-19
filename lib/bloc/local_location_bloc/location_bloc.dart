import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:weather_app/models/location.dart';
import '../../resources/api/api_repository.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final ApiRepository apiRepository = ApiRepository();

  LocationBloc() : super(const LocationState()) {
    on<LocationFetched>(_onFetchLocation);
    on<LocationAdded>(_onAddLocation);
    on<LocationDeleted>(_onDeleteLocation);
  }

  Future<void> _onFetchLocation(
      LocationFetched event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    final List<MyLocation> list = await apiRepository.fetchListLocation();
    emit(LocationLoaded(list: list));
  }

  Future<void> _onAddLocation(
      LocationAdded event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    final List<MyLocation> list = await apiRepository.fetchListLocation();
    list.add(event.location!);
    emit(LocationLoaded(list: list));
  }

  Future<void> _onDeleteLocation(
      LocationDeleted event, Emitter<LocationState> emit) async {
    emit(LocationLoading());
    final List<MyLocation> list = await apiRepository.fetchListLocation();
    list.remove(event.location!);
    emit(LocationLoaded(list: list));
  }
}
