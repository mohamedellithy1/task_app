import 'package:dartz/dartz.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/weather.dart';
import '../../domain/repositories/weather_repository.dart';
import '../datasources/weather_remote_datasource.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource remoteDataSource;

  WeatherRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, Weather>> getCurrentWeather() async {
    try {
      final weather = await remoteDataSource.getCurrentWeather();
      return Right(weather);
    } on Exception catch (e) {
      final errorMessage = e.toString();

      if (errorMessage.contains('Location')) {
        return Left(LocationFailure(errorMessage));
      } else if (errorMessage.contains('network') ||
          errorMessage.contains('Failed to fetch')) {
        return Left(
          NetworkFailure(
            'Failed to fetch weather data. Please check your internet connection.',
          ),
        );
      } else {
        return Left(
          ServerFailure('An unexpected error occurred: $errorMessage'),
        );
      }
    }
  }

  @override
  Future<Either<Failure, Weather>> getWeatherByCity(String cityName) async {
    try {
      final weather = await remoteDataSource.getWeatherByCity(cityName);
      return Right(weather);
    } on Exception catch (e) {
      final errorMessage = e.toString();

      if (errorMessage.contains('City not found')) {
        return Left(ServerFailure('City not found: $cityName'));
      } else if (errorMessage.contains('network') ||
          errorMessage.contains('Failed to fetch')) {
        return Left(
          NetworkFailure(
            'Failed to fetch weather data. Please check your internet connection.',
          ),
        );
      } else {
        return Left(
          ServerFailure('An unexpected error occurred: $errorMessage'),
        );
      }
    }
  }
}
