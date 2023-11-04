import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'skywatch_api_service.g.dart';

class SkywatchApiService {
  final String apiUrl;

  SkywatchApiService(this.apiUrl);

  Future<List<Map<String, dynamic>>> list({
    required String endpoint,
    Map<String, String>? queryParams,
  }) async {
    final uri = Uri.parse('$apiUrl/$endpoint');

    if (queryParams?.isNotEmpty == true) {
      uri.queryParameters.addEntries(
        queryParams!.keys.map((x) => MapEntry(x, queryParams[x] as String)),
      );
    }

    final response = await http.get(uri);

    _handleResponseErrors(response);

    final result = jsonDecode(response.body);

    if (result! is List<Map<String, dynamic>>) {
      throw HttpInvalidResponseFormatException();
    }

    return result;
  }

  void _handleResponseErrors(http.Response response) {
    if (response.statusCode != 200) {
      throw HttpStatusCodeError(
        message: response.reasonPhrase,
        statusCode: response.statusCode,
      );
    }
  }

  Future<void> post({
    required String endpoint,
    required Map<String, dynamic> data,
  }) async {
    final response = await http.post(
      Uri.parse('$apiUrl/$endpoint'),
      body: data,
    );

    _handleResponseErrors(response);
  }
}

class HttpInvalidResponseFormatException implements Exception {}

class HttpStatusCodeError implements Exception {
  final int statusCode;
  final String? message;

  HttpStatusCodeError({
    required this.statusCode,
    required this.message,
  });
}

@riverpod
SkywatchApiService skywatchApiService(SkywatchApiServiceRef ref) {
  return SkywatchApiService(
    const String.fromEnvironment(
      'SKYWATCH_API_URL',
      defaultValue: 'http://localhost:4331',
    ),
  );
}
