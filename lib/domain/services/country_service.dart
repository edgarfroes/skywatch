import 'package:iso_countries/iso_countries.dart' as iso_countries;
import 'package:skywatch/domain/entities/country.dart';
import 'package:intl/intl.dart';

class CountryService {
  Future<List<Country>> getCountries() async {
    final currentLocale = Intl.getCurrentLocale();

    return (await iso_countries.IsoCountries.isoCountriesForLocale(
            currentLocale))
        .map(
          (x) => Country(
            countryCode: x.countryCode,
            name: x.name,
          ),
        )
        .toList();
  }
}
