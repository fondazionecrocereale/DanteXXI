import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../../domain/entities/reel.dart';
import 'video_player_event.dart' as events;
import 'video_player_state.dart' as states;
import 'dart:async';

class VideoPlayerBloc
    extends Bloc<events.VideoPlayerEvent, states.VideoPlayerState> {
  final Reel reel;
  YoutubePlayerController? _controller;
  Timer? _subtitleTimer;
  Timer? _timeoutTimer;
  bool _isInitialized = false;

  VideoPlayerBloc({required this.reel})
    : super(const states.VideoPlayerLoading()) {
    on<events.VideoPlayerReady>(_onVideoPlayerReady);
    on<events.VideoPlayerPlaying>(_onVideoPlayerPlaying);
    on<events.VideoPlayerPaused>(_onVideoPlayerPaused);
    on<events.VideoPlayerTimeUpdate>(_onVideoPlayerTimeUpdate);
    on<events.VideoPlayerSeekTo>(_onVideoPlayerSeekTo);
    on<events.VideoPlayerSeekToSubtitle>(_onVideoPlayerSeekToSubtitle);
    on<events.VideoPlayerTogglePlayPause>(_onVideoPlayerTogglePlayPause);
    on<events.VideoPlayerSeekBackward>(_onVideoPlayerSeekBackward);
    on<events.VideoPlayerSeekForward>(_onVideoPlayerSeekForward);
    on<events.VideoPlayerError>(_onVideoPlayerError);
  }

  YoutubePlayerController? get controller => _controller;

  void initializeController() {
    if (_isInitialized) return;

    try {
      print('🎬 Inicializando controlador para video: ${reel.url}');

      final videoId = _extractYouTubeId(reel.url);
      if (videoId.isEmpty) {
        add(const events.VideoPlayerError('URL de YouTube no válida'));
        return;
      }

      print('🎬 ID del video extraído: $videoId');

      _controller = YoutubePlayerController.fromVideoId(
        videoId: videoId,
        autoPlay: true,
        params: const YoutubePlayerParams(
          showControls: false,
          showFullscreenButton: false,
          mute: false,
          enableCaption: false,
          showVideoAnnotations: false,
          loop: false,
          strictRelatedVideos: true,
        ),
      );

      // Configurar timeout para evitar loading eterno
      _timeoutTimer = Timer(const Duration(seconds: 10), () {
        if (state is states.VideoPlayerLoading) {
          print('⏰ Timeout alcanzado, forzando estado ready');
          add(const events.VideoPlayerReady());
        }
      });

      // Escuchar eventos del player
      _controller!.listen((event) {
        print('🎬 Evento del player: $event');

        // Cancelar timeout si recibimos algún evento
        _timeoutTimer?.cancel();

        // Verificar si es un evento de error real
        if (event.toString().contains('error') &&
            event.toString().contains('YoutubeError.none') == false) {
          print('❌ Error real en el player');
          add(
            const events.VideoPlayerError('Error en el reproductor de YouTube'),
          );
          return;
        }

        // Verificar si el player está listo
        if (event.toString().contains('ready') ||
            event.toString().contains('PlayerState.playing') ||
            event.toString().contains('PlayerState.buffering')) {
          if (event.toString().contains('ready')) {
            print('✅ Player listo');
            add(const events.VideoPlayerReady());
          } else if (event.toString().contains('PlayerState.playing')) {
            print('▶️ Video reproduciéndose');
            add(const events.VideoPlayerPlaying());
          } else if (event.toString().contains('PlayerState.buffering')) {
            print('🔄 Video cargando...');
            // Si está buffering y no hemos emitido ready, asumimos que está listo
            if (state is states.VideoPlayerLoading) {
              print('✅ Player parece estar listo (buffering), forzando estado');
              add(const events.VideoPlayerReady());
            }
          }
        } else if (event.toString().contains('PlayerState.paused')) {
          print('⏸️ Video pausado');
          add(const events.VideoPlayerPaused());
        } else if (event.toString().contains('PlayerState.unStarted')) {
          print('⏹️ Video no iniciado');
          // Si el video no ha iniciado pero tenemos metadata, asumimos que está listo
          if (event.toString().contains('metaData') &&
              state is states.VideoPlayerLoading) {
            print('✅ Player tiene metadata, forzando estado ready');
            add(const events.VideoPlayerReady());
          }
        } else {
          print('🔄 Otro evento del player: ${event.runtimeType}');
          // Si recibimos cualquier evento y estamos en loading, asumimos que está listo
          if (state is states.VideoPlayerLoading) {
            print('✅ Player está emitiendo eventos, forzando estado ready');
            add(const events.VideoPlayerReady());
          }
        }
      });

      _isInitialized = true;
      print('✅ Controlador inicializado correctamente');

      // Verificar si el player ya está listo después de un breve delay
      Timer(const Duration(milliseconds: 500), () {
        if (state is states.VideoPlayerLoading) {
          print('🔄 Verificando estado del player después de 500ms');
          _checkPlayerState();
        }
      });
    } catch (e) {
      print('❌ Error al inicializar el reproductor: $e');
      add(events.VideoPlayerError('Error al inicializar el reproductor: $e'));
    }
  }

  void _checkPlayerState() async {
    try {
      if (_controller != null) {
        // Intentar obtener el tiempo actual para verificar si el player está funcionando
        final currentTime = await _controller!.currentTime;
        print('🎬 Tiempo actual del player: $currentTime');

        if (currentTime != null && state is states.VideoPlayerLoading) {
          print('✅ Player está funcionando, forzando estado ready');
          add(const events.VideoPlayerReady());
        }
      }
    } catch (e) {
      print('❌ Error al verificar estado del player: $e');
    }
  }

  void _onVideoPlayerReady(
    events.VideoPlayerReady event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    print('🎬 Emitiendo estado VideoPlayerReady');

    // Cancelar timeout si existe
    _timeoutTimer?.cancel();

    emit(
      states.VideoPlayerReady(
        isPlaying: false,
        currentTime: 0.0,
        currentSubtitleIndex: -1,
        reel: reel,
      ),
    );
    _startTimeTracking();
  }

  void _onVideoPlayerPlaying(
    events.VideoPlayerPlaying event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    if (state is states.VideoPlayerReady) {
      final currentState = state as states.VideoPlayerReady;
      emit(currentState.copyWith(isPlaying: true));
    }
  }

  void _onVideoPlayerPaused(
    events.VideoPlayerPaused event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    if (state is states.VideoPlayerReady) {
      final currentState = state as states.VideoPlayerReady;
      emit(currentState.copyWith(isPlaying: false));
    }
  }

  void _onVideoPlayerTimeUpdate(
    events.VideoPlayerTimeUpdate event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    if (state is states.VideoPlayerReady) {
      final currentState = state as states.VideoPlayerReady;
      final subtitleIndex = _getCurrentSubtitleIndex(event.currentTime);

      print(
        '🎬 Actualizando tiempo: ${event.currentTime.toStringAsFixed(2)}s -> Subtítulo: $subtitleIndex',
      );

      emit(
        currentState.copyWith(
          currentTime: event.currentTime,
          currentSubtitleIndex: subtitleIndex,
        ),
      );
    }
  }

  void _onVideoPlayerSeekTo(
    events.VideoPlayerSeekTo event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    try {
      if (_controller != null) {
        _controller!.seekTo(seconds: event.time);
        if (state is states.VideoPlayerReady) {
          final currentState = state as states.VideoPlayerReady;
          final subtitleIndex = _getCurrentSubtitleIndex(event.time);
          emit(
            currentState.copyWith(
              currentTime: event.time,
              currentSubtitleIndex: subtitleIndex,
            ),
          );
        }
      }
    } catch (e) {
      add(events.VideoPlayerError('Error al saltar al tiempo: $e'));
    }
  }

  void _onVideoPlayerSeekToSubtitle(
    events.VideoPlayerSeekToSubtitle event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    if (event.subtitleIndex >= 0 &&
        event.subtitleIndex < reel.subtitles.length) {
      final subtitle = reel.subtitles[event.subtitleIndex];
      final startTime = _parseTimeString(subtitle.startTime);
      add(events.VideoPlayerSeekTo(startTime));
    }
  }

  void _onVideoPlayerTogglePlayPause(
    events.VideoPlayerTogglePlayPause event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    try {
      print('🎬 Toggle play/pause - Estado actual: ${state.runtimeType}');

      if (_controller != null && state is states.VideoPlayerReady) {
        final currentState = state as states.VideoPlayerReady;
        print('🎬 Estado actual: isPlaying=${currentState.isPlaying}');

        if (currentState.isPlaying) {
          print('⏸️ Pausando video...');
          _controller!.pauseVideo();
        } else {
          print('▶️ Reproduciendo video...');
          _controller!.playVideo();
        }
      } else {
        print('❌ Controlador no disponible o estado incorrecto');
      }
    } catch (e) {
      print('❌ Error al cambiar reproducción: $e');
      add(events.VideoPlayerError('Error al cambiar reproducción: $e'));
    }
  }

  void _onVideoPlayerSeekBackward(
    events.VideoPlayerSeekBackward event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    if (state is states.VideoPlayerReady) {
      final currentState = state as states.VideoPlayerReady;
      final newTime = (currentState.currentTime - event.seconds).clamp(
        0.0,
        double.infinity,
      );
      add(events.VideoPlayerSeekTo(newTime));
    }
  }

  void _onVideoPlayerSeekForward(
    events.VideoPlayerSeekForward event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    if (state is states.VideoPlayerReady) {
      final currentState = state as states.VideoPlayerReady;
      final newTime = currentState.currentTime + event.seconds;
      add(events.VideoPlayerSeekTo(newTime));
    }
  }

  void _onVideoPlayerError(
    events.VideoPlayerError event,
    Emitter<states.VideoPlayerState> emit,
  ) {
    print('❌ Emitiendo estado de error: ${event.message}');

    // Cancelar timeout si existe
    _timeoutTimer?.cancel();

    emit(states.VideoPlayerError(event.message));
  }

  void _startTimeTracking() {
    print('🎬 Iniciando timer de subtítulos...');
    _subtitleTimer?.cancel();

    // Iniciar inmediatamente para obtener el primer tiempo
    _updateCurrentTime();

    _subtitleTimer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      print('🎬 Timer tick - Estado: ${state.runtimeType}');
      if (state is states.VideoPlayerReady && _controller != null) {
        _updateCurrentTime();
      } else {
        print('🎬 Timer: Estado incorrecto o controlador nulo');
      }
    });
    print('🎬 Timer de subtítulos iniciado correctamente');
  }

  void _updateCurrentTime() async {
    try {
      if (_controller != null) {
        final currentTime = await _controller!.currentTime;
        print('🎬 Tiempo actual: ${currentTime.toStringAsFixed(2)}s');

        // Calcular el índice del subtítulo activo
        final currentSubtitleIndex = _getCurrentSubtitleIndex(currentTime);
        print('🎬 Índice de subtítulo calculado: $currentSubtitleIndex');

        // Usar add() para emitir el evento de actualización de tiempo
        // Esto asegura que la UI se reconstruya correctamente
        add(events.VideoPlayerTimeUpdate(currentTime));
        print(
          '🎬 Evento VideoPlayerTimeUpdate emitido con tiempo $currentTime y subtítulo $currentSubtitleIndex',
        );
      }
    } catch (e) {
      print('❌ Error al obtener tiempo actual: $e');
    }
  }

  int _getCurrentSubtitleIndex(double currentTime) {
    for (int i = 0; i < reel.subtitles.length; i++) {
      final subtitle = reel.subtitles[i];
      final startTime = _parseTimeString(subtitle.startTime);
      final endTime = _parseTimeString(subtitle.endTime);

      if (currentTime >= startTime && currentTime <= endTime) {
        print(
          '🎬 Subtítulo activo: $i (${startTime.toStringAsFixed(2)}s - ${endTime.toStringAsFixed(2)}s)',
        );
        return i;
      }
    }
    return -1;
  }

  double _parseTimeString(String timeString) {
    try {
      // Formato esperado: "00:00:10.000"
      final parts = timeString.split(':');
      if (parts.length == 3) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final seconds = double.parse(parts[2]);
        final totalSeconds = hours * 3600 + minutes * 60 + seconds;
        print(
          '🎬 Tiempo parseado: $timeString -> ${totalSeconds.toStringAsFixed(2)}s',
        );
        return totalSeconds;
      }
      return 0.0;
    } catch (e) {
      print('❌ Error al parsear tiempo: $timeString - $e');
      return 0.0;
    }
  }

  String _extractYouTubeId(String url) {
    try {
      final uri = Uri.parse(url);

      if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
        if (uri.host.contains('youtu.be')) {
          return uri.pathSegments.first;
        } else {
          return uri.queryParameters['v'] ?? '';
        }
      }

      return '';
    } catch (e) {
      print('❌ Error al extraer ID de YouTube: $e');
      return '';
    }
  }

  @override
  Future<void> close() {
    _subtitleTimer?.cancel();
    _timeoutTimer?.cancel();
    _controller?.close();
    return super.close();
  }
}
