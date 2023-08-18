import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:open_weather_cubit/repositories/weather_repository.dart';

import '../../models/custom_error.dart';
import '../../models/weather.dart';

part 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  // 날씨 정보가 필요하므로
  final WeatherRepository weatherRepository;

  WeatherCubit({required this.weatherRepository})
      : super(WeatherState.initial());

  // 날씨 정보 가져오기
  Future<void> fetchWeather(String city) async {
    // API 호출이 시작되었음을 반영
    emit(state.copyWith(status: WeatherStatus.loading));
    print('### loading State : $state');

    try {
      final weather = await weatherRepository.fetchWeather(city);
      // API 호출이 완료되었음을 반영
      emit(state.copyWith(
        status: WeatherStatus.loaded,
        weather: weather,
      ));
      print('### Loaded State : $state');
    } on CustomError catch (e) {
      // API 호출 시 Error 발생을 반영
      emit(state.copyWith(status: WeatherStatus.failure, error: e));
      print('### Error State : $state');
    }
  }
}
