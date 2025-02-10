import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:video_player/video_player.dart';
import '../../domain/entities/video_state.dart';

final videoPlayerControllerProvider =
    StateNotifierProvider.autoDispose<VideoPlayerNotifier, VideoState>(
  (ref) => VideoPlayerNotifier(
    assetPath: 'assets/videos/demo.mp4',
    config: ref.watch(videoConfigProvider),
  ),
);

final videoPlayerProvider = Provider.family.autoDispose<VideoPlayerController?,
        AutoDisposeStateNotifierProvider<VideoPlayerNotifier, VideoState>>(
    (ref, provider) {
  return ref.watch(provider.notifier).controller;
});

class VideoPlayerNotifier extends StateNotifier<VideoState> {
  VideoPlayerNotifier({
    String? assetPath,
    String? networkUrl,
    required this.config,
  }) : super(VideoState.initial()) {
    _initialize(assetPath: assetPath, networkUrl: networkUrl);
  }

  VideoPlayerController? _controller;
  bool _isAppActive = true;
  final VideoConfig config;

  VideoPlayerController? get controller => _controller;

  Future<void> _initialize({String? assetPath, String? networkUrl}) async {
    try {
      if (assetPath != null) {
        _controller = VideoPlayerController.asset(assetPath);
      } else if (networkUrl != null) {
        _controller = VideoPlayerController.network(networkUrl);
      } else {
        // 默认使用本地视频
        _controller = VideoPlayerController.asset('assets/videos/demo.mp4');
      }

      await _controller!.initialize();
      _controller!.addListener(_videoListener);

      state = state.copyWith(
        duration: _controller!.value.duration,
        isInitialized: true,
        darkSections: config.darkSections,
      );

      await _controller!.setLooping(true);
      await _controller!.setVolume(1.0);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  void _videoListener() {
    if (_controller == null) return;

    state = state.copyWith(
      position: _controller!.value.position,
      isPlaying: _controller!.value.isPlaying,
      isBuffering: _controller!.value.isBuffering,
    );
  }

  void togglePlay() {
    if (_controller == null) return;

    if (_controller!.value.isPlaying) {
      _controller!.pause();
    } else {
      _controller!.play();
    }
  }

  void seekTo(Duration position) {
    if (_controller == null) return;
    _controller!.seekTo(position);
  }

  void onAppLifecycleStateChange(bool isActive) {
    _isAppActive = isActive;
    if (_controller == null) return;

    if (!_isAppActive && _controller!.value.isPlaying) {
      _controller!.pause();
    }
  }

  @override
  void dispose() {
    _controller?.removeListener(_videoListener);
    _controller?.dispose();
    super.dispose();
  }
}
