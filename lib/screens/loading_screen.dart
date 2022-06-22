import 'package:flutter/material.dart';
import 'package:live_weather/screens/location_screen.dart';
import '../services/location.dart';
import '../services/networking.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

const apiKey = 'f2a877270e4a22793d347e50399e5e82';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Location location = Location();

  void getLocationData() async {
    await location.getCurrentLocation();
    print('location recieved');
    NetworkHelper networkHelper = NetworkHelper(
      'https://api.openweathermap.org/data/2.5/weather?lat=${location.getLatitude()}&lon=${location.getLongitude()}&appid=$apiKey&units=metric',
    );
    var weatherData = await networkHelper.getData();
    print('weather data received');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (c) => LocationScreen(
          locationWeather: weatherData,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SpinKitDoubleBounce(
        color: Colors.white,
        size: 50.0,
      ),
    );
  }
}
