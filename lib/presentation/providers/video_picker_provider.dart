import 'dart:io';

import 'package:image_picker/image_picker.dart' as image_picker;
import 'package:image_picker/image_picker.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';

part 'video_picker_provider.g.dart';

@riverpod
VideoPicker videoPicker(VideoPickerRef ref) => VideoPicker(
      logger: ref.read(loggerRepositoryProvider),
    );

class VideoPicker {
  VideoPicker({
    required this.logger,
  });

  final _imagePicker = image_picker.ImagePicker();

  final LoggerRepository logger;

  Future<File?> fromGalery() async {
    try {
      logger.info('Picking video from gallery');

      final file = await _imagePicker.pickVideo(
        source: ImageSource.gallery,
      );

      if (file != null) {
        logger.info('Video with "${file.name}" picked from gallery');

        return File(file.path);
      }

      logger.info('No video was picked from gallery');

      return null;
    } catch (ex) {
      logger.error(
        'Error while picking video from gallery',
        ex,
      );

      rethrow;
    }
  }
}
