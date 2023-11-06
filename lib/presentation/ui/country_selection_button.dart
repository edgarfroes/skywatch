import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/app_router.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/presentation/ui/country_flag.dart';

part 'country_selection_button.g.dart';

class SelectCountryButton extends ConsumerWidget {
  const SelectCountryButton({
    super.key,
    required this.onCountrySelect,
    this.label = 'Country',
  });

  final Function(Country country) onCountrySelect;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = ref.watch(selectedCountryProvider);

    return ListTile(
      leading: selectedCountry != null
          ? CountryFlag(countryCode: selectedCountry.code)
          : null,
      title: selectedCountry != null
          ? Text(
              selectedCountry.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          : Text(label),
      subtitle: selectedCountry != null
          ? const Text('tap to change')
          : const Text('tap to select'),
      onTap: () async {
        final selectedCountry =
            await ref.read(appRouterProvider).openCountrySelectionScreen();

        if (selectedCountry != null) {
          onCountrySelect(selectedCountry);

          ref
              .read(selectedCountryProvider.notifier)
              .selectCountry(selectedCountry);
        }
      },
      tileColor: Theme.of(context)
          .colorScheme
          .surfaceVariant
          .withOpacity(selectedCountry != null ? 1 : 0.3),
      trailing: selectedCountry != null
          ? Icon(
              Icons.mode_edit_outline_outlined,
              color: Theme.of(context)
                  .colorScheme
                  .onSurfaceVariant
                  .withOpacity(0.3),
            )
          : const Icon(Icons.chevron_right),
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
