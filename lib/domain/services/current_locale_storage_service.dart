import 'dart:convert';
import 'dart:ui';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/key_value_storage_service.dart';
import 'package:skywatch/infrastructure/services/shared_preferences_service_mixin.dart';

part 'current_locale_storage_service.freezed.dart';
part 'current_locale_storage_service.g.dart';

class CurrentLocaleStorageService
    with SharedPreferencesServiceMixin<Locale>
    implements KeyValueStorageService<Locale> {
  @override
  String get key => 'currentLocale';

  @override
  final ObjectToStringParser<Locale>? parser = LocaleParser();
}

class LocaleParser implements ObjectToStringParser<Locale> {
  @override
  StringBuilderFromObject<Locale> stringBuilder() =>
      (value) => jsonEncode(LocaleParserData.fromLocale(value).toJson());

  @override
  ObjectBuilderFromString<Locale> objectBuilder() => (value) {
        final data = LocaleParserData.fromJson(jsonDecode(value));

        return Locale.fromSubtags(
          languageCode: data.languageCode,
          countryCode: data.countryCode,
        );
      };
}

@freezed
class LocaleParserData with _$LocaleParserData {
  @Implements<ObjectToStringParser<Locale>>()
  factory LocaleParserData._({
    required String languageCode,
    required String? countryCode,
  }) = _LocaleParserData;

  factory LocaleParserData.fromLocale(Locale locale) {
    return LocaleParserData._(
      languageCode: locale.languageCode,
      countryCode: locale.countryCode,
    );
  }

  factory LocaleParserData.fromJson(Map<String, dynamic> json) =>
      _$LocaleParserDataFromJson(json);
}

@riverpod
CurrentLocaleStorageService currentLocaleLocalStorageService(
    CurrentLocaleLocalStorageServiceRef ref) {
  return CurrentLocaleStorageService();
}
