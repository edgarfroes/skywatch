import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/providers/get_countries_provider.dart';
import 'package:skywatch/presentation/components/country_search_list.dart';
import 'package:skywatch/presentation/components/retry.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';

@RoutePage()
class CountrySelectionScreen extends ConsumerWidget {
  // ignore: use_key_in_widget_constructors
  const CountrySelectionScreen({
    this.selectedCountry,
  });

  final Country? selectedCountry;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final countries = ref.watch(getCountriesProvider);

    final appRouter = ref.read(appRouterProvider);

    return Scaffold(
      body: countries.map(
        loading: (_) => const Center(child: CircularProgressIndicator()),
        data: (AsyncData<List<Country>> data) {
          if (data.value.isEmpty) {
            return const _Retry();
          }

          return CustomScrollView(
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
        error: (AsyncError<List<Country>> error) => const _Retry(),
      ),
    );
  }
}

class _Retry extends ConsumerWidget {
  const _Retry();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Retry(
      onRetry: () => ref.refresh(getCountriesProvider.future),
    );
  }
}
