import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/presentation/components/weather_forecast_animation.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';

class WeatherClassificationSelector extends HookConsumerWidget {
  const WeatherClassificationSelector({
    super.key,
    required this.onSelect,
    this.initialClassification,
  });

  final WeatherForecastClassification? initialClassification;

  final Function(WeatherForecastClassification classification) onSelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedClassification =
        useState<WeatherForecastClassification?>(null);

    final classificationName = {
      WeatherForecastClassification.clear:
          context.l10n.weather_classification_clear,
      WeatherForecastClassification.partlyCloudy:
          context.l10n.weather_classification_partly_cloudy,
      WeatherForecastClassification.cloudy:
          context.l10n.weather_classification_cloudy,
      WeatherForecastClassification.overcastDayRain:
          context.l10n.weather_classification_overcast_day_rain,
      WeatherForecastClassification.rainy:
          context.l10n.weather_classification_rainy,
      WeatherForecastClassification.snowy:
          context.l10n.weather_classification_snowy,
    };

    return ListTile(
      leading: selectedClassification.value != null
          ? SizedBox(
              width: 40,
              child: WeatherForecastAnimation(
                classification: selectedClassification.value!,
              ),
            )
          : null,
      title: Text(
        selectedClassification.value != null
            ? (classificationName[selectedClassification.value] ??
                selectedClassification.value!.name)
            : context.l10n.weather_classification_selector_empty_title,
        style: TextStyle(
          fontWeight:
              selectedClassification.value != null ? FontWeight.w500 : null,
        ),
      ),
      subtitle: Text(
        selectedClassification.value != null
            ? context.l10n.weather_classification_selector_tap_to_change
            : context.l10n.weather_classification_selector_tap_to_select,
      ),
      onTap: () async {
        final result = await showModalBottomSheet(
          context: context,
          builder: (BuildContext bc) {
            return SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Text(
                      context.l10n.system_localization_selector_title,
                      style: context.textTheme.titleMedium,
                    ),
                  ),
                  SingleChildScrollView(
                    child: Column(
                      children: WeatherForecastClassification.values.map(
                        (classification) {
                          return ListTile(
                            selectedColor: context.colorScheme.onSurfaceVariant,
                            selectedTileColor:
                                context.colorScheme.surfaceVariant,
                            leading: WeatherForecastAnimation(
                              classification: classification,
                            ),
                            title: Text(
                              classificationName[classification] ??
                                  classification.name,
                            ),
                            onTap: () {
                              Navigator.of(context).pop(classification);
                            },
                            minVerticalPadding: 15,
                          );
                        },
                      ).toList(),
                    ),
                  ),
                  const Gap(20),
                ],
              ),
            );
          },
        );

        if (result != null && result is WeatherForecastClassification) {
          selectedClassification.value = result;
          onSelect(result);
        }
      },
      tileColor: context.colorScheme.surfaceVariant
          .withOpacity(selectedClassification.value != null ? 1 : 0.3),
      trailing: selectedClassification.value != null
          ? Icon(
              Icons.mode_edit_outline_outlined,
              color: context.colorScheme.onSurfaceVariant.withOpacity(0.3),
            )
          : const Icon(Icons.chevron_right),
    );
  }
}
