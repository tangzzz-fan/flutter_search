import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_search/features/video_player/presentation/providers/video_player_provider.dart';

class HomeVideoProgressIndicator extends ConsumerWidget {
  const HomeVideoProgressIndicator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final videoState = ref.watch(videoPlayerControllerProvider);

    return Column(
      children: [
        // 进度条
        LinearProgressIndicator(
          value: videoState.progress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            videoState.isDarkSection ? Colors.black : Colors.blue,
          ),
        ),
        // 状态文本
        Text(
          '进度: ${(videoState.progress * 100).toStringAsFixed(1)}%\n'
          '是否为暗色区间: ${videoState.isDarkSection}',
        ),
      ],
    );
  }
}
