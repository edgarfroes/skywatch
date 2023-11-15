import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/services/logger_service.dart';
import 'package:skywatch/presentation/components/country_selection_button.dart';
import 'package:skywatch/presentation/components/video_player.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/services/photos_permission_service.dart';
import 'package:skywatch/presentation/services/video_picker_service.dart';

@RoutePage()
class UploadVideoTabScreen extends HookConsumerWidget {
  const UploadVideoTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosPermissionAsync = ref.watch(photosPermissionServiceProvider);
    final pickedVideoFile = useState<File?>(null);
    final selectedCountry = useState<Country?>(null);
    final openingFile = useState(false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Upload Video'),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Gap(20),
            SelectCountryButton(
              onCountrySelect: (Country country) {
                selectedCountry.value = country;
              },
            ),
            const Gap(20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ValueListenableBuilder(
                valueListenable: pickedVideoFile,
                builder: (context, videoFile, child) {
                  if (videoFile != null) {
                    return Stack(
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
                    );
                  }

                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: ValueListenableBuilder(
                      valueListenable: openingFile,
                      builder: (context, value, child) {
                        if (value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }

                        return Material(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(10),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(10),
                            onTap: () {
                              photosPermissionAsync.whenOrNull(
                                skipError: true,
                                skipLoadingOnRefresh: true,
                                skipLoadingOnReload: true,
                                data: (status) async {
                                  openingFile.value = true;

                                  try {
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
                                  } catch (ex) {
                                    ref
                                        .read(loggerProvider)
                                        .error('Error picking video', ex);
                                  } finally {
                                    openingFile.value = false;
                                  }
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
                        );
                      },
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
