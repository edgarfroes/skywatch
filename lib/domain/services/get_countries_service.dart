import 'dart:ui';

import 'package:iso_countries/iso_countries.dart' as iso_countries;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';

part 'get_countries_service.g.dart';

@Riverpod(keepAlive: true)
Future<List<Country>> getCountriesService(
    GetCountriesServiceRef ref, Locale locale) async {
  final countries = await iso_countries.IsoCountries.isoCountriesForLocale(
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
