import 'package:iso_countries/iso_countries.dart' show IsoCountries;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/presentation/services/current_locale_service.dart';

part 'get_countries_for_current_locale_service.g.dart';

@Riverpod(keepAlive: true)
Future<List<Country>> getCountriesForCurrentLocaleService(
    GetCountriesForCurrentLocaleServiceRef ref) async {
  final locale = await ref.watch(currentLocaleServiceProvider.future);

  final countries = await IsoCountries.isoCountriesForLocale(
    locale.languageCode,
  );

  return countries
      .map(
        (x) => Country(
          code: x.countryCode,
          name: x.name,
        ),
      )
      .toList();
}
