import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RadarPage extends StatefulWidget {
  const RadarPage({Key? key}) : super(key: key);

  @override
  State<RadarPage> createState() => _RadarPageState();
}

class _RadarPageState extends State<RadarPage> {
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller){
    mapController = controller;
  }
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
        initialCameraPosition:
            CameraPosition(target: LatLng(37, -122), zoom: 12));
  }
}
