import 'dart:async';

import 'package:betweener_project/storage/shared_preference_controller.dart';
import 'package:betweener_project/core/utils/map_utils.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);
  static String id = '/locationScreen';

  @override
  State<LocationScreen> createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(
        SharedPreferenceController().lat, SharedPreferenceController().long),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(30.43296265331129, 34.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
  final LatLng _center = LatLng(
      SharedPreferenceController().lat, SharedPreferenceController().long);
  late GoogleMapController mapController;

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Location'),
        elevation: 2,
      ),
      body: Center(
        child: GoogleMap(
          onMapCreated: _onMapCreated,
          markers: {
            Marker(
                markerId: const MarkerId('source'),
                position: _center,
                onTap: () => MapUtils.openMap(SharedPreferenceController().lat,
                    SharedPreferenceController().long)),
          },
          initialCameraPosition: CameraPosition(
            target: _center,
            zoom: 11.0,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _goToTheLake,
        label: const Text('To the lake!'),
        icon: const Icon(Icons.directions_boat),
      ),
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    await controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }
}
