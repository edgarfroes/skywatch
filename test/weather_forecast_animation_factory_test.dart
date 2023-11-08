import 'package:flutter_test/flutter_test.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/presentation/components/weather_forecast_animation.dart';

import 'helpers/riverpod_container_provider_helper.dart';

void main() {
  test('Verificar se a quantidade de itens no enum é a mesma do Map', () {
    final container = createRiverpodContainer();

    for (var item in WeatherForecastClassification.values) {
      container.read(forecastAnimationFactoryProvider(
        classification: item,
      ));
    }
  });
}
