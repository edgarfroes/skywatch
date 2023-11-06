import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:fuzzywuzzy/fuzzywuzzy.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/app_router.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/repositories/country_repository.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';
import 'package:skywatch/presentation/ui/country_flag.dart';
import 'package:sliver_tools/sliver_tools.dart';

part 'country_selection_screen.freezed.dart';
part 'country_selection_screen.g.dart';

@RoutePage()
class CountrySelectionScreen extends ConsumerWidget {
  const CountrySelectionScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countries = ref.watch(getCountriesProvider);

    final appRouter = ref.read(appRouterProvider);

    const resultFilterAcceptedRatio = 90;

    return Scaffold(
      body: countries.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        data: (AsyncData<List<Country>> data) {
          if (data.value.isEmpty) {
            return const _Retry();
          }

          final filteredText =
              ref.watch(filterTextProvider)?.trim().toLowerCase();

          final resultsWithSimilarities = List.from(data.value)
              .map(
                (x) => SimilarResult(
                  object: x,
                  similarity: filteredText?.isNotEmpty == true
                      ? partialRatio(
                          filteredText!,
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

          final searchResult =
              similarResult.map((x) => x.object as Country).toList();

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

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                title: Text(appRouter.topRoute.pageTitle ?? 'Select country'),
                pinned: true,
                scrolledUnderElevation: 0,
              ),
              SliverPinnedHeader(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.background,
                  child: SafeArea(
                    top: false,
                    bottom: false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        right: 20,
                        bottom: 20,
                      ),
                      child: TextField(
                        onChanged: ref.read(filterTextProvider.notifier).update,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          labelText: 'Search country name',
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          contentPadding: const EdgeInsets.all(0),
                          prefixIcon: const Icon(Icons.search),
                        ),
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
                      onTap: () => ref.read(appRouterProvider).pop(country),
                    );
                  },
                  itemCount: searchResult.length,
                ),
                const SliverPadding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  sliver: SliverToBoxAdapter(
                    child: Opacity(
                      opacity: 0.4,
                      child: Text('Other results'),
                    ),
                  ),
                ),
              ],
              if (currentCountry != null)
                SliverToBoxAdapter(
                  child: _CountryWidget(
                    country: currentCountry,
                    onTap: () =>
                        ref.read(appRouterProvider).pop(currentCountry),
                  ),
                ),
              SliverList.builder(
                itemBuilder: (context, index) {
                  final country = filteredCountries[index];

                  return _CountryWidget(
                    country: country,
                    onTap: () => ref.read(appRouterProvider).pop(country),
                  );
                },
                itemCount: filteredCountries.length,
              ),
            ],
          );
        },
        error: (AsyncError<List<Country>> error) => const _Retry(),
      ),
    );
  }
}

class _Retry extends ConsumerWidget {
  const _Retry();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Center(
      child: IconButton(
        onPressed: () => ref.refresh(getCountriesProvider.future),
        icon: const Icon(Icons.refresh),
      ),
    );
  }
}

class _CountryWidget extends ConsumerWidget {
  const _CountryWidget({
    required this.country,
    required this.onTap,
  });

  final Country country;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListTile(
      leading: CountryFlag(
        countryCode: country.code,
        onErrorLoadingFlag: () {
          ref.read(loggerRepositoryProvider).error(
                'Couldn\'t load flag for country ${country.name}',
                CountryFlagNotFoundException(),
              );
        },
      ),
      title: Text(country.name),
      onTap: onTap,
      minVerticalPadding: 15,
    );
  }
}

@riverpod
class FilterText extends _$FilterText {
  @override
  String? build() => null;

  void update(String? text) => state = text;
}

@riverpod
Future<List<Country>> getCountries(GetCountriesRef ref) =>
    ref.read(countryRepositoryProvider).getCountries();

class CountryFlagNotFoundException implements Exception {}

@freezed
class SimilarResult<T> with _$SimilarResult {
  factory SimilarResult({
    required int similarity,
    required T object,
  }) = _SimilarResult;
}
