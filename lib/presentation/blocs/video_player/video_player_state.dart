import 'package:equatable/equatable.dart';
import '../../../domain/entities/reel.dart';

abstract class VideoPlayerState extends Equatable {
  const VideoPlayerState();

  @override
  List<Object?> get props => [];
}

class VideoPlayerInitial extends VideoPlayerState {
  const VideoPlayerInitial();
}

class VideoPlayerLoading extends VideoPlayerState {
  const VideoPlayerLoading();
}

class VideoPlayerReady extends VideoPlayerState {
  final bool isPlaying;
  final double currentTime;
  final int currentSubtitleIndex;
  final Reel reel;
  final bool isMuted;
  final double volume;
  final double speed;

  const VideoPlayerReady({
    required this.isPlaying,
    required this.currentTime,
    required this.currentSubtitleIndex,
    required this.reel,
    this.isMuted = false,
    this.volume = 1.0,
    this.speed = 1.0,
  });

  @override
  List<Object?> get props => [
    isPlaying,
    currentTime,
    currentSubtitleIndex,
    reel,
    isMuted,
    volume,
    speed,
  ];

  VideoPlayerReady copyWith({
    bool? isPlaying,
    double? currentTime,
    int? currentSubtitleIndex,
    Reel? reel,
    bool? isMuted,
    double? volume,
    double? speed,
  }) {
    return VideoPlayerReady(
      isPlaying: isPlaying ?? this.isPlaying,
      currentTime: currentTime ?? this.currentTime,
      currentSubtitleIndex: currentSubtitleIndex ?? this.currentSubtitleIndex,
      reel: reel ?? this.reel,
      isMuted: isMuted ?? this.isMuted,
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
    );
  }
}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
