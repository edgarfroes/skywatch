import 'package:flutter/services.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';

part 'haptic_feedback_provider.g.dart';

class HapticFeedbackProvider {
  final LoggerRepository logger;

  HapticFeedbackProvider({
    required this.logger,
  });

  Future<void> light() async {
    logger.info('[LIGHT VIBRATION]');

    await HapticFeedback.lightImpact();
  }

  Future<void> medium() async {
    logger.info('[MEDIUM VIBRATION]');

    await HapticFeedback.mediumImpact();
  }

  Future<void> heavy() async {
    logger.info('[HEAVY VIBRATION]');

    await HapticFeedback.heavyImpact();
  }

  Future<void> success() async {
    logger.info('[SUCCESS VIBRATION]');

    // await HapticFeedback.heavyImpact();

    // await Future.delayed(const Duration(milliseconds: 300));
    await HapticFeedback.lightImpact();
    await Future.delayed(const Duration(milliseconds: 100));
    await HapticFeedback.lightImpact();
  }
}

@riverpod
HapticFeedbackProvider hapticFeedback(HapticFeedbackRef ref) =>
    HapticFeedbackProvider(
      logger: ref.read(loggerRepositoryProvider),
    );
