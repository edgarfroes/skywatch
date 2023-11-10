import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/navigation/navigation_logger_observer.dart';

void main() {
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (_, ref, __) {
          return MaterialApp.router(
            routerConfig: ref.read(appRouterProvider).config(
                  navigatorObservers: () => [
                    NavigationLoggerObserver(
                      loggerRepository: ref.read(loggerRepositoryProvider),
                    ),
                  ],
                ),
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(
                seedColor: const Color(0xFF4B87C5),
                brightness: Brightness.dark,
              ),
              useMaterial3: true,
            ),
          );
        },
      ),
    ),
  );
}
