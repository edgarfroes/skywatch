import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/domain/services/get_weather_forecast_service.dart';
import 'package:skywatch/presentation/components/async_value_absorb_pointer.dart';
import 'package:skywatch/presentation/components/country_flag.dart';
import 'package:skywatch/presentation/components/country_selection_dropdown.dart';
import 'package:skywatch/presentation/components/retry.dart';
import 'package:skywatch/presentation/components/skeleton_loader.dart';
import 'package:skywatch/presentation/components/timeago.dart';
import 'package:skywatch/presentation/components/weather_forecast_animation.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/services/haptic_feedback_service.dart';

@RoutePage()
class WeatherForecastTabScreen extends HookConsumerWidget {
  const WeatherForecastTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = useState<Country?>(null);
    final weatherForecastAsync = ref.watch(
      getWeatherForecastServiceProvider(
        countryCode: selectedCountry.value?.code,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        scrolledUnderElevation: 0,
      ),
      body: AsyncValueAbsorbPointer(
        async: weatherForecastAsync,
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
                      selectedCountry.value = country;

                      await _refresh(ref, country);
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: weatherForecastAsync.when(
                data: (items) {
                  if (items.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                              'Be the first to upload a new weather forecast video'),
                          const Gap(20),
                          OutlinedButton(
                            onPressed:
                                ref.read(appRouterProvider).goToUploadVideoTab,
                            child: const Text('Upload video'),
                          )
                        ],
                      ),
                    );
                  }

                  return WeatherForecastList(
                    items: items,
                    showCountryFlag: selectedCountry.value == null,
                    onRefresh: () => _refresh(ref, selectedCountry.value),
                    onTap: (WeatherForecast weatherForecast) {
                      // TODO.
                    },
                  );
                },
                error: (ex, stackTrace) {
                  if (weatherForecastAsync.isLoading ||
                      weatherForecastAsync.isRefreshing) {
                    return const _WeatherForecastTabScreenSkeletonLoader();
                  }

                  return Retry(
                    title: 'An error has occurred, please try again',
                    onRetry: () => ref.refresh(
                      getWeatherForecastServiceProvider(
                        countryCode: selectedCountry.value?.code,
                      ).future,
                    ),
                  );
                },
                loading: () {
                  return const _WeatherForecastTabScreenSkeletonLoader();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<List<WeatherForecast>> _refresh(
    WidgetRef ref,
    Country? selectedCountry,
  ) async {
    final hapticFeedbackService = ref.read(hapticFeedbackServiceProvider);

    hapticFeedbackService.light();

    final items = await ref.refresh(
      getWeatherForecastServiceProvider(
        countryCode: selectedCountry?.code,
      ).future,
    );

    await hapticFeedbackService.success();

    return items;
  }
}

class WeatherForecastList extends StatelessWidget {
  const WeatherForecastList({
    super.key,
    required this.items,
    required this.showCountryFlag,
    required this.onRefresh,
    required this.onTap,
  });

  final List<WeatherForecast> items;
  final bool showCountryFlag;
  final Future<void> Function() onRefresh;
  final Function(WeatherForecast weatherForecast) onTap;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: CustomScrollView(
        slivers: [
          SliverList.builder(
            itemBuilder: (context, index) {
              final data = items[index];

              return InkWell(
                onTap: () => onTap(data),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    WeatherForecastAnimation(
                      classification: data.classification,
                    ),
                    const Gap(20),
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
                    if (showCountryFlag)
                      CountryFlag(
                        countryCode: data.countryCode,
                      ),
                    const Gap(20),
                  ],
                ),
              );
            },
            itemCount: items.length,
          ),
        ],
      ),
    );
  }
}

class _WeatherForecastTabScreenSkeletonLoader extends StatelessWidget {
  const _WeatherForecastTabScreenSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: SkeletonLoader(
          items: [
            SkeletonLoaderItem.row(
              [
                SkeletonLoaderItem.square(),
                SkeletonLoaderItem.spacer(),
                SkeletonLoaderItem.rectangle(),
              ],
            ),
            SkeletonLoaderItem.spacer(),
          ],
        ),
      ),
    );
  }
}
