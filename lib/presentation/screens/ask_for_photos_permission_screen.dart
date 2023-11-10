import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/providers/photos_permission_provider.dart';

@RoutePage()
class AskForPhotosPermissionScreen extends ConsumerWidget {
  // ignore: use_key_in_widget_constructors
  const AskForPhotosPermissionScreen({
    this.popWhenGranted = false,
  });

  final bool popWhenGranted;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosPermission = ref.watch(photosPermissionProvider);

    photosPermission.whenData((value) {
      if (value.isGranted) {
        ref.read(appRouterProvider).pop();
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
                'Permission required',
                style: context.textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              const Gap(50),
              Text(
                'We need your permission to access photo library',
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
                  child: photosPermission.map(data: (data) {
                    final status = data.value;

                    if (status.isGranted) {
                      return const OutlinedButton(
                        onPressed: null,
                        child: Text('Permission granted'),
                      );
                    }

                    if (status.isPermanentlyDenied) {
                      return OutlinedButton(
                        onPressed: () {
                          ref.read(openAppPermissionSettingsProvider);
                        },
                        child: const Text('Open app settings'),
                      );
                    }

                    return OutlinedButton(
                      onPressed:
                          ref.read(photosPermissionProvider.notifier).request,
                      child: const Text('Allow photos access'),
                    );
                  }, error: (data) {
                    return const Text('error');
                  }, loading: (data) {
                    if (data.value?.isGranted == false) {
                      return const OutlinedButton(
                        onPressed: null,
                        child: Text('Requesting permission'),
                      );
                    }
                    return const CircularProgressIndicator();
                  }),
                ),
              ),
              const Gap(50),
            ],
          ),
        ),
      ),
    );

    // return RefreshIndicator(
    //   onRefresh: () async => await ref.refresh(requestPhotosPermissionHandlerProvider.future), child: null,
    // );

    // return FutureBuilder(
    //   future: ref.watch(requestPhotosPermissionHandlerProvider),
    //   builder: (context, snapshot) {
    //     if (snapshot.hasError) {
    //       return Retry(onRetry: onRetry);
    //     }
    //   },
    // );

    // return Container();
  }
}
