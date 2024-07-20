import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:lottie/lottie.dart';
import 'package:weatherapp/models/weather_model.dart';
import 'package:weatherapp/services/weather_service.dart';
import 'package:geocoding/geocoding.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
  final _weatherService = WeatherService('2dcdbb08eae63887b7dc0468b549d25a');

  Weather? _weather;

  _fetchWeather() async {
    Position position = await _weatherService.getCurrentCity();

    //convert the location into a list of placemark objects
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    // extract the city name from the first placemark

    String? city = placemarks[0].locality;

    //return city ?? "";

    try {
      final weather = await _weatherService.getWeather(position);

      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print("error saaays" + e.toString());
    }
  }

  String getWeatherAnimation(String? mainCondition) {
    if (mainCondition == null) return 'assets/sunny.json';

    switch (mainCondition.toLowerCase()) {
      case 'fog':
        return 'assets/cloudy.json';
      case 'shower rain':
        return 'assets/rainy.json';
      case 'rain':
        return 'assets/rainy.json';
      case 'clear':
        return 'assets/sunny.json';

      default:
        return 'assets/sunny.json';
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 49, 48, 48),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _weather?.cityname ?? "loading city..",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Lottie.asset(getWeatherAnimation(_weather?.mainCondition)),
            Text(
              '${_weather?.temperature.round() ?? 'laoding temperature'}°C',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text(
              _weather?.mainCondition ?? "loading condition..",
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            Text('Humidity: ${_weather?.humidity ?? 'loading humidity'}',
                style: TextStyle(color: Colors.white, fontSize: 25)),
            Text(
                'Wind speed: ${_weather?.wind_speed ?? 'loading wind_speed'} Km/h',
                style: TextStyle(color: Colors.white, fontSize: 25)),
          ],
        ),
      ),
    );
  }
}
