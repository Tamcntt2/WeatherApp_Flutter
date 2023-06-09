import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/bloc/weather_bloc/weather_bloc.dart';

import '../../bloc/weather_bloc/weather_state.dart';
import '../../resources/api/demo_data.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({Key? key}) : super(key: key);

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    controller.showMarkerInfoWindow(const MarkerId("Demo"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      if (state is WeatherLoaded) {
        int temp = state.forecast!.current!.temp.round();
        return GoogleMap(
          onMapCreated: _onMapCreated,
          markers: {
            Marker(
              markerId: const MarkerId("Demo"),
              position: LatLng(data["lat"] as double, data["lon"] as double),
              visible: true,
              infoWindow: InfoWindow(
                title: "Ha Noi",
                snippet: "${temp.toString()}°C",
              ),
            )
          },
          initialCameraPosition: CameraPosition(
            target: LatLng(data["lat"] as double, data["lon"] as double),
            zoom: 12,
          ),
        );
      } else {
        return Container();
      }
    });
    // return const Placeholder();
  }
}
