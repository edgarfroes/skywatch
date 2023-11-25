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
import 'package:skywatch/presentation/components/async_value_builder.dart';
import 'package:skywatch/presentation/components/retry_button.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/services/current_locale_service.dart';
import 'package:timeago/timeago.dart' as timeago;

part 'splash_screen.g.dart';

@RoutePage()
class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: AsyncValueBuilder(
        async: ref.watch(loadInitialDataProvider),
        onDataCallback: (data) {
          ref.read(appRouterProvider).goToHomeScreen();
        },
        builder: (BuildContext context, _) {
          return const _Loading();
        },
        errorBuilder: (_) {
          return RetryButton(
            onRetry: () => ref.refresh(loadInitialDataProvider.future),
          );
        },
        loadingBuilder: (_) => const _Loading(),
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

  timeago.setLocaleMessages('pt', timeago.PtBrMessages());

  await ref.read(currentLocaleServiceProvider.future);

  // Fake app loading screen.
  await Future.delayed(const Duration(seconds: 1));

  logger.info('Loaded dependencies');
}
