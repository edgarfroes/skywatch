import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/presentation/components/country_flag.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';

class CountrySelectionDropdown extends HookConsumerWidget {
  const CountrySelectionDropdown({
    super.key,
    required this.onCountrySelect,
    this.initialValue,
  });

  final Country? initialValue;
  final Function(Country? country) onCountrySelect;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = useState<Country?>(null);
    if (initialValue != selectedCountry.value) {
      selectedCountry.value = initialValue;
    }

    return Material(
      borderRadius: BorderRadius.circular(100),
      clipBehavior: Clip.antiAlias,
      color: context.colorScheme.surfaceVariant,
      child: InkWell(
        onTap: () async {
          if (selectedCountry.value != null) {
            onCountrySelect(null);
            selectedCountry.value = null;
            return;
          }

          final newSelectedCountry =
              await ref.read(appRouterProvider).openCountrySelectionScreen(
                    selectedCountry: selectedCountry.value,
                  );

          if (newSelectedCountry != null) {
            onCountrySelect(newSelectedCountry);

            selectedCountry.value = newSelectedCountry;
          }
        },
        child: Padding(
          padding: const EdgeInsets.only(
            top: 10,
            bottom: 10,
            left: 15,
            right: 10,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (selectedCountry.value != null) ...[
                CountryFlag(countryCode: selectedCountry.value!.code),
                const Gap(5),
              ],
              Text(
                selectedCountry.value?.name ??
                    context.l10n.country_selection_dropdown_select_country,
                style: TextStyle(
                  color: context.colorScheme.onSurface,
                  fontWeight:
                      selectedCountry.value != null ? FontWeight.w500 : null,
                ),
              ),
              if (selectedCountry.value != null) const Gap(5),
              Icon(
                selectedCountry.value != null
                    ? Icons.close
                    : Icons.arrow_drop_down,
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
