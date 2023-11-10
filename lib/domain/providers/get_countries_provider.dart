import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/get_countries_service.dart';

part 'get_countries_provider.g.dart';

@Riverpod(keepAlive: true)
Future<List<Country>> getCountries(GetCountriesRef ref) async {
  final countries = await ref.read(getCountriesServiceProvider)();

  return countries.map((x) => Country.fromJson(x)).toList();
}
