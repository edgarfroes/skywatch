import 'package:permission_handler/permission_handler.dart'
    as permission_handler;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:skywatch/domain/repositories/logger_repository.dart';

part 'photos_permission_provider.g.dart';

@riverpod
class PhotosPermission extends _$PhotosPermission {
  final _permission = permission_handler.Permission.photos;

  @override
  Future<PermissionStatus> build() async =>
      _convertEnum(await _permission.status);

  Future<void> request() async {
    final logger = ref.read(loggerRepositoryProvider);

    logger.info('Requesting photos permission');

    state = const AsyncValue.loading();

    try {
      state = AsyncValue.data(_convertEnum(await _permission.request()));

      logger.info(
        'Photos permission is ${state.value?.name.toUpperCase()}',
      );
    } catch (ex, stackTrace) {
      logger.error(
        'Photos permission is ${state.value?.name.toUpperCase()}',
        ex,
      );

      state = AsyncValue.error(ex, stackTrace);
    }
  }
}

@riverpod
Future<bool> openAppPermissionSettings(
  OpenAppPermissionSettingsRef ref,
) async {
  ref.read(loggerRepositoryProvider).info('Opening app settings');

  final opened = await permission_handler.openAppSettings();

  if (opened) {
    ref.read(loggerRepositoryProvider).info('Opened app settings succesfully');
  } else {
    ref.read(loggerRepositoryProvider).error('Error opening app settings');
  }

  return opened;
}

PermissionStatus _convertEnum(permission_handler.PermissionStatus status) {
  switch (status) {
    case permission_handler.PermissionStatus.denied:
      return PermissionStatus.denied;
    case permission_handler.PermissionStatus.granted:
    case permission_handler.PermissionStatus.restricted:
    case permission_handler.PermissionStatus.limited:
      return PermissionStatus.granted;
    case permission_handler.PermissionStatus.provisional:
    case permission_handler.PermissionStatus.permanentlyDenied:
    default:
      return PermissionStatus.permanentlyDenied;
  }
}

enum PermissionStatus {
  granted,
  denied,
  permanentlyDenied;

  bool get isGranted => this == PermissionStatus.granted;
  bool get isDenied => this == PermissionStatus.denied;
  bool get isPermanentlyDenied => this == PermissionStatus.permanentlyDenied;
}
