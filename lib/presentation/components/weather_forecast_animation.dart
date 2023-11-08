import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/presentation/components/assets.gen.dart';

part 'weather_forecast_animation.g.dart';

class WeatherForecastAnimation extends ConsumerWidget {
  const WeatherForecastAnimation({
    super.key,
    required this.classification,
    this.size = 100,
  });

  final WeatherForecastClassification classification;
  final double size;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.read(forecastAnimationFactoryProvider(
      classification: classification,
      size: size,
    ));
  }
}

@Riverpod(keepAlive: true)
class ForecastAnimationFactory extends _$ForecastAnimationFactory {
  @override
  LottieBuilder build({
    required WeatherForecastClassification classification,
    double size = 100,
  }) {
    final assetPath = {
      WeatherForecastClassification.clear: Assets.lottie.clearDay,
      WeatherForecastClassification.cloudy: Assets.lottie.cloudy,
      WeatherForecastClassification.partlyCloudy: Assets.lottie.partlyCloudyDay,
      WeatherForecastClassification.overcastDayRain:
          Assets.lottie.overcastDayRain,
      WeatherForecastClassification.rainy: Assets.lottie.overcastRain,
      WeatherForecastClassification.snowy: Assets.lottie.snow
    }[classification];

    if (assetPath == null) {
      throw ForecastAnimationFactoryIconNotImplemented(
        classification: classification,
      );
    }

    return Lottie.asset(
      assetPath,
      width: size,
      height: size,
    );
  }
}

class ForecastAnimationFactoryIconNotImplemented implements Exception {
  ForecastAnimationFactoryIconNotImplemented({required this.classification});

  final WeatherForecastClassification classification;
}
