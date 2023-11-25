import 'dart:ui';

import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/presentation/l10n/l10n.dart';

part 'supported_locales_service.g.dart';

@riverpod
List<Locale> supportedLocales(SupportedLocalesRef ref) {
  return Localization.delegate.supportedLocales;
}
