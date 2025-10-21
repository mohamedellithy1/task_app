import 'package:equatable/equatable.dart';

class Weather extends Equatable {
  final String cityName;
  final double temperature;
  final String weatherCondition;
  final String weatherIcon;
  final String description;

  const Weather({
    required this.cityName,
    required this.temperature,
    required this.weatherCondition,
    required this.weatherIcon,
    required this.description,
  });

  @override
  List<Object> get props => [
    cityName,
    temperature,
    weatherCondition,
    weatherIcon,
    description,
  ];
}
