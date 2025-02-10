import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/video_player_provider.dart';

class VideoControls extends ConsumerWidget {
  const VideoControls({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(videoPlayerControllerProvider);

    return GestureDetector(
      onTap: () =>
          ref.read(videoPlayerControllerProvider.notifier).togglePlay(),
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
