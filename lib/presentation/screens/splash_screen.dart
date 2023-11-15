import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/services/logger_service.dart';
import 'package:skywatch/infrastructure/console_logger.dart';
import 'package:skywatch/presentation/components/assets.gen.dart';
import 'package:skywatch/presentation/components/retry.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';

part 'splash_screen.g.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final watch = ref.watch(loadInitialDataProvider)
      ..whenOrNull(
        data: (_) {
          ref.read(appRouterProvider).goToHomeScreen();
        },
      );

    return Scaffold(
      body: watch.map(
        data: (_) => const _Loading(),
        error: (_) {
          return Retry(
            onRetry: () => ref.refresh(loadInitialDataProvider.future),
          );
        },
        loading: (_) => const _Loading(),
      ),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Gap(100),
          SvgPicture.asset(
            Assets.icon.iconSvg,
            width: 145,
          ),
          const Gap(60),
          SizedBox.fromSize(
            size: const Size.square(50),
            child: const CircularProgressIndicator(),
          ),
        ],
      ),
    );
  }
}

@riverpod
Future<void> loadInitialData(LoadInitialDataRef ref) async {
  final logger = ref.read(loggerProvider);

  if (kDebugMode) {
    logger.subscribe(ConsoleLogger());
  }

  logger.info('Loading initial dependencies');

  // Fake app loading screen.
  await Future.delayed(const Duration(seconds: 2));

  logger.info('Loaded dependencies');
}
