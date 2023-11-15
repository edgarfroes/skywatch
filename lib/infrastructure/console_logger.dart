// ignore_for_file: avoid_print

import 'package:skywatch/domain/services/logger_service.dart';

class ConsoleLogger extends Logger {
  @override
  void info(String message) {
    _print('📘 $message');
  }

  @override
  void warning(String message) {
    _print('📙 $message');
  }

  @override
  void error(String message, [Object? exception]) {
    _print(
      '📕 $message${exception != null ? '\n\nException: $exception' : ''}',
    );
  }

  _print(String text) {
    const separator = '===========================================';
    print('\n\n$separator\n$text\n$separator\n\n');
  }
}
