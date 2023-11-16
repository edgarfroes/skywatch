import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/logger_service.dart';
import 'package:skywatch/presentation/components/country_flag.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:sliver_tools/sliver_tools.dart';

part 'country_search_list.freezed.dart';

class CountrySearchList extends HookConsumerWidget {
  const CountrySearchList({
    super.key,
    this.selectedCountry,
    required this.countries,
    required this.onTap,
  });

  final Country? selectedCountry;
  final List<Country> countries;
  final Function(Country country) onTap;

  final resultFilterAcceptedRatio = 90;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filteredText = useState<String>('');

    final resultsWithSimilarities = countries
        .map(
          (x) => SimilarResult(
            object: x,
            similarity: filteredText.value.isNotEmpty == true
                ? partialRatio(
                    filteredText.value,
                    x.name.toLowerCase(),
                  )
                : 0,
          ),
        )
        .toList();

    final similarResult = resultsWithSimilarities
        .where((x) => x.similarity >= resultFilterAcceptedRatio)
        .toList()
      ..sort((a, b) => a.similarity.compareTo(b.similarity));

    final searchResult = similarResult.map((x) => x.object as Country).toList();

    final currentCountryCode =
        WidgetsBinding.instance.platformDispatcher.locale.countryCode;

    final filteredCountries = resultsWithSimilarities
        .where((x) =>
            x.similarity < resultFilterAcceptedRatio &&
            currentCountryCode != (x.object as Country).code)
        .map((x) => x.object as Country)
        .toList();

    final currentCountry = resultsWithSimilarities
        .where((x) =>
            x.similarity < resultFilterAcceptedRatio &&
            currentCountryCode == (x.object as Country).code)
        .firstOrNull
        ?.object as Country?;

    return MultiSliver(
      children: [
        SliverPinnedHeader(
          child: ColoredBox(
            color: context.colorScheme.background,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: TextField(
                onChanged: (value) => filteredText.value = value,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  labelText:
                      context.l10n.country_search_list_filter_placeholder,
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  contentPadding: const EdgeInsets.all(0),
                  prefixIcon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
        ),
        if (searchResult.isNotEmpty == true) ...[
          SliverList.builder(
            itemBuilder: (context, index) {
              final country = searchResult[index];

              return _CountryWidget(
                country: country,
                selected: country == selectedCountry,
                onTap: () => onTap(country),
              );
            },
            itemCount: searchResult.length,
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            sliver: SliverToBoxAdapter(
              child: Opacity(
                opacity: 0.4,
                child: Text(context.l10n.country_search_list_other_results),
              ),
            ),
          ),
        ],
        if (searchResult.isEmpty && filteredText.value.trim().isNotEmpty)
          SliverPadding(
            padding: const EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(
              child: Text(
                context.l10n
                    .country_search_list_country_not_found(filteredText.value),
              ),
            ),
          ),
        if (currentCountry != null)
          SliverToBoxAdapter(
            child: _CountryWidget(
              selected: currentCountry == selectedCountry,
              country: currentCountry,
              onTap: () => onTap(currentCountry),
            ),
          ),
        SliverList.builder(
          itemBuilder: (context, index) {
            final country = filteredCountries[index];

            return _CountryWidget(
              selected: country == selectedCountry,
              country: country,
              onTap: () => onTap(country),
            );
          },
          itemCount: filteredCountries.length,
        ),
      ],
    );
  }
}

@freezed
class SimilarResult<T> with _$SimilarResult {
  factory SimilarResult({
    required int similarity,
    required T object,
  }) = _SimilarResult;
}

class _CountryWidget extends ConsumerWidget {
  const _CountryWidget({
    required this.country,
    required this.onTap,
    this.selected = false,
  });

  final Country country;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const double flagSize = 32;

    return ListTile(
      selected: selected,
      selectedColor: context.colorScheme.onSurfaceVariant,
      selectedTileColor: context.colorScheme.surfaceVariant,
      leading: SizedBox(
        width: flagSize,
        height: flagSize / CountryFlag.kFlagAspectRatio,
        child: CountryFlag(
          width: flagSize,
          countryCode: country.code,
          onErrorLoadingFlag: () {
            if (!ref.context.mounted) {
              return;
            }

            ref.read(loggerProvider).error(
                  'Couldn\'t load flag for country ${country.name}',
                  ErrorLoadingCountryFlagException(),
                );
          },
        ),
      ),
      title: Text(country.name),
      titleTextStyle: TextStyle(
        fontWeight: selected ? FontWeight.w700 : null,
      ),
      onTap: onTap,
      minVerticalPadding: 15,
      trailing: selected
          ? const Icon(
              Icons.check_circle,
              size: flagSize * 0.7,
              color: Colors.white,
            )
          : null,
    );
  }
}

class ErrorLoadingCountryFlagException implements Exception {}
