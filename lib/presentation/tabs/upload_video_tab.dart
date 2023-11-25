// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:gap/gap.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:skywatch/domain/entities/country.dart';
import 'package:skywatch/domain/entities/weather_forecast.dart';
import 'package:skywatch/domain/services/add_weather_forecast_service.dart';
import 'package:skywatch/domain/services/logger_service.dart';
import 'package:skywatch/infrastructure/services/file_storage_service.dart';
import 'package:skywatch/presentation/components/country_selection_button.dart';
import 'package:skywatch/presentation/components/system_localization_selector.dart';
import 'package:skywatch/presentation/components/video_player.dart';
import 'package:skywatch/presentation/components/weather_classification_selector.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:skywatch/presentation/navigation/app_router.dart';
import 'package:skywatch/presentation/services/photos_permission_service.dart';
import 'package:skywatch/presentation/services/video_picker_service.dart';
import 'package:uuid/uuid.dart';

@RoutePage()
class UploadVideoTabScreen extends HookConsumerWidget {
  const UploadVideoTabScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final photosPermissionAsync = ref.watch(photosPermissionServiceProvider);
    final video = useState<File?>(null);
    final country = useState<Country?>(null);
    final description = useState<String?>(null);
    final classification = useState<WeatherForecastClassification?>(null);
    final isSaving = useState(false);

    final canSubmit = description.value?.isNotEmpty == true &&
        video.value != null &&
        country.value != null &&
        classification.value != null &&
        !isSaving.value;

    return AbsorbPointer(
      absorbing: isSaving.value,
      child: Scaffold(
        appBar: AppBar(
          title: Text(context.l10n.upload_video_tab_title),
          actions: const [
            SystemLocalizationSelector(),
            Gap(20),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) => description.value = value,
                  maxLines: 3,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    labelText: context.l10n.upload_video_tab_description,
                    floatingLabelAlignment: FloatingLabelAlignment.center,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                ),
              ),
              const Gap(20),
              WeatherClassificationSelector(
                initialClassification: classification.value,
                onSelect: (WeatherForecastClassification newClassification) {
                  classification.value = newClassification;
                },
              ),
              const Gap(20),
              SelectCountryButton(
                onCountrySelect: (Country newCountry) {
                  country.value = newCountry;
                },
              ),
              const Gap(20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ValueListenableBuilder(
                  valueListenable: video,
                  builder: (context, videoFile, child) {
                    if (videoFile != null) {
                      return Stack(
                        children: [
                          ValueListenableBuilder(
                            valueListenable: video,
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
                                video.value = null;
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
                      child: HookBuilder(builder: (context) {
                        final openingFileNotifier = useState(false);

                        return AbsorbPointer(
                          absorbing: openingFileNotifier.value,
                          child: Material(
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
                                    openingFileNotifier.value = true;

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

                                      video.value = await ref
                                              .read(videoPickerProvider)
                                              .fromGalery() ??
                                          video.value;
                                    } catch (ex) {
                                      ref
                                          .read(loggerProvider)
                                          .error('Error picking video', ex);
                                    } finally {
                                      openingFileNotifier.value = false;
                                    }
                                  },
                                );
                              },
                              child: DecoratedBox(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: context.colorScheme.surfaceVariant,
                                    width: 2,
                                  ),
                                ),
                                child: Builder(builder: (context) {
                                  if (openingFileNotifier.value) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }
                                  return Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.upload_sharp,
                                        color: context.colorScheme.primary,
                                        size: 40,
                                      ),
                                      Text(
                                        context.l10n
                                            .upload_video_tab_select_video_to_upload,
                                        style: (context.textTheme.bodyMedium ??
                                                const TextStyle())
                                            .copyWith(
                                          color: context.colorScheme.primary,
                                        ),
                                      ),
                                    ],
                                  );
                                }),
                              ),
                            ),
                          ),
                        );
                      }),
                    );
                  },
                ),
              ),
              const Gap(20),
              OutlinedButton(
                onPressed: !canSubmit
                    ? null
                    : () async {
                        context.focusScope.unfocus();

                        isSaving.value = true;

                        try {
                          final fileStorageService =
                              ref.read(fileStorageServiceProvider);

                          // TODO: As a POC, the file is stored only locally. This can
                          // get moved to a file service that returns the video URL.
                          final videoUrl =
                              await fileStorageService.save(video.value!);

                          final forecast = WeatherForecast(
                            id: const Uuid().v4(),
                            description: description.value!,
                            countryCode: country.value!.code,
                            videoUrl: videoUrl,
                            createdAt: DateTime.now(),
                            classification: classification.value!,
                          );

                          await ref.read(
                            addWeatherForecastServiceProvider(forecast).future,
                          );

                          video.value = null;
                          country.value = null;
                          description.value = null;
                          classification.value = null;

                          await ref
                              .read(appRouterProvider)
                              .goToWeatherForecastTab();

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.l10n.upload_video_tab_success,
                              ),
                            ),
                          );
                        } catch (e) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                context.l10n.upload_video_tab_error,
                              ),
                            ),
                          );
                        } finally {
                          isSaving.value = false;
                        }
                      },
                child: Text(context.l10n.upload_video_tab_save_button),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
