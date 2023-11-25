import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/current_locale_storage_service.dart';
import 'package:skywatch/presentation/l10n/l10n.dart' as l10n;

part 'current_locale_service.g.dart';

@Riverpod(keepAlive: true)
class CurrentLocaleService extends _$CurrentLocaleService {
  CurrentLocaleService();

  @override
  FutureOr<Locale> build() async {
    final storedCurrentLocale =
        await ref.read(currentLocaleLocalStorageServiceProvider).read();

    if (storedCurrentLocale != null) {
      return storedCurrentLocale;
    }

    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

    if (l10n.Localization.delegate.supportedLocales
        .any((x) => x.countryCode == deviceLocale.countryCode)) {
      return deviceLocale;
    }

    return l10n.Localization.delegate.supportedLocales.first;
  }

  Future<void> save(Locale locale) async {
    await ref.read(currentLocaleLocalStorageServiceProvider).save(locale);

    state = AsyncValue.data(locale);
  }
}
