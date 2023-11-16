// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a pt_BR locale. All the
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
  String get localeName => 'pt_BR';

  static String m0(countryName) => "País \"${countryName}\" não encontrado";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "bottom_navbar_upload_video":
            MessageLookupByLibrary.simpleMessage("Enviar Vídeo"),
        "bottom_navbar_view_weather":
            MessageLookupByLibrary.simpleMessage("Ver Clima"),
        "country_search_list_country_not_found": m0,
        "country_search_list_filter_placeholder":
            MessageLookupByLibrary.simpleMessage("Pesquisar nome do país"),
        "country_search_list_other_results":
            MessageLookupByLibrary.simpleMessage("Outros resultados"),
        "country_selection_button_label":
            MessageLookupByLibrary.simpleMessage("País"),
        "country_selection_button_tap_to_change":
            MessageLookupByLibrary.simpleMessage("toque para mudar"),
        "country_selection_button_tap_to_select":
            MessageLookupByLibrary.simpleMessage("toque para selecionar"),
        "country_selection_dropdown_select_country":
            MessageLookupByLibrary.simpleMessage("Selecionar país"),
        "country_selection_screen_empty_result":
            MessageLookupByLibrary.simpleMessage(""),
        "country_selection_screen_title":
            MessageLookupByLibrary.simpleMessage("Selecionar país"),
        "photo_permission_screen_permission_allow_photos_access":
            MessageLookupByLibrary.simpleMessage("Permitir acesso"),
        "photo_permission_screen_permission_description":
            MessageLookupByLibrary.simpleMessage(
                "Precisamos da sua permissão para acessar a galeria de fotos"),
        "photo_permission_screen_permission_granted":
            MessageLookupByLibrary.simpleMessage("Permissão concedida"),
        "photo_permission_screen_permission_open_app_settings":
            MessageLookupByLibrary.simpleMessage("Abrir configurações"),
        "photo_permission_screen_permission_title":
            MessageLookupByLibrary.simpleMessage("Permissão necessária"),
        "retry_button_try_again":
            MessageLookupByLibrary.simpleMessage("Tente novamente"),
        "upload_video_tab_select_video_to_upload":
            MessageLookupByLibrary.simpleMessage("Selecione o vídeo a enviar"),
        "upload_video_tab_title":
            MessageLookupByLibrary.simpleMessage("Enviar vídeo"),
        "weather_forecast_tab_empty_result": MessageLookupByLibrary.simpleMessage(
            "Seja o primeiro a enviar um novo vídeo do cllima na sua região"),
        "weather_forecast_tab_error": MessageLookupByLibrary.simpleMessage(
            "Ocorreu um erro, por favor tente novamente"),
        "weather_forecast_tab_title":
            MessageLookupByLibrary.simpleMessage("Clima"),
        "weather_forecast_tab_upload_video":
            MessageLookupByLibrary.simpleMessage("Enviar vídeo")
      };
}
