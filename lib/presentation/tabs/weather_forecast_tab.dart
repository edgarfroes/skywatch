import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/domain/repositories/weather_forecast_repository.dart';
import 'package:skywatch/presentation/components/country_flag.dart';
import 'package:skywatch/presentation/components/country_selection_dropdown.dart';
import 'package:skywatch/presentation/components/retry.dart';
import 'package:skywatch/presentation/components/timeago.dart';
import 'package:skywatch/presentation/components/weather_forecast_animation.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/providers/haptic_feedback_provider.dart';

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
      body: AbsorbPointer(
        absorbing: weatherForecastAsyncValue.isLoading &&
            !weatherForecastAsyncValue.hasError,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Row(
                children: [
                  CountrySelectionDropdown(
                    onCountrySelect: (Country? country) async {
                      ref
                          .read(weatherForecastTabSelectedCountryProvider
                              .notifier)
                          .selectCountry(country);

                      await _refresh(ref);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: weatherForecastAsyncValue.map(
                data: (asyncValue) {
                  if (asyncValue.value.isEmpty) {
                    return const Center(child: Text('No results'));
                  }

                  return RefreshIndicator(
                    onRefresh: () async {
                      await _refresh(ref);
                    },
                    child: CustomScrollView(
                      slivers: [
                        SliverList.builder(
                          itemBuilder: (context, index) {
                            final data = asyncValue.value[index];

                            return InkWell(
                              onTap: () {
                                //
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  WeatherForecastAnimation(
                                    classification: data.classification,
                                  ),
                                  const Gap(20),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
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
                                  if (ref.watch(
                                          weatherForecastTabSelectedCountryProvider) ==
                                      null)
                                    CountryFlag(
                                      countryCode: data.countryCode,
                                    ),
                                  const Gap(20),
                                ],
                              ),
                            );
                          },
                          itemCount: asyncValue.value.length,
                        ),
                      ],
                    ),
                  );
                },
                error: (error) {
                  return Retry(
                    onRetry: () =>
                        ref.refresh(getWeatherForecastProvider.future),
                  );
                },
                loading: (_) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _refresh(WidgetRef ref) {
    final hapticFeedbackService = ref.read(hapticFeedbackProvider);

    hapticFeedbackService.light();

    final refreshable = ref.refresh(getWeatherForecastProvider.future);

    refreshable.whenComplete(hapticFeedbackService.success);

    // ignore: unnecessary_cast
    return refreshable as Future;
  }
}

@riverpod
class WeatherForecastTabSelectedCountry
    extends _$WeatherForecastTabSelectedCountry {
  @override
  Country? build() => null;

  void selectCountry(Country? country) {
    state = country;
  }
}

@riverpod
Future<List<WeatherForecast>> getWeatherForecast(
    GetWeatherForecastRef ref) async {
  final country = ref.watch(weatherForecastTabSelectedCountryProvider);

  return await ref.read(weatherForecastRepositoryProvider).get(
        country: country,
      );
}
