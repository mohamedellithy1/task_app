import '../../domain/entities/weather.dart';

class WeatherModel extends Weather {
  const WeatherModel({
    required super.cityName,
    required super.temperature,
    required super.weatherCondition,
    required super.weatherIcon,
    required super.description,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'] as String,
      temperature: (json['main']['temp'] as num).toDouble(),
      weatherCondition: json['weather'][0]['main'] as String,
      weatherIcon: json['weather'][0]['icon'] as String,
      description: json['weather'][0]['description'] as String,
    );
  }
}
