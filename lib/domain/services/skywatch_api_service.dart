import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/logger_service.dart';

part 'skywatch_api_service.g.dart';

class SkywatchApiService {
  final String apiUrl;
  final LoggerService logger;

  SkywatchApiService({
    required this.apiUrl,
    required this.logger,
  });

  Future<void> get fakeDelay => Future.delayed(const Duration(seconds: 1));

  Future<List<Map<String, dynamic>>> list({
    required String endpoint,
    Map<String, String>? queryParams,
  }) async {
    try {
      await fakeDelay;

      final uri = Uri.parse('$apiUrl$endpoint').replace(
        queryParameters: queryParams,
      );

      final response = await http.get(uri);

      logger.info('HTTP Request: ${response.request}');

      _handleResponseErrors(response);

      final result = jsonDecode(response.body);

      if (result is! List) {
        throw HttpInvalidResponseFormatException();
      }

      try {
        return result.cast<Map<String, dynamic>>();
      } catch (e) {
        throw HttpInvalidResponseFormatException();
      }
    } catch (ex) {
      logger.error(
        'Error executing API get',
        ex,
      );

      rethrow;
    }
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
      Uri.parse('$apiUrl$endpoint'),
      body: jsonEncode(data),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    logger.info('HTTP Request: ${response.request}');

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

@Riverpod(keepAlive: true)
SkywatchApiService skywatchApiService(SkywatchApiServiceRef ref) {
  return SkywatchApiService(
    apiUrl: const String.fromEnvironment(
      'SKYWATCH_API_URL',
      defaultValue: 'http://localhost:8080',
    ),
    logger: ref.read(loggerProvider),
  );
}
