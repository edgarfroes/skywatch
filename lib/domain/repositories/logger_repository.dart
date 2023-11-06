// ignore_for_file: avoid_print

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'logger_repository.g.dart';

abstract class Logger {
  void info(String message);
  void warning(String message);
  void error(String message, [Object? exception]);
}

class LoggerRepository extends Logger {
  final List<Logger> _loggers = [];

  void subscribe(Logger logger) {
    _loggers.add(logger);
  }

  void unsubscribe<T extends Logger>(T logger) {
    _loggers.removeWhere((x) => x is T);
  }

  @override
  void info(String message) {
    for (var logger in _loggers) {
      logger.info(message);
    }
  }

  @override
  void warning(String message) {
    for (var logger in _loggers) {
      logger.warning(message);
    }
  }

  @override
  void error(String message, [Object? exception]) {
    for (var logger in _loggers) {
      logger.error(message, exception);
    }
  }
}

@Riverpod(keepAlive: true)
LoggerRepository loggerRepository(LoggerRepositoryRef ref) {
  return LoggerRepository();
}