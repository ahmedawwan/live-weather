import 'package:flutter/material.dart';
import 'package:live_weather/screens/location_screen.dart';
import 'package:live_weather/services/weather.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

  WeatherModel weather = WeatherModel();

  void getLocationData() async {
    var weatherData = await weather.getLocationData();
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
