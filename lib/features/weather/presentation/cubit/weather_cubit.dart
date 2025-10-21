import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/repositories/weather_repository.dart';
import 'weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  final WeatherRepository repository;

  WeatherCubit({required this.repository}) : super(WeatherInitial());

  Future<void> getWeather() async {
    emit(WeatherLoading());

    final result = await repository.getCurrentWeather();

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> getWeatherByCity(String cityName) async {
    emit(WeatherLoading());

    final result = await repository.getWeatherByCity(cityName);

    result.fold(
      (failure) => emit(WeatherError(failure.message)),
      (weather) => emit(WeatherLoaded(weather)),
    );
  }

  Future<void> refreshWeather() async {
    await getWeather();
  }
}
