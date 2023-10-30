import 'package:hive/hive.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/entities/forecast.dart';

class ForecastService {
  String boxName = 'forecastBox';

  void init() {
    Hive.registerAdapter(ForecastAdapter());
  }

  Future<Iterable<Forecast>> get({
    Country? country,
  }) async {
    final forecasts = (await Hive.openBox<Forecast>(boxName)).values.toList();

    if (country != null) {
      forecasts.removeWhere((x) => x.countryCode != country.countryCode);
    }

    return forecasts..sort(((a, b) => a.createdAt.compareTo(b.createdAt)));
  }

  Future<void> add(Forecast forecast) async {
    await forecast.save();
  }
}
