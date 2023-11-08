import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'add_weather_forecast_service.g.dart';

class AddWeatherForecastService {
  final SkywatchApiService _api;

  AddWeatherForecastService({
    required SkywatchApiService api,
  }) : _api = api;

  Future<void> call(Map<String, dynamic> data) async {
    return _api.post(
      endpoint: '/v1/forecast',
      data: data,
    );
  }
}

@Riverpod(keepAlive: true)
AddWeatherForecastService addWeatherForecastService(
    AddWeatherForecastServiceRef ref) {
  return AddWeatherForecastService(
    api: ref.read(
      skywatchApiServiceProvider,
    ),
  );
}
