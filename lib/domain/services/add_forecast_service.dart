import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'add_forecast_service.g.dart';

class AddForecastService {
  final SkywatchApiService _api;

  AddForecastService({
    required SkywatchApiService api,
  }) : _api = api;

  Future<void> call(Map<String, dynamic> data) async {
    return _api.post(
      endpoint: '/v1/forecast',
      data: data,
    );
  }
}

@riverpod
AddForecastService addForecastService(AddForecastServiceRef ref) {
  return AddForecastService(
    api: ref.read(
      skywatchApiServiceProvider,
    ),
  );
}
