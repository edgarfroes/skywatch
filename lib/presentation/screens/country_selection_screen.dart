import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/get_countries_service.dart';
import 'package:skywatch/presentation/components/async_value_absorb_pointer.dart';
import 'package:skywatch/presentation/components/country_search_list.dart';
import 'package:skywatch/presentation/components/retry_button.dart';
import 'package:skywatch/presentation/components/skeleton_loader.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/l10n/l10n.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/services/current_locale_service.dart';

@RoutePage()
class CountrySelectionScreen extends ConsumerWidget {
  const CountrySelectionScreen({
    super.key,
    this.selectedCountry,
  });

  final Country? selectedCountry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(currentLocaleServiceProvider);

    final countriesAsync =
        ref.watch(getCountriesServiceProvider(currentLocale));

    final appRouter = ref.read(appRouterProvider);

    return Scaffold(
      body: AsyncValueAbsorbPointer(
        async: countriesAsync,
        child: countriesAsync.map(
          loading: (_) => const _CountrySelectionScreenSkeletonLoader(),
          data: (AsyncData<List<Country>> data) {
            if (data.value.isEmpty) {
              return RetryButton(
                title: context.l10n.country_selection_screen_empty_result,
                onRetry: () =>
                    ref.refresh(getCountriesServiceProvider(currentLocale)),
              );
            }

            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: Text(
                    appRouter.topRoute.pageTitle ??
                        Localization.current.country_selection_screen_title,
                  ),
                  scrolledUnderElevation: 0,
                ),
                SliverPadding(
                  padding: EdgeInsets.only(
                    bottom: context.safeAreaPadding.bottom,
                  ),
                  sliver: CountrySearchList(
                    selectedCountry: selectedCountry,
                    countries: data.value,
                    onTap: ref.read(appRouterProvider).pop,
                  ),
                ),
              ],
            );
          },
          error: (AsyncError<List<Country>> error) {
            if (countriesAsync.isLoading || countriesAsync.isRefreshing) {
              return const _CountrySelectionScreenSkeletonLoader();
            }

            return RetryButton(
              onRetry: () => ref.refresh(
                getCountriesServiceProvider(currentLocale).future,
              ),
            );
          },
        ),
      ),
    );
  }
}

class _CountrySelectionScreenSkeletonLoader extends StatelessWidget {
  const _CountrySelectionScreenSkeletonLoader();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: SkeletonLoader(
          items: [
            SkeletonLoaderItem.chip(),
            SkeletonLoaderItem.spacer(50),
            SkeletonLoaderItem.rectangle(70),
            SkeletonLoaderItem.spacer(20),
          ],
        ),
      ),
    );
  }
}
