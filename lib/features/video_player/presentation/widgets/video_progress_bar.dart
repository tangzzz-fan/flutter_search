import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/video_player_provider.dart';

class VideoProgressBar extends ConsumerWidget {
  const VideoProgressBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(videoPlayerControllerProvider);

    if (!videoState.isInitialized) return const SizedBox.shrink();

    return Slider(
      value: videoState.position.inMilliseconds.toDouble(),
      max: videoState.duration.inMilliseconds.toDouble(),
      onChanged: (value) {
        ref
            .read(videoPlayerControllerProvider.notifier)
            .seekTo(Duration(milliseconds: value.toInt()));
      },
    );
  }
}
