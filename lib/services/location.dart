import 'package:geolocator/geolocator.dart';

class Location {
  double _latitude;
  double _longitude;

  Future<void> getCurrentLocation() async {
    try {
      if (_isLocationPermitted() == true) {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.low,
        );
        _latitude = position.latitude;
        _longitude = position.longitude;
      } else {
        return;
      }
    } catch (e) {
      print(e);
    }
  }

  double getLongitude() {
    return _longitude;
  }

  double getLatitude() {
    return _latitude;
  }

  Future<bool> _isLocationPermitted() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    LocationPermission permission;

    // If location services are not enabled request users to enable the location services.
    if (!serviceEnabled) {
      print('Location services are disabled.');
      return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      // If User denies Permissions
      if (permission == LocationPermission.denied) {
        print('Location services are disabled.');
        return false;
      }
    }
    // Permissions are denied forever
    if (permission == LocationPermission.deniedForever) {
      print(
          'Location permissions are permanently denied, we cannot request permissions.');
      return false;
    }
    return true;
  }
}
