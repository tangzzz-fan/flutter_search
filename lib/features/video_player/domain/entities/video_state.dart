import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

part 'video_state.freezed.dart';

// 定义视频状态接口
abstract class IVideoState {
  bool get isPlaying;
  Duration get position;
  Duration get duration;
  bool get isBuffering;
  bool get isInitialized;
  String? get error;
  double get progress;
  bool get isDarkSection;
}

@freezed
class VideoState with _$VideoState implements IVideoState {
  const factory VideoState({
    required bool isPlaying,
    required Duration position,
    required Duration duration,
    required bool isBuffering,
    required bool isInitialized,
    String? error,
    @Default([]) List<DarkSection> darkSections,
  }) = _VideoState;

  const VideoState._(); // 添加私有构造函数以实现接口方法

  factory VideoState.initial() => const VideoState(
        isPlaying: false,
        position: Duration.zero,
        duration: Duration.zero,
        isBuffering: false,
        isInitialized: false,
      );

  @override
  double get progress {
    if (duration == Duration.zero) return 0.0;
    return position.inMilliseconds / duration.inMilliseconds;
  }

  @override
  bool get isDarkSection {
    if (darkSections.isEmpty) return false;
    final currentSeconds = position.inSeconds.toDouble();
    return darkSections.any((section) =>
        currentSeconds >= section.startTime &&
        currentSeconds <= section.endTime);
  }
}

// 定义暗色部分的数据类
class DarkSection {
  final double startTime;
  final double endTime;

  const DarkSection({
    required this.startTime,
    required this.endTime,
  });
}

// 视频配置提供者
final videoConfigProvider = Provider<VideoConfig>((ref) {
  return const VideoConfig(
    darkSections: [
      DarkSection(startTime: 4.4, endTime: 10.4),
      // 可以添加更多区间
    ],
  );
});

// 视频配置类
class VideoConfig {
  final List<DarkSection> darkSections;

  const VideoConfig({
    this.darkSections = const [],
  });
}
