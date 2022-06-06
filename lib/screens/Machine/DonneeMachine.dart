import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DonneeMachine extends StatefulWidget {
  double? longitude;
  double? latitude;
  String? nom;

  DonneeMachine({this.latitude, this.longitude, this.nom, Key? key})
      : super(key: key);
  @override
  _DonneeMachine createState() => _DonneeMachine();
}

class _DonneeMachine extends State<DonneeMachine> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(5.3484341, -4.1200983),
    zoom: 14.4746,
  );

  static final CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(5.3484341, -4.1200983),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    Set<Marker> mark = {};
    mark.add(Marker(
        markerId: MarkerId("1"),
        position: LatLng(widget.latitude!, widget.longitude!),
        infoWindow: InfoWindow(title: widget.nom)));

    return new Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        markers: mark,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: Text('To the lake!'),
        icon: Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
