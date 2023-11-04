import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'get_countries_service.g.dart';

class GetCountriesService {
  final SkywatchApiService _api;

  GetCountriesService({
    required SkywatchApiService api,
  }) : _api = api;

  Future<List<Map<String, dynamic>>> call({
    String? countryCode,
  }) async {
    return _api.list(endpoint: '/v1/country');
  }
}

@riverpod
GetCountriesService getCountriesService(GetCountriesServiceRef ref) {
  return GetCountriesService(
    api: ref.read(
      skywatchApiServiceProvider,
    ),
  );
}
