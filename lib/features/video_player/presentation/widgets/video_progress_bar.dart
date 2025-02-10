import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search/features/video_player/domain/entities/video_state.dart';
import '../providers/video_player_provider.dart';

class VideoProgressBar extends ConsumerWidget {
  final AutoDisposeStateNotifierProvider<VideoPlayerNotifier, VideoState> provider;

  const VideoProgressBar({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(provider);

    if (!videoState.isInitialized) return const SizedBox.shrink();

    return Slider(
      value: videoState.position.inMilliseconds.toDouble(),
      max: videoState.duration.inMilliseconds.toDouble(),
      onChanged: (value) {
        ref
            .read(provider.notifier)
            .seekTo(Duration(milliseconds: value.toInt()));
      },
    );
  }
}
