import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/app_router.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';

// part 'main.g.dart';

void main() {
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (_, ref, __) {
          return MaterialApp.router(
            routerConfig: ref.read(appRouterProvider).config(
                  navigatorObservers: () => [
                    LoggerObserver(
                      loggerRepository: ref.read(loggerRepositoryProvider),
                    ),
                  ],
                ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4B87C5),
                // background: const Color.fromARGB(255, 31, 46, 54),
              ),
              useMaterial3: true,
            ),
          );
        },
      ),
    ),
  );
}

class LoggerObserver extends AutoRouterObserver {
  LoggerObserver({
    required this.loggerRepository,
  });

  final LoggerRepository loggerRepository;

  @override
  void didPush(Route route, Route? previousRoute) {
    loggerRepository.info(
      'Navigated to screen ${route.settings.name}${route.settings.arguments != null ? '\nArguments: ${route.settings.arguments}' : ''}',
    );
  }

  @override
  void didInitTabRoute(TabPageRoute route, TabPageRoute? previousRoute) {
    loggerRepository.info(
      'Navigated to Tab ${route.name}',
    );
  }

  @override
  void didChangeTabRoute(TabPageRoute route, TabPageRoute previousRoute) {
    loggerRepository.info('Navigated to Tab ${route.name}');
  }
}

// class MyApp extends ConsumerWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final countries = ref.watch(myAppCountriesProvider);

//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//         useMaterial3: true,
//       ),
//       home: Scaffold(
//         body: RefreshIndicator(
//           onRefresh: () => ref.refresh(myAppCountriesProvider.future),
//           child: countries.map(
//             loading: (_) => const CircularProgressIndicator(),
//             data: (AsyncData<List<Country>> data) {
//               return ListView.builder(
//                 itemBuilder: (context, index) {
//                   final country = data.value[index];

//                   return Padding(
//                     padding: const EdgeInsets.all(50),
//                     child: Row(
//                       children: [
//                         CountryFlag.fromCountryCode(
//                           country.countryCode,
//                           height: 40,
//                           width: 60,
//                         ),
//                         const Gap(20),
//                         Text(country.name),
//                       ],
//                     ),
//                   );
//                 },
//                 itemCount: data.value.length,
//               );
//             },
//             error: (AsyncError<List<Country>> error) {
//               return IconButton(
//                 onPressed: () => ref.refresh(myAppCountriesProvider.future),
//                 icon: const Icon(Icons.refresh),
//               );
//             },
//           ),
//         ),

//         //     FutureBuilder(
//         //   future: countries.,
//         //   builder:
//         //       (BuildContext context, AsyncSnapshot<List<Country>> snapshot) {
//         //     if (!snapshot.hasData) {
//         //       return const Center(
//         //         child: CircularProgressIndicator(),
//         //       );
//         //     }

//         //     return ListView.builder(
//         //       itemBuilder: (context, index) {
//         //         final country = snapshot.data![index];

//         //         return Padding(
//         //           padding: const EdgeInsets.all(50),
//         //           child: Row(
//         //             children: [
//         //               CountryFlag.fromCountryCode(
//         //                 country.countryCode,
//         //                 height: 40,
//         //                 width: 60,
//         //               ),
//         //               const SizedBox(
//         //                 width: 20,
//         //               ),
//         //               Text(country.name),
//         //             ],
//         //           ),
//         //         );
//         //       },
//         //       itemCount: snapshot.data!.length,
//         //     );
//         //   },
//         // ),
//       ),
//     );
//   }
// }

// @riverpod
// Future<List<Country>> myAppCountries(MyAppCountriesRef ref) =>
//     ref.read(countryRepositoryProvider).getCountries();
