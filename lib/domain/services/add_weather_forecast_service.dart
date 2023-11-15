import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'add_weather_forecast_service.g.dart';

@riverpod
Future<void> addWeatherForecastService(
  AddWeatherForecastServiceRef ref,
  WeatherForecast weatherForecast,
) async {
  await ref.read(skywatchApiServiceProvider).post(
        endpoint: '/v1/forecast',
        data: weatherForecast.toJson(),
      );
}
