import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';

part 'skywatch_api_service.g.dart';

class SkywatchApiService {
  final String apiUrl;
  final LoggerRepository loggerRepository;

  SkywatchApiService({
    required this.apiUrl,
    required this.loggerRepository,
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

      loggerRepository.info('HTTP Request: ${response.request}');

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
      loggerRepository.error(
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
      body: data,
    );

    loggerRepository.info('HTTP Request: ${response.request}');

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
      defaultValue: 'http://192.168.1.14:8080',
    ),
    loggerRepository: ref.read(loggerRepositoryProvider),
  );
}
