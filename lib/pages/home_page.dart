import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_cubit/repositories/weather_repository.dart';

import '../services/weather_api_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  // WeatherRepository 테스트
  void _fetchWeather() {
    WeatherRepository(
      weatherApiService: WeatherApiService(
        httpClient: http.Client(),
      ),
    ).fetchWeather('london');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Weather',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
