import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_localized_locales/flutter_localized_locales.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/domain/services/logger_service.dart';
import 'package:skywatch/presentation/components/async_value_builder.dart';
import 'package:skywatch/presentation/l10n/l10n.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/navigation/navigation_logger_observer.dart';
import 'package:skywatch/presentation/services/current_locale_service.dart';
import 'package:skywatch/presentation/services/supported_locales_service.dart';

void main() {
  runApp(
    ProviderScope(
      child: Consumer(
        builder: (_, ref, __) {
          return AsyncValueBuilder(
            async: ref.watch(currentLocaleServiceProvider),
            builder: (context, currentLocale) {
              return MaterialApp.router(
                routerConfig: ref.read(appRouterProvider).config(
                      navigatorObservers: () => [
                        NavigationLoggerObserver(
                          logger: ref.read(loggerProvider),
                        ),
                      ],
                    ),
                debugShowCheckedModeBanner: false,
                localizationsDelegates: const [
                  Localization.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                  LocaleNamesLocalizationsDelegate(),
                ],
                supportedLocales: ref.read(supportedLocalesProvider),
                locale: currentLocale,
                theme: ThemeData(
                  colorScheme: ColorScheme.fromSeed(
                    seedColor: const Color(0xFF4B87C5),
                    brightness: Brightness.dark,
                  ),
                  useMaterial3: true,
                ),
              );
            },
          );
        },
      ),
    ),
  );
}
