import 'package:flutter/material.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skywatch/presentation/components/async_value_absorb_pointer.dart';
import 'package:skywatch/presentation/components/async_value_builder.dart';
import 'package:skywatch/presentation/components/country_flag.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/services/current_locale_service.dart';
import 'package:skywatch/presentation/services/supported_locales_service.dart';

class SystemLocalizationSelector extends ConsumerWidget {
  const SystemLocalizationSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocaleAsync = ref.watch(currentLocaleServiceProvider);

    return AsyncValueAbsorbPointer(
      async: currentLocaleAsync,
      child: AsyncValueBuilder(
        async: currentLocaleAsync,
        builder: (BuildContext context, Locale currentLocale) {
          const double flagSize = 32;

          return TextButton(
            onPressed: () {
              showModalBottomSheet(
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
                              children: ref.read(supportedLocalesProvider).map(
                                (locale) {
                                  final selected = currentLocale.languageCode ==
                                      locale.languageCode;

                                  return ListTile(
                                    selected: selected,
                                    selectedColor:
                                        context.colorScheme.onSurfaceVariant,
                                    selectedTileColor:
                                        context.colorScheme.surfaceVariant,
                                    leading: SizedBox(
                                      width: flagSize,
                                      height: flagSize /
                                          CountryFlag.kFlagAspectRatio,
                                      child: CountryFlag(
                                        width: flagSize,
                                        countryCode: locale.countryCode ??
                                            locale.languageCode,
                                      ),
                                    ),
                                    title: Text(
                                      LocaleNames.of(context)
                                              ?.nameOf(locale.languageCode) ??
                                          locale.toLanguageTag(),
                                    ),
                                    titleTextStyle: TextStyle(
                                      fontWeight:
                                          selected ? FontWeight.w700 : null,
                                    ),
                                    onTap: () {
                                      ref
                                          .read(currentLocaleServiceProvider
                                              .notifier)
                                          .save(locale);

                                      Navigator.of(context).pop();
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
                  });
            },
            child: Row(
              children: [
                Text(
                  LocaleNames.of(context)?.nameOf(currentLocale.languageCode) ??
                      currentLocale.languageCode,
                ),
                const Gap(10),
                CountryFlag(
                  width: 15,
                  countryCode:
                      currentLocale.countryCode ?? currentLocale.languageCode,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
