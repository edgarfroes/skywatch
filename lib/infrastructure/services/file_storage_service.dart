import 'dart:io';

import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'file_storage_service.g.dart';

class FileStorageService {
  Future<String> save(File file) async {
    final filesDirectory = (await getApplicationDocumentsDirectory()).path;

    final newFileName = '${const Uuid().v4()}${path.extension(file.path)}';

    final newPath = path.join(
      filesDirectory,
      newFileName,
    );

    await file.copy(newPath);

    return newFileName;
  }
}

@riverpod
FileStorageService fileStorageService(FileStorageServiceRef ref) =>
    FileStorageService();
