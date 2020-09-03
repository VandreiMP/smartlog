import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapaRomaneio extends StatefulWidget {
  @override
  _MapaRomaneioState createState() => _MapaRomaneioState();
}

class _MapaRomaneioState extends State<MapaRomaneio> {
  GoogleMapController _mapController;

  void initState() {
    super.initState();
    _initLocalizacao();
  }

  _initLocalizacao() async {}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        _googleMap(context, _mapController),
      ],
    );
  }
}

Widget _googleMap(BuildContext context, GoogleMapController controller) {
  return Container(
    height: 500,
    width: 500,
    child: GoogleMap(

      mapType: MapType.normal,
      initialCameraPosition:
          CameraPosition(target: LatLng(40.712776, -74.005974), zoom: 12),
      // onMapCreated: (GoogleMapController controller) {
      //   controller = controller;
      // },
      markers: {marker1},
    ),
  );
}

Marker marker1 = Marker(
    markerId: MarkerId('marker1'),
    position: LatLng(40.712776, -74.005974),
    infoWindow: InfoWindow(title: 'Info Teste'),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueViolet));
