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

  const VideoPlayerReady({
    required this.isPlaying,
    required this.currentTime,
    required this.currentSubtitleIndex,
    required this.reel,
  });

  @override
  List<Object?> get props => [
    isPlaying,
    currentTime,
    currentSubtitleIndex,
    reel,
  ];

  VideoPlayerReady copyWith({
    bool? isPlaying,
    double? currentTime,
    int? currentSubtitleIndex,
    Reel? reel,
  }) {
    return VideoPlayerReady(
      isPlaying: isPlaying ?? this.isPlaying,
      currentTime: currentTime ?? this.currentTime,
      currentSubtitleIndex: currentSubtitleIndex ?? this.currentSubtitleIndex,
      reel: reel ?? this.reel,
    );
  }
}

class VideoPlayerError extends VideoPlayerState {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
