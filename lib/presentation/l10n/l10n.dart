// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class Localization {
  Localization();

  static Localization? _current;

  static Localization get current {
    assert(_current != null,
        'No instance of Localization was loaded. Try to initialize the Localization delegate before accessing Localization.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<Localization> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = Localization();
      Localization._current = instance;

      return instance;
    });
  }

  static Localization of(BuildContext context) {
    final instance = Localization.maybeOf(context);
    assert(instance != null,
        'No instance of Localization present in the widget tree. Did you add Localization.delegate in localizationsDelegates?');
    return instance!;
  }

  static Localization? maybeOf(BuildContext context) {
    return Localizations.of<Localization>(context, Localization);
  }

  /// `Upload Video`
  String get bottom_navbar_upload_video {
    return Intl.message(
      'Upload Video',
      name: 'bottom_navbar_upload_video',
      desc: '',
      args: [],
    );
  }

  /// `View Weather`
  String get bottom_navbar_view_weather {
    return Intl.message(
      'View Weather',
      name: 'bottom_navbar_view_weather',
      desc: '',
      args: [],
    );
  }

  /// `Country "{countryName}" not found`
  String country_search_list_country_not_found(Object countryName) {
    return Intl.message(
      'Country "$countryName" not found',
      name: 'country_search_list_country_not_found',
      desc: '',
      args: [countryName],
    );
  }

  /// `Search country name`
  String get country_search_list_filter_placeholder {
    return Intl.message(
      'Search country name',
      name: 'country_search_list_filter_placeholder',
      desc: '',
      args: [],
    );
  }

  /// `Other results`
  String get country_search_list_other_results {
    return Intl.message(
      'Other results',
      name: 'country_search_list_other_results',
      desc: '',
      args: [],
    );
  }

  /// `Country`
  String get country_selection_button_label {
    return Intl.message(
      'Country',
      name: 'country_selection_button_label',
      desc: '',
      args: [],
    );
  }

  /// `tap to change`
  String get country_selection_button_tap_to_change {
    return Intl.message(
      'tap to change',
      name: 'country_selection_button_tap_to_change',
      desc: '',
      args: [],
    );
  }

  /// `tap to select`
  String get country_selection_button_tap_to_select {
    return Intl.message(
      'tap to select',
      name: 'country_selection_button_tap_to_select',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get country_selection_dropdown_select_country {
    return Intl.message(
      'Select country',
      name: 'country_selection_dropdown_select_country',
      desc: '',
      args: [],
    );
  }

  /// `We could not find any countries, please try again`
  String get country_selection_screen_empty_result {
    return Intl.message(
      'We could not find any countries, please try again',
      name: 'country_selection_screen_empty_result',
      desc: '',
      args: [],
    );
  }

  /// `Select country`
  String get country_selection_screen_title {
    return Intl.message(
      'Select country',
      name: 'country_selection_screen_title',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred`
  String get generic_error {
    return Intl.message(
      'An error has occurred',
      name: 'generic_error',
      desc: '',
      args: [],
    );
  }

  /// `Allow photos access`
  String get photo_permission_screen_permission_allow_photos_access {
    return Intl.message(
      'Allow photos access',
      name: 'photo_permission_screen_permission_allow_photos_access',
      desc: '',
      args: [],
    );
  }

  /// `We need your permission to access photo library`
  String get photo_permission_screen_permission_description {
    return Intl.message(
      'We need your permission to access photo library',
      name: 'photo_permission_screen_permission_description',
      desc: '',
      args: [],
    );
  }

  /// `Permission granted`
  String get photo_permission_screen_permission_granted {
    return Intl.message(
      'Permission granted',
      name: 'photo_permission_screen_permission_granted',
      desc: '',
      args: [],
    );
  }

  /// `Open app settings`
  String get photo_permission_screen_permission_open_app_settings {
    return Intl.message(
      'Open app settings',
      name: 'photo_permission_screen_permission_open_app_settings',
      desc: '',
      args: [],
    );
  }

  /// `Permission required`
  String get photo_permission_screen_permission_title {
    return Intl.message(
      'Permission required',
      name: 'photo_permission_screen_permission_title',
      desc: '',
      args: [],
    );
  }

  /// `Try again`
  String get retry_button_try_again {
    return Intl.message(
      'Try again',
      name: 'retry_button_try_again',
      desc: '',
      args: [],
    );
  }

  /// `Please select a language`
  String get system_localization_selector_title {
    return Intl.message(
      'Please select a language',
      name: 'system_localization_selector_title',
      desc: '',
      args: [],
    );
  }

  /// `Description`
  String get upload_video_tab_description {
    return Intl.message(
      'Description',
      name: 'upload_video_tab_description',
      desc: '',
      args: [],
    );
  }

  /// `Error while saving data. Please try again`
  String get upload_video_tab_error {
    return Intl.message(
      'Error while saving data. Please try again',
      name: 'upload_video_tab_error',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get upload_video_tab_save_button {
    return Intl.message(
      'Share',
      name: 'upload_video_tab_save_button',
      desc: '',
      args: [],
    );
  }

  /// `Select video to upload`
  String get upload_video_tab_select_video_to_upload {
    return Intl.message(
      'Select video to upload',
      name: 'upload_video_tab_select_video_to_upload',
      desc: '',
      args: [],
    );
  }

  /// `Data sent succesfully`
  String get upload_video_tab_success {
    return Intl.message(
      'Data sent succesfully',
      name: 'upload_video_tab_success',
      desc: '',
      args: [],
    );
  }

  /// `Upload Video`
  String get upload_video_tab_title {
    return Intl.message(
      'Upload Video',
      name: 'upload_video_tab_title',
      desc: '',
      args: [],
    );
  }

  /// `Clear`
  String get weather_classification_clear {
    return Intl.message(
      'Clear',
      name: 'weather_classification_clear',
      desc: '',
      args: [],
    );
  }

  /// `Cloudy`
  String get weather_classification_cloudy {
    return Intl.message(
      'Cloudy',
      name: 'weather_classification_cloudy',
      desc: '',
      args: [],
    );
  }

  /// `Overcast day rain`
  String get weather_classification_overcast_day_rain {
    return Intl.message(
      'Overcast day rain',
      name: 'weather_classification_overcast_day_rain',
      desc: '',
      args: [],
    );
  }

  /// `Partly cloudy`
  String get weather_classification_partly_cloudy {
    return Intl.message(
      'Partly cloudy',
      name: 'weather_classification_partly_cloudy',
      desc: '',
      args: [],
    );
  }

  /// `Rainy`
  String get weather_classification_rainy {
    return Intl.message(
      'Rainy',
      name: 'weather_classification_rainy',
      desc: '',
      args: [],
    );
  }

  /// `Select weather condition`
  String get weather_classification_selector_empty_title {
    return Intl.message(
      'Select weather condition',
      name: 'weather_classification_selector_empty_title',
      desc: '',
      args: [],
    );
  }

  /// `tap to change`
  String get weather_classification_selector_tap_to_change {
    return Intl.message(
      'tap to change',
      name: 'weather_classification_selector_tap_to_change',
      desc: '',
      args: [],
    );
  }

  /// `tap to select`
  String get weather_classification_selector_tap_to_select {
    return Intl.message(
      'tap to select',
      name: 'weather_classification_selector_tap_to_select',
      desc: '',
      args: [],
    );
  }

  /// `How's the weather?`
  String get weather_classification_selector_title {
    return Intl.message(
      'How\'s the weather?',
      name: 'weather_classification_selector_title',
      desc: '',
      args: [],
    );
  }

  /// `Snowy`
  String get weather_classification_snowy {
    return Intl.message(
      'Snowy',
      name: 'weather_classification_snowy',
      desc: '',
      args: [],
    );
  }

  /// `Be the first to upload a new weather forecast video on your region`
  String get weather_forecast_tab_empty_result {
    return Intl.message(
      'Be the first to upload a new weather forecast video on your region',
      name: 'weather_forecast_tab_empty_result',
      desc: '',
      args: [],
    );
  }

  /// `An error has occurred, please try again`
  String get weather_forecast_tab_error {
    return Intl.message(
      'An error has occurred, please try again',
      name: 'weather_forecast_tab_error',
      desc: '',
      args: [],
    );
  }

  /// `Posted in {countryName}`
  String weather_forecast_tab_posted_from(Object countryName) {
    return Intl.message(
      'Posted in $countryName',
      name: 'weather_forecast_tab_posted_from',
      desc: '',
      args: [countryName],
    );
  }

  /// `Update`
  String get weather_forecast_tab_refresh {
    return Intl.message(
      'Update',
      name: 'weather_forecast_tab_refresh',
      desc: '',
      args: [],
    );
  }

  /// `Weather`
  String get weather_forecast_tab_title {
    return Intl.message(
      'Weather',
      name: 'weather_forecast_tab_title',
      desc: '',
      args: [],
    );
  }

  /// `Upload video`
  String get weather_forecast_tab_upload_video {
    return Intl.message(
      'Upload video',
      name: 'weather_forecast_tab_upload_video',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<Localization> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
      Locale.fromSubtags(languageCode: 'pt', countryCode: 'BR'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<Localization> load(Locale locale) => Localization.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
