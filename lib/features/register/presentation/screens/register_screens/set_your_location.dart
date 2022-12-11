import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';

class SetYourLocation extends StatelessWidget {
   SetYourLocation({Key? key}) : super(key: key);

  late GoogleMapController googleMapController;
  final LatLng center = LatLng(currentLat!, currentLng!);

   void _onMapCreated(GoogleMapController controller) {
     googleMapController = controller;
   }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: center,
        zoom: 11.0,
      ),
    );
  }
}
