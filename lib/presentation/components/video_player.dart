import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';
import 'package:video_player/video_player.dart' hide VideoPlayer;
import 'package:video_player/video_player.dart' as video_player
    show VideoPlayer;

class VideoPlayer extends HookWidget {
  const VideoPlayer({
    super.key,
    required this.file,
  });

  final File file;

  @override
  Widget build(BuildContext context) {
    final controller = use(
      _VideoPlayerController(
        file: file,
      ),
    );

    return AspectRatio(
      aspectRatio: controller.value.isInitialized
          ? controller.value.aspectRatio
          : (16 / 9),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Stack(
          fit: StackFit.expand,
          children: [
            video_player.VideoPlayer(controller),
            Material(
              color: Colors.transparent,
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {
                  if (controller.value.isPlaying) {
                    controller.pause();
                    return;
                  }
                  controller.play();
                },
                child: ValueListenableBuilder(
                  valueListenable: controller,
                  builder: (BuildContext context, VideoPlayerValue value,
                      Widget? child) {
                    if (!value.isInitialized) {
                      return const SizedBox.shrink();
                    }

                    return AnimatedOpacity(
                      opacity: value.isPlaying ? 0.5 : 1,
                      duration: value.isPlaying
                          ? const Duration(milliseconds: 300)
                          : Duration.zero,
                      child: Icon(
                        value.isPlaying
                            ? Icons.pause_circle_filled_sharp
                            : Icons.play_arrow_sharp,
                        size: 70,
                      ),
                    );
                  },
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              right: 0,
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (
                  BuildContext context,
                  VideoPlayerValue value,
                  Widget? child,
                ) {
                  if (!value.isInitialized) {
                    return const SizedBox.shrink();
                  }

                  return LinearProgressIndicator(
                    value: !value.isInitialized
                        ? 0
                        : value.position.inMilliseconds /
                            value.duration.inMilliseconds,
                  );
                },
              ),
            ),
            Positioned(
              right: 0,
              bottom: 5,
              child: ValueListenableBuilder(
                valueListenable: controller,
                builder: (
                  BuildContext context,
                  VideoPlayerValue value,
                  Widget? child,
                ) {
                  if (!value.isInitialized) {
                    return const SizedBox.shrink();
                  }

                  return IconButton(
                    icon: Container(
                      decoration: BoxDecoration(
                        color: context.colorScheme.background.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(100),
                      ),
                      padding: const EdgeInsets.all(5),
                      alignment: Alignment.center,
                      child: Icon(
                        value.volume == 0
                            ? Icons.volume_off_sharp
                            : Icons.volume_up_sharp,
                      ),
                    ),
                    iconSize: 30,
                    onPressed: () {
                      controller.setVolume(value.volume == 0 ? 1 : 0);
                    },
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

class _VideoPlayerController extends Hook<VideoPlayerController> {
  const _VideoPlayerController({
    required this.file,
  });

  final File file;

  @override
  _VideoPlayerControllerState createState() => _VideoPlayerControllerState();
}

class _VideoPlayerControllerState
    extends HookState<VideoPlayerController, _VideoPlayerController> {
  late VideoPlayerController controller;

  @override
  void initHook() {
    super.initHook();

    _initialize(hook.file);
  }

  @override
  void didUpdateHook(_VideoPlayerController oldHook) {
    if (oldHook.file.path != hook.file.path) {
      _reinitialize(hook.file);
    }

    super.didUpdateHook(hook);
  }

  _reinitialize(File file) async {
    await controller.pause();
    await controller.dispose();

    _initialize(file);
  }

  _initialize(File file) async {
    controller = VideoPlayerController.file(hook.file);
    await controller.initialize();

    setState(() {});

    await _startVideoOnInitialState();
  }

  _startVideoOnInitialState() async {
    await controller.setLooping(true);
    await controller.setVolume(0);
    // await controller.setPlaybackSpeed(2);
    await controller.play();
  }

  @override
  VideoPlayerController build(BuildContext context) {
    return controller;
  }

  @override
  void dispose() {
    controller.dispose();

    super.dispose();
  }
}
