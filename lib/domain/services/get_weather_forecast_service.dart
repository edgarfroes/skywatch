import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'get_weather_forecast_service.g.dart';

class GetWeatherForecastService {
  final SkywatchApiService _api;

  GetWeatherForecastService({
    required SkywatchApiService api,
  }) : _api = api;

  Future<List<Map<String, dynamic>>> call({
    String? countryCode,
  }) async {
    return _api.list(
      endpoint: '/v1/forecast',
      queryParams: {
        if (countryCode?.isNotEmpty == true) ...{
          'countryCode': countryCode!,
        }
      },
    );
  }
}

@Riverpod(keepAlive: true)
GetWeatherForecastService getWeatherForecastService(
    GetWeatherForecastServiceRef ref) {
  return GetWeatherForecastService(
    api: ref.read(
      skywatchApiServiceProvider,
    ),
  );
}
