import 'package:equatable/equatable.dart';

class DirectGeocoing extends Equatable {
  final String name;
  final double lat;
  final double lng;
  final String country; // 국가코드
  final String state; //국가명

  const DirectGeocoing({
    required this.name,
    required this.lat,
    required this.lng,
    required this.country,
    required this.state,
  });

  factory DirectGeocoing.fromJson(List<dynamic> json) {
    final Map<String, dynamic> data = json[0];

    return DirectGeocoing(
        name: data['name'],
        lat: data['lat'],
        lng: data['lng'],
        country: data['country'],
        state: data['state']);
  }

  @override
  List<Object> get props {
    return [
      name,
      lat,
      lng,
      country,
      state,
    ];
  }

  @override
  String toString() {
    return 'DirectGocoing(name: $name, lat: $lat, lng: $lng, country: $country, state: $state)';
  }
}
