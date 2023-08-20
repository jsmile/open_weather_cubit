import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';

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
    context.read<WeatherCubit>().fetchWeather('london');
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
