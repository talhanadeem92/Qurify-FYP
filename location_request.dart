import 'package:geolocator/geolocator.dart';

Future<bool> requestLocationPermission() async {
  LocationPermission permission = await Geolocator.checkPermission();

  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return false; // Permission denied
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return false; // Permissions are permanently denied
  }

  return true; // Permission granted
}