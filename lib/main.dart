import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/repositories/country_repository.dart';

void main() {
  runApp(const ProviderScope(
    child: MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: ref.read(countryRepositoryProvider).getCountries(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return ListView.builder(
              itemBuilder: (context, index) {
                final country = snapshot.data![index];

                return Padding(
                  padding: const EdgeInsets.all(50),
                  child: Row(
                    children: [
                      CountryFlag.fromCountryCode(
                        country.countryCode,
                        height: 40,
                        width: 60,
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Text(country.name),
                    ],
                  ),
                );
              },
              itemCount: snapshot.data!.length,
            );
          },
        ),
      ),
    );
  }
}
