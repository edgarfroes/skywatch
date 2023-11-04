import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'get_forecast_service.g.dart';

class GetForecastService {
  final SkywatchApiService _api;

  GetForecastService({
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

@riverpod
GetForecastService getForecastService(GetForecastServiceRef ref) {
  return GetForecastService(
    api: ref.read(
      skywatchApiServiceProvider,
    ),
  );
}
