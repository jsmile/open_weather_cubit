import 'package:ansicolor/ansicolor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:open_weather_cubit/cubits/temp_settings/temp_settings_cubit.dart';
import 'package:open_weather_cubit/cubits/weather/weather_cubit.dart';

import 'repositories/weather_repository.dart';

import 'pages/home_page.dart';
import 'services/weather_api_service.dart';

void main() async {
  ansiColorDisabled = false;
  // 환경변수 읽기
  // await dotenv.load(fileName: '.env', isOptional: true);
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => WeatherRepository(
        weatherApiService: WeatherApiService(
          httpClient: http.Client(),
        ),
      ),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<WeatherCubit>(
            create: (context) => WeatherCubit(
              weatherRepository: context.read<WeatherRepository>(),
            ),
          ),
          BlocProvider<TempSettingsCubit>(
            create: (context) => TempSettingsCubit(),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter BLoC - OpenWeather Cubit',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
            useMaterial3: true,
          ),
          home: const HomePage(),
        ),
      ),
    );
  }
}
