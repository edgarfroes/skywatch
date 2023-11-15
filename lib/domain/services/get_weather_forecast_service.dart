import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'get_weather_forecast_service.g.dart';

@Riverpod(keepAlive: true)
Future<List<WeatherForecast>> getWeatherForecastService(
  GetWeatherForecastServiceRef ref, {
  String? countryCode,
}) async {
  final data = await ref.read(skywatchApiServiceProvider).list(
    endpoint: '/v1/forecast',
    queryParams: {
      if (countryCode?.isNotEmpty == true) ...{
        'countryCode': countryCode!,
      }
    },
  );

  return data.map(WeatherForecast.fromJson).toList();
}
