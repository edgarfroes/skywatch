import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/skywatch_api_service.dart';

part 'get_countries_service.g.dart';

@Riverpod(keepAlive: true)
Future<List<Country>> getCountriesService(GetCountriesServiceRef ref) async {
  final data = await ref.read(skywatchApiServiceProvider).list(
        endpoint: '/v1/country',
      );

  return data.map(Country.fromJson).toList();
}
