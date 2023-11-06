import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/entities/forecast.dart';
import 'package:skywatch/domain/services/add_forecast_service.dart';
import 'package:skywatch/domain/services/get_forecast_service.dart';

part 'forecast_repository.g.dart';

class ForecastRepository {
  ForecastRepository({
    required GetForecastService getForecastService,
    required AddForecastService addForecastService,
  })  : _addForecastService = addForecastService,
        _getForecastService = getForecastService;

  final GetForecastService _getForecastService;
  final AddForecastService _addForecastService;

  Future<List<Forecast>> get({
    Country? country,
  }) async {
    final data = await _getForecastService(
      countryCode: country?.code,
    );

    return data.map((x) => Forecast.fromJson(x)).toList();
  }

  Future<void> add(Forecast forecast) async {
    await _addForecastService(forecast.toJson());
  }
}

@Riverpod(keepAlive: true)
ForecastRepository forecastRepository(ForecastRepositoryRef ref) {
  return ForecastRepository(
    getForecastService: ref.read(getForecastServiceProvider),
    addForecastService: ref.read(addForecastServiceProvider),
  );
}
