import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/presentation/components/country_flag.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';

class SelectCountryButton extends HookConsumerWidget {
  const SelectCountryButton({
    super.key,
    required this.onCountrySelect,
    this.label = 'Country',
  });

  final Function(Country country) onCountrySelect;
  final String label;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCountry = useState<Country?>(null);

    return ListTile(
      leading: selectedCountry.value != null
          ? CountryFlag(countryCode: selectedCountry.value!.code)
          : null,
      title: selectedCountry.value != null
          ? Text(
              selectedCountry.value!.name,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
              ),
            )
          : Text(label),
      subtitle: selectedCountry.value != null
          ? const Text('tap to change')
          : const Text('tap to select'),
      onTap: () async {
        final newSelectedCountry =
            await ref.read(appRouterProvider).openCountrySelectionScreen(
                  selectedCountry: selectedCountry.value,
                );

        if (newSelectedCountry != null) {
          onCountrySelect(newSelectedCountry);

          selectedCountry.value = newSelectedCountry;
        }
      },
      tileColor: context.colorScheme.surfaceVariant
          .withOpacity(selectedCountry.value != null ? 1 : 0.3),
      trailing: selectedCountry.value != null
          ? Icon(
              Icons.mode_edit_outline_outlined,
              color: context.colorScheme.onSurfaceVariant.withOpacity(0.3),
            )
          : const Icon(Icons.chevron_right),
    );
  }
}
