import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/get_countries_service.dart';
import 'package:skywatch/presentation/components/async_value_absorb_pointer.dart';
import 'package:skywatch/presentation/components/country_search_list.dart';
import 'package:skywatch/presentation/components/retry.dart';
import 'package:skywatch/presentation/components/skeleton_loader.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';

@RoutePage()
class CountrySelectionScreen extends ConsumerWidget {
  const CountrySelectionScreen({
    super.key,
    this.selectedCountry,
  });

  final Country? selectedCountry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countriesAsync = ref.watch(getCountriesServiceProvider);

    final appRouter = ref.read(appRouterProvider);

    return Scaffold(
      body: AsyncValueAbsorbPointer(
        async: countriesAsync,
        child: countriesAsync.map(
          loading: (_) => const _CountrySelectionScreenSkeletonLoader(),
          data: (AsyncData<List<Country>> data) {
            if (data.value.isEmpty) {
              return Retry(
                title: 'We could not find any countries, please try again',
                onRetry: () => ref.refresh(getCountriesServiceProvider),
              );
            }

            return CustomScrollView(
              physics: const ClampingScrollPhysics(),
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: Text(appRouter.topRoute.pageTitle ?? 'Select country'),
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

            return Retry(
              onRetry: () => ref.refresh(getCountriesServiceProvider.future),
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
