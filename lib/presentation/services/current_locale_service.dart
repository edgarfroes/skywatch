import 'package:flutter/material.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/presentation/l10n/l10n.dart';

part 'current_locale_service.g.dart';

@Riverpod(keepAlive: true)
class CurrentLocaleService extends _$CurrentLocaleService {
  @override
  Locale build() {
    final deviceLocale = WidgetsBinding.instance.platformDispatcher.locale;

    if (Localization.delegate.supportedLocales
        .any((x) => x.countryCode == deviceLocale.countryCode)) {
      return deviceLocale;
    }

    return Localization.delegate.supportedLocales.first;
  }

  void update(Locale locale) => state = locale;
}
