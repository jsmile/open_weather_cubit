import 'dart:convert';

import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String discription;
  final String icon;
  final double temp;
  final double tempMin;
  final double tempMax;
  final String name;
  final String country;
  final String state;
  final DateTime lastUpdated;

  const Weather({
    required this.discription,
    required this.icon,
    required this.temp,
    required this.tempMin,
    required this.tempMax,
    required this.name,
    required this.country,
    required this.state,
    required this.lastUpdated,
  });

  @override
  List<Object> get props {
    return [
      discription,
      icon,
      temp,
      tempMin,
      tempMax,
      name,
      country,
      state,
      lastUpdated,
    ];
  }

  @override
  String toString() {
    return 'Weather(discription: $discription, icon: $icon, temp: $temp, tempMin: $tempMin, tempMax: $tempMax, name: $name, country: $country, state: $state, lastUpdated: $lastUpdated)';
  }

  Map<String, dynamic> toMap() {
    return {
      'discription': discription,
      'icon': icon,
      'temp': temp,
      'tempMin': tempMin,
      'tempMax': tempMax,
      'name': name,
      'country': country,
      'state': state,
      'lastUpdated': lastUpdated.millisecondsSinceEpoch,
    };
  }

  factory Weather.fromMap(Map<String, dynamic> map) {
    final weather = map['weather'][0];
    final main = map['main'];

    return Weather(
      discription: weather['discription'] ?? '',
      icon: weather['icon'] ?? '',
      temp: main['temp']?.toDouble() ?? 0.0,
      tempMin: main['temp_min']?.toDouble() ?? 0.0,
      tempMax: main['temp_max']?.toDouble() ?? 0.0,
      name: '',
      country: '',
      state: '',
      lastUpdated: DateTime.now(), // local 의 현재시간.
    );
  }

  // 초기 weather 에 대한 null safety 대응을 위해 추가.
  factory Weather.initial() {
    return Weather(
      discription: '',
      icon: '',
      temp: 100.0,
      tempMin: 100.0,
      tempMax: 100.0,
      name: '',
      country: '',
      state: '',
      lastUpdated: DateTime(1970),
    );
  }

  String toJson() => json.encode(toMap());

  factory Weather.fromJson(String source) =>
      Weather.fromMap(json.decode(source));
}
