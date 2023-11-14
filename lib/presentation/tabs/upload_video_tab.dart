import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/presentation/components/country_selection_button.dart';
import 'package:skywatch/presentation/components/video_player.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/providers/photos_permission_provider.dart';
import 'package:skywatch/presentation/providers/video_picker_provider.dart';

@RoutePage()
class UploadVideoTabScreen extends HookConsumerWidget {
  const UploadVideoTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosPermission = ref.watch(photosPermissionProvider);
    final pickedVideoFile = useState<File?>(null);
    final selectedCountry = useState<Country?>(null);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(20),
            SelectCountryButton(
              onCountrySelect: (Country country) {
                selectedCountry.value = country;
              },
            ),
            const Gap(50),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: pickedVideoFile.value == null
                  ? AspectRatio(
                      aspectRatio: 16 / 9,
                      child: Material(
                        clipBehavior: Clip.antiAlias,
                        borderRadius: BorderRadius.circular(10),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(10),
                          onTap: () {
                            photosPermission.whenOrNull(
                              skipError: true,
                              skipLoadingOnRefresh: true,
                              skipLoadingOnReload: true,
                              data: (status) async {
                                if (!status.isGranted) {
                                  final updatedStatus = await ref
                                      .read(appRouterProvider)
                                      .goToAskForPhotosPermissionScreen(
                                        popWhenGranted: true,
                                      );

                                  if (updatedStatus?.isGranted != true) {
                                    return;
                                  }
                                }

                                pickedVideoFile.value = await ref
                                        .read(videoPickerProvider)
                                        .fromGalery() ??
                                    pickedVideoFile.value;
                              },
                            );
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(
                                color: context.colorScheme.surfaceVariant,
                                width: 2,
                              ),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.upload_sharp,
                                  color: context.colorScheme.primary,
                                  size: 40,
                                ),
                                Text(
                                  'Select video to upload',
                                  style: (context.textTheme.bodyMedium ??
                                          const TextStyle())
                                      .copyWith(
                                    color: context.colorScheme.primary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Stack(
                      children: [
                        ValueListenableBuilder(
                          valueListenable: pickedVideoFile,
                          builder: (context, file, child) {
                            if (file == null) {
                              return const SizedBox.shrink();
                            }

                            return VideoPlayer(
                              file: file,
                            );
                          },
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: IconButton(
                            onPressed: () {
                              pickedVideoFile.value = null;
                            },
                            icon: Container(
                              decoration: BoxDecoration(
                                color: context.colorScheme.background
                                    .withOpacity(0.5),
                                borderRadius: BorderRadius.circular(100),
                              ),
                              padding: const EdgeInsets.all(5),
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.close_rounded,
                                size: 26,
                                color: context.colorScheme.onBackground,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
