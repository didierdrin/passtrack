import 'package:flutter/material.dart';
import 'package:passtrack/colors.dart';
import 'package:weather/weather.dart';
//import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';

class WeatherForecastPage extends StatefulWidget {
  const WeatherForecastPage({super.key});
  @override
  State<WeatherForecastPage> createState() => _WeatherForecastPageState();
}

class _WeatherForecastPageState extends State<WeatherForecastPage> {
  final logger = Logger();
  final WeatherFactory _wf = WeatherFactory("db28c5b869d263b1b30e4dc9051c674d");
  final List<String> cities = [
    "Kigali",
    "Muhanga",
    "Nyanza",
    "Huye"
  ]; // Add a city in the list
  Map<String, Weather?> weatherData = {};

  @override
  void initState() {
    super.initState();
    _fetchWeatherData();
  }

  Future<void> _fetchWeatherData() async {
    for (String city in cities) {
      try {
        Weather w = await _wf.currentWeatherByCityName(city);
        setState(() {
          weatherData[city] = w;
        });
      } catch (e) {
        logger.d("Error fetching weather for $city: $e");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: mcgpalette0[50],
        title: const Text("Weather Forecast"),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (context, index) {
          String city = cities[index];
          Weather? weather = weatherData[city];
          return Card(
            margin: const EdgeInsets.all(8),
            child: ListTile(
              title: Text(city),
              subtitle: weather != null
                  ? Text(
                      "${weather.temperature?.celsius?.toStringAsFixed(1)}°C, ${weather.weatherMain}")
                  : const Text("Loading..."),
              trailing: weather != null
                  ? Icon(
                      _getWeatherIcon(weather.weatherMain ?? ""),
                      color: mcgpalette0[50],
                    )
                  : null,
            ),
          );
        },
      ),
    );
  }

  IconData _getWeatherIcon(String condition) {
    switch (condition.toLowerCase()) {
      case "clear":
        return Icons.wb_sunny;
      case "clouds":
        return Icons.cloud;
      case "rain":
        return Icons.umbrella;
      default:
        return Icons.error;
    }
  }
}
