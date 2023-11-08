import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/domain/services/add_weather_forecast_service.dart';
import 'package:skywatch/domain/services/get_weather_forecast_service.dart';

part 'weather_forecast_repository.g.dart';

class WeatherForecastRepository {
  WeatherForecastRepository({
    required GetWeatherForecastService getWeatherForecastService,
    required AddWeatherForecastService addWeatherForecastService,
  })  : _addWeatherForecastService = addWeatherForecastService,
        _getWeatherForecastService = getWeatherForecastService;

  final GetWeatherForecastService _getWeatherForecastService;
  final AddWeatherForecastService _addWeatherForecastService;

  Future<List<WeatherForecast>> get({
    Country? country,
  }) async {
    final data = await _getWeatherForecastService(
      countryCode: country?.code,
    );

    return data.map((x) => WeatherForecast.fromJson(x)).toList();
  }

  Future<void> add(WeatherForecast weatherForecast) async {
    await _addWeatherForecastService(weatherForecast.toJson());
  }
}

@Riverpod(keepAlive: true)
WeatherForecastRepository weatherForecastRepository(
    WeatherForecastRepositoryRef ref) {
  return WeatherForecastRepository(
    getWeatherForecastService: ref.read(getWeatherForecastServiceProvider),
    addWeatherForecastService: ref.read(addWeatherForecastServiceProvider),
  );
}
