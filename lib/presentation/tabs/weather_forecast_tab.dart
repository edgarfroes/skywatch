import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/presentation/ui/country_selection_button.dart';

part 'weather_forecast_tab.g.dart';

@RoutePage()
class WeatherForecastTabScreen extends ConsumerWidget {
  const WeatherForecastTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ref.watch(selectedCountryProvider)?.name ?? 'WeatherForecastTab',
            ),
            const Gap(20),
            SelectCountryButton(
              onCountrySelect: (Country country) {
                ref
                    .read(selectedCountryProvider.notifier)
                    .selectCountry(country);
              },
            ),
          ],
        ),
      ),
    );
  }
}

@riverpod
class SelectedCountry extends _$SelectedCountry {
  @override
  Country? build() => null;

  void selectCountry(Country country) {
    state = country;
  }
}
