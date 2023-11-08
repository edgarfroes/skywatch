import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/domain/repositories/weather_forecast_repository.dart';
import 'package:skywatch/presentation/components/timeago.dart';
import 'package:skywatch/presentation/components/weather_forecast_animation.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';

part 'weather_forecast_tab.g.dart';

@RoutePage()
class WeatherForecastTabScreen extends ConsumerWidget {
  const WeatherForecastTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherForecastAsyncValue = ref.watch(getWeatherForecastProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        scrolledUnderElevation: 0,
      ),
      body: RefreshIndicator(
        onRefresh: () => ref.refresh(getWeatherForecastProvider.future),
        child: weatherForecastAsyncValue.map(
          data: (asyncValue) {
            return CustomScrollView(
              slivers: [
                SliverList.builder(
                  itemBuilder: (context, index) {
                    final data = asyncValue.value[index];

                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        WeatherForecastAnimation(
                          classification: data.classification,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Opacity(
                                opacity: 0.7,
                                child: TimeAgo(date: data.createdAt),
                              ),
                              Text(
                                data.description,
                                style: context.textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  },
                  itemCount: asyncValue.value.length,
                ),
              ],
            );
          },
          error: (error) {
            return Column(
              children: [
                Text('Error: $error'),
                const Gap(20),
                IconButton(
                  onPressed: () =>
                      ref.refresh(getWeatherForecastProvider.future),
                  icon: const Icon(
                    Icons.refresh,
                  ),
                ),
              ],
            );
          },
          loading: (_) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}

class SunnyIcon extends StatelessWidget {
  const SunnyIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.sunny,
      size: 50,
      color: Colors.orange,
    );
  }
}

@riverpod
Country? selectedCountry(SelectedCountryRef ref) => null;

@riverpod
Future<List<WeatherForecast>> getWeatherForecast(
    GetWeatherForecastRef ref) async {
  return await ref.read(weatherForecastRepositoryProvider).get(
        country: ref.read(selectedCountryProvider),
      );
}
