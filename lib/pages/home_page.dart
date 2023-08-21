import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';
import 'package:open_weather_cubit/pages/search_page.dart';

import '../utils/ansi_color.dart';
import '../widgets/error_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // 사용자가 navigator back 을 하면 null 이 될 수 있으므로 nullable 선언.
  String? city;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text(
          'Weather',
          style: TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () async {
              // 검색 결과를 받는데 시간이 걸리므로 비동기 처리.
              city = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SearchPage(),
                ),
              );
              debugPrint(info('### city : $city'));

              // 검색 결과가 있으면 날씨 정보를 가져옴.
              if (city != null) {
                context.read<WeatherCubit>().fetchWeather(city!);
              }
            },
          )
        ],
      ),
      body: _showWeather(),
    );
  }

  // 조회결과가 정상이면 날씨 정보를 보여주고,
  // Error 이면 Error Dialog 를 보여줌.
  Widget _showWeather() {
    return BlocConsumer<WeatherCubit, WeatherState>(
      // listener : error 발생여부 관찰
      // builder : 조회결과에 따른 화면 표시
      listener: (context, state) {
        if (state.status == WeatherStatus.failure) {
          errorDialog(context, state.error.errMag);
        }
      },
      builder: (context, state) {
        if (state.status == WeatherStatus.initial) {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        if (state.status == WeatherStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if ((state.status == WeatherStatus.failure) &&
            (state.weather.name == '')) {
          return const Center(
            child: Text(
              'Select a city',
              style: TextStyle(fontSize: 20.0),
            ),
          );
        }

        return Center(
          child: Text(
            state.weather.name,
            style: const TextStyle(fontSize: 20.0),
          ),
        );
      },
    );
  }
}
