import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';
import 'package:skywatch/infrastructure/console_logger.dart';
import 'package:skywatch/presentation/components/assets.gen.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';

part 'loading_screen.g.dart';

@RoutePage()
class LoadingScreen extends ConsumerWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(loadInitialDataProvider);

    watch.whenOrNull(
      data: (_) {
        ref.read(appRouterProvider).goToHomeScreen();
      },
    );

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              Assets.icon.iconSvg,
              width: 200,
            ),
            const Gap(50),
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}

@riverpod
Future<void> loadInitialData(LoadInitialDataRef ref) async {
  final loggerRepository = ref.read(loggerRepositoryProvider);

  if (kDebugMode) {
    loggerRepository.subscribe(ConsoleLogger());
  }

  loggerRepository.info('Loading initial dependencies');

  // Fake app loading screen.
  await Future.delayed(const Duration(seconds: 2));

  loggerRepository.info('Loaded dependencies');
}
