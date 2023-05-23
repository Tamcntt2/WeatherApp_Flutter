import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:weather_app/bloc/weather_bloc.dart';
import 'package:weather_app/bloc/weather_state.dart';

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
    controller.showMarkerInfoWindow(MarkerId("Demo"));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(builder: (context, state) {
      return GoogleMap(
        onMapCreated: _onMapCreated,
        markers: {
          Marker(
            markerId: MarkerId("Demo"),
            position: LatLng(data["lat"] as double, data["lon"] as double),
            visible: true,
            infoWindow: InfoWindow(
              title: "Ha Noi",
              snippet: "${state.forecast!.current!.temp.toString()} °C",
            ),
          )
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(data["lat"] as double, data["lon"] as double),
          zoom: 12,
        ),
      );
    });
  }
}
