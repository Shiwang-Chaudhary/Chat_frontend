import 'package:geolocator/geolocator.dart';

class LocationPermissionService {
  static Future<void> requestLocationPermission() async {
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception("Location permission denied");
      }
    }
    if (permission == LocationPermission.deniedForever) {
      throw Exception(
        "Location permission permanently denied. Please enable it from settings.",
      );
    }
  }
}
