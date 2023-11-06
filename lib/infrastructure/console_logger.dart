// ignore_for_file: avoid_print

import 'package:skywatch/domain/repositories/logger_repository.dart';

class ConsoleLogger extends Logger {
  @override
  void info(String message) {
    print('📘 $message');
  }

  @override
  void warning(String message) {
    print('📙 $message');
  }

  @override
  void error(String message, [Object? exception]) {
    print('📕 $message');

    if (exception != null) {
      print('Exception: $exception');
    }
  }
}
