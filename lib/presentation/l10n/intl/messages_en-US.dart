// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en_US locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en_US';

  static String m0(countryName) => "Country \"${countryName}\" not found";

  static String m1(countryName) => "Posted in ${countryName}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bottom_navbar_upload_video":
            MessageLookupByLibrary.simpleMessage("Upload Video"),
        "bottom_navbar_view_weather":
            MessageLookupByLibrary.simpleMessage("View Weather"),
        "country_search_list_country_not_found": m0,
        "country_search_list_filter_placeholder":
            MessageLookupByLibrary.simpleMessage("Search country name"),
        "country_search_list_other_results":
            MessageLookupByLibrary.simpleMessage("Other results"),
        "country_selection_button_label":
            MessageLookupByLibrary.simpleMessage("Country"),
        "country_selection_button_tap_to_change":
            MessageLookupByLibrary.simpleMessage("tap to change"),
        "country_selection_button_tap_to_select":
            MessageLookupByLibrary.simpleMessage("tap to select"),
        "country_selection_dropdown_select_country":
            MessageLookupByLibrary.simpleMessage("Select country"),
        "country_selection_screen_empty_result":
            MessageLookupByLibrary.simpleMessage(
                "We could not find any countries, please try again"),
        "country_selection_screen_title":
            MessageLookupByLibrary.simpleMessage("Select country"),
        "generic_error":
            MessageLookupByLibrary.simpleMessage("An error has occurred"),
        "photo_permission_screen_permission_allow_photos_access":
            MessageLookupByLibrary.simpleMessage("Allow photos access"),
        "photo_permission_screen_permission_description":
            MessageLookupByLibrary.simpleMessage(
                "We need your permission to access photo library"),
        "photo_permission_screen_permission_granted":
            MessageLookupByLibrary.simpleMessage("Permission granted"),
        "photo_permission_screen_permission_open_app_settings":
            MessageLookupByLibrary.simpleMessage("Open app settings"),
        "photo_permission_screen_permission_title":
            MessageLookupByLibrary.simpleMessage("Permission required"),
        "retry_button_try_again":
            MessageLookupByLibrary.simpleMessage("Try again"),
        "system_localization_selector_title":
            MessageLookupByLibrary.simpleMessage("Please select a language"),
        "upload_video_tab_description":
            MessageLookupByLibrary.simpleMessage("Description"),
        "upload_video_tab_error": MessageLookupByLibrary.simpleMessage(
            "Error while saving data. Please try again"),
        "upload_video_tab_save_button":
            MessageLookupByLibrary.simpleMessage("Share"),
        "upload_video_tab_select_video_to_upload":
            MessageLookupByLibrary.simpleMessage("Select video to upload"),
        "upload_video_tab_success":
            MessageLookupByLibrary.simpleMessage("Data sent succesfully"),
        "upload_video_tab_title":
            MessageLookupByLibrary.simpleMessage("Upload Video"),
        "weather_classification_clear":
            MessageLookupByLibrary.simpleMessage("Clear"),
        "weather_classification_cloudy":
            MessageLookupByLibrary.simpleMessage("Cloudy"),
        "weather_classification_overcast_day_rain":
            MessageLookupByLibrary.simpleMessage("Overcast day rain"),
        "weather_classification_partly_cloudy":
            MessageLookupByLibrary.simpleMessage("Partly cloudy"),
        "weather_classification_rainy":
            MessageLookupByLibrary.simpleMessage("Rainy"),
        "weather_classification_selector_empty_title":
            MessageLookupByLibrary.simpleMessage("Select weather condition"),
        "weather_classification_selector_tap_to_change":
            MessageLookupByLibrary.simpleMessage("tap to change"),
        "weather_classification_selector_tap_to_select":
            MessageLookupByLibrary.simpleMessage("tap to select"),
        "weather_classification_selector_title":
            MessageLookupByLibrary.simpleMessage("How\'s the weather?"),
        "weather_classification_snowy":
            MessageLookupByLibrary.simpleMessage("Snowy"),
        "weather_forecast_tab_empty_result": MessageLookupByLibrary.simpleMessage(
            "Be the first to upload a new weather forecast video on your region"),
        "weather_forecast_tab_error": MessageLookupByLibrary.simpleMessage(
            "An error has occurred, please try again"),
        "weather_forecast_tab_posted_from": m1,
        "weather_forecast_tab_refresh":
            MessageLookupByLibrary.simpleMessage("Update"),
        "weather_forecast_tab_title":
            MessageLookupByLibrary.simpleMessage("Weather"),
        "weather_forecast_tab_upload_video":
            MessageLookupByLibrary.simpleMessage("Upload video")
      };
}
