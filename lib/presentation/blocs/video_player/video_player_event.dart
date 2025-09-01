import 'package:equatable/equatable.dart';

abstract class VideoPlayerEvent extends Equatable {
  const VideoPlayerEvent();

  @override
  List<Object?> get props => [];
}

class VideoPlayerReady extends VideoPlayerEvent {
  const VideoPlayerReady();
}

class VideoPlayerPlaying extends VideoPlayerEvent {
  const VideoPlayerPlaying();
}

class VideoPlayerPaused extends VideoPlayerEvent {
  const VideoPlayerPaused();
}

class VideoPlayerTimeUpdate extends VideoPlayerEvent {
  final double currentTime;

  const VideoPlayerTimeUpdate(this.currentTime);

  @override
  List<Object?> get props => [currentTime];
}

class VideoPlayerSeekTo extends VideoPlayerEvent {
  final double time;

  const VideoPlayerSeekTo(this.time);

  @override
  List<Object?> get props => [time];
}

class VideoPlayerSeekToSubtitle extends VideoPlayerEvent {
  final int subtitleIndex;

  const VideoPlayerSeekToSubtitle(this.subtitleIndex);

  @override
  List<Object?> get props => [subtitleIndex];
}

class VideoPlayerTogglePlayPause extends VideoPlayerEvent {
  const VideoPlayerTogglePlayPause();
}

class VideoPlayerSeekBackward extends VideoPlayerEvent {
  final double seconds;

  const VideoPlayerSeekBackward(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

class VideoPlayerSeekForward extends VideoPlayerEvent {
  final double seconds;

  const VideoPlayerSeekForward(this.seconds);

  @override
  List<Object?> get props => [seconds];
}

class VideoPlayerError extends VideoPlayerEvent {
  final String message;

  const VideoPlayerError(this.message);

  @override
  List<Object?> get props => [message];
}
