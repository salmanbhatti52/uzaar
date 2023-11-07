import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

late bool serviceEnabled;
late LocationPermission permission;
// late LocationData _locationData;

void enableLocationService() async {
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    // Location services are not enabled don't continue
    // accessing the position and request users of the
    // App to enable the location services.
    return Future.error('Location services are disabled.');
  }

  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      // Permissions are denied, next time you could try
      // requesting permissions again (this is also where
      // Android's shouldShowRequestPermissionRationale
      // returned true. According to Android guidelines
      // your App should show an explanatory UI now.
      return Future.error('Location permissions are denied');
    }
  }
}

Future<Position> getLocationCoordinates() async {
  enableLocationService();
  return await Geolocator.getCurrentPosition(
    desiredAccuracy: LocationAccuracy.low,
  );
}

Future<List<Placemark>> getLocationFromCoordinates(
    double latitude, double longitude) async {
  return await placemarkFromCoordinates(latitude, longitude,
      localeIdentifier: 'en');
}
