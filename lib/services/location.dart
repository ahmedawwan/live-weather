import 'package:geolocator/geolocator.dart';

class Location {
  double _latitude;
  double _longitude;

  Future<void> getCurrentLocation() async {
    try {
      print('getting location');
      if (await isLocationPermitted()) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );
        print("location gotten");
        _latitude = position.latitude;
        _longitude = position.longitude;
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  getLatitude() {
    return _latitude;
  }

  getLongitude() {
    return _longitude;
  }

  Future<bool> isLocationPermitted() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    // If location services are not enabled request users to enable the location services.
    if (!serviceEnabled) {
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // If User denies Permissions
      if (permission == LocationPermission.denied) {
        return false;
      }
    }
    // Permissions are denied forever
    if (permission == LocationPermission.deniedForever) {
      return false;
    }
    return true;
  }
}
