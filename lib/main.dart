import 'package:country_flags/country_flags.dart';
import 'package:flutter/material.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/country_service.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final service = CountryService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: FutureBuilder(
          future: service.getCountries(),
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
                  padding: const EdgeInsets.all(30),
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
