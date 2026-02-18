import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/location_screen_controller.dart';

class LocationScreenView extends GetView<LocationScreenController> {
  const LocationScreenView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LocationScreenView'),
        centerTitle: true,
      ),
      body: Obx(() {
        return Column(
          children: [
            Expanded(
              child: GoogleMap(
                onMapCreated: (GoogleMapController map) {
                  controller.mapController = map;
                },
                initialCameraPosition: const CameraPosition(
                  target: LatLng(28.6139, 77.2090),
                  zoom: 12,
                ),
                markers: controller.markers.value.toSet(),
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
              ),
            ),
          ],
        );
      }),
    );
  }
}
