import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search/features/video_player/domain/entities/video_state.dart';
import '../providers/video_player_provider.dart';

class VideoControls extends ConsumerWidget {
  final AutoDisposeStateNotifierProvider<VideoPlayerNotifier, VideoState> provider;

  const VideoControls({
    Key? key,
    required this.provider,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(provider);

    return GestureDetector(
      onTap: () => ref.read(provider.notifier).togglePlay(),
      child: Container(
        color: Colors.black26,
        child: Center(
          child: Icon(
            videoState.isPlaying ? Icons.pause : Icons.play_arrow,
            color: Colors.white,
            size: 50,
          ),
        ),
      ),
    );
  }
}
