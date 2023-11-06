import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/get_countries_service.dart';

part 'country_repository.g.dart';

class CountryRepository {
  CountryRepository({
    required GetCountriesService getCountriesService,
  }) : _getCountriesService = getCountriesService;

  final GetCountriesService _getCountriesService;

  Future<List<Country>> getCountries() async {
    final countries = await _getCountriesService();

    return countries.map((x) => Country.fromJson(x)).toList();
  }
}

@Riverpod(keepAlive: true)
CountryRepository countryRepository(CountryRepositoryRef ref) {
  return CountryRepository(
    getCountriesService: ref.read(getCountriesServiceProvider),
  );
}
