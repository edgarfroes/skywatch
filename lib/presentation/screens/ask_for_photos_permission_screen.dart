import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skywatch/presentation/components/retry_button.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/services/photos_permission_service.dart';

@RoutePage()
class AskForPhotosPermissionScreen extends ConsumerWidget {
  const AskForPhotosPermissionScreen({
    super.key,
    this.popWhenGranted = false,
  });

  final bool popWhenGranted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosPermission = ref.watch(photosPermissionServiceProvider);

    photosPermission.whenData((value) {
      if (value.isGranted) {
        ref.read(appRouterProvider).pop(value);
      }
    });

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                context.l10n.photo_permission_screen_permission_title,
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(50),
              Text(
                context.l10n.photo_permission_screen_permission_description,
                style: context.textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              const Gap(50),
              const Icon(
                Icons.photo,
                size: 100,
              ),
              const Gap(50),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: photosPermission.when(
                    data: (status) {
                      if (status.isGranted) {
                        return OutlinedButton(
                          onPressed: null,
                          child: Text(context
                              .l10n.photo_permission_screen_permission_granted),
                        );
                      }

                      if (status.isPermanentlyDenied) {
                        return OutlinedButton(
                          onPressed: () async {
                            ref
                                .read(openAppPermissionSettingsProvider)
                                .whenData((opened) {
                              if (opened) {}
                            });
                          },
                          child: Text(
                            context.l10n
                                .photo_permission_screen_permission_open_app_settings,
                          ),
                        );
                      }

                      return OutlinedButton(
                        onPressed: ref
                            .read(photosPermissionServiceProvider.notifier)
                            .request,
                        child: Text(
                          context.l10n
                              .photo_permission_screen_permission_allow_photos_access,
                        ),
                      );
                    },
                    error: (ex, stackTrace) {
                      return RetryButton(
                        onRetry: () =>
                            ref.refresh(photosPermissionServiceProvider),
                      );
                    },
                    loading: () => const CircularProgressIndicator(),
                  ),
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );
  }
}
