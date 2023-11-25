import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_forecast.freezed.dart';
part 'weather_forecast.g.dart';

@freezed
class WeatherForecast with _$WeatherForecast {
  WeatherForecast._();

  factory WeatherForecast({
    required String id,
    required String description,
    required String countryCode,
    required String videoUrl,
    required DateTime createdAt,
    required WeatherForecastClassification classification,
  }) = _WeatherForecast;

  factory WeatherForecast.fromJson(Map<String, dynamic> json) =>
      _$WeatherForecastFromJson(json);
}

enum WeatherForecastClassification {
  clear,
  partlyCloudy,
  cloudy,
  overcastDayRain,
  rainy,
  snowy,
}
