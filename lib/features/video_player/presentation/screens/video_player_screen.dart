import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../providers/video_player_provider.dart';
import '../widgets/video_controls.dart';
import '../widgets/video_progress_bar.dart';
import '../widgets/video_progress_indicator.dart';

class VideoPlayerScreen extends ConsumerStatefulWidget {
  const VideoPlayerScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends ConsumerState<VideoPlayerScreen>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    ref.read(videoPlayerControllerProvider.notifier).onAppLifecycleStateChange(
          state == AppLifecycleState.resumed,
        );
  }

  @override
  Widget build(BuildContext context) {
    final videoState = ref.watch(videoPlayerControllerProvider);
    final controller = ref.watch(videoPlayerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('视频播放器'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 16 / 9,
            child: Container(
              color: Colors.black,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  if (videoState.isInitialized && controller != null) ...[
                    VideoPlayer(controller),
                    const VideoControls(),
                  ] else if (videoState.error != null)
                    Center(
                      child: Text(
                        '错误: ${videoState.error}',
                        style: const TextStyle(color: Colors.white),
                      ),
                    )
                  else
                    const CircularProgressIndicator(),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                SizedBox(height: 16),
                SizedBox(height: 16),
                VideoProgressBar(),
                SizedBox(height: 16),
                HomeVideoProgressIndicator(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '当前播放时间: ${videoState.position.inSeconds}秒\n'
                  '视频总时长: ${videoState.duration.inSeconds}秒\n'
                  '播放状态: ${videoState.isPlaying ? "播放中" : "已暂停"}\n'
                  '缓冲状态: ${videoState.isBuffering ? "缓冲中" : "正常"}\n'
                  '进度: ${(videoState.progress * 100).toStringAsFixed(1)}%\n'
                  '是否为暗色区间: ${videoState.isDarkSection}',
                ),
                const SizedBox(height: 8),
                Text(
                  '播放进度: ${(videoState.progress * 100).toStringAsFixed(1)}%',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
