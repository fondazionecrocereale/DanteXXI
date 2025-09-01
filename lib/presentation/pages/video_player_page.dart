import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';
import '../../domain/entities/reel.dart';
import '../../core/constants/app_colors.dart';
import '../blocs/video_player/video_player_bloc.dart';
import '../blocs/video_player/video_player_event.dart' as events;
import '../blocs/video_player/video_player_state.dart' as states;

class VideoPlayerPage extends StatefulWidget {
  final Reel reel;

  const VideoPlayerPage({super.key, required this.reel});

  @override
  State<VideoPlayerPage> createState() => _VideoPlayerPageState();
}

class _VideoPlayerPageState extends State<VideoPlayerPage> {
  late VideoPlayerBloc _videoPlayerBloc;

  @override
  void initState() {
    super.initState();
    _videoPlayerBloc = VideoPlayerBloc(reel: widget.reel);
    _videoPlayerBloc.initializeController();
  }

  @override
  void dispose() {
    _videoPlayerBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: Text(
          widget.reel.name,
          style: const TextStyle(color: Colors.white),
        ),
        elevation: 0,
      ),
      body: BlocProvider(
        create: (context) => _videoPlayerBloc,
        child: BlocBuilder<VideoPlayerBloc, states.VideoPlayerState>(
          builder: (context, state) {
            if (state is states.VideoPlayerLoading) {
              return _buildLoadingState();
            } else if (state is states.VideoPlayerError) {
              return _buildErrorState(state);
            } else if (state is states.VideoPlayerReady) {
              return _buildReadyState(state);
            } else {
              return _buildInitialState();
            }
          },
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(color: Colors.white),
          SizedBox(height: 24),
          Text(
            'Cargando reproductor...',
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(states.VideoPlayerError state) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.error_outline, color: Colors.red, size: 64),
          const SizedBox(height: 24),
          Text(
            'Error: ${state.message}',
            style: const TextStyle(color: Colors.white, fontSize: 18),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () => _videoPlayerBloc.initializeController(),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.primaryBlue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }

  Widget _buildInitialState() {
    return const Center(
      child: Text(
        'Inicializando...',
        style: TextStyle(color: Colors.white, fontSize: 18),
      ),
    );
  }

  Widget _buildReadyState(states.VideoPlayerReady state) {
    print(
      '🎨 UI: Construyendo estado ready - currentSubtitleIndex: ${state.currentSubtitleIndex}',
    );

    return Column(
      children: [
        // Video Player (40% de la pantalla)
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.4,
          width: double.infinity,
          child: YoutubePlayerScaffold(
            controller: _videoPlayerBloc.controller!,
            aspectRatio: 16 / 9,
            builder: (context, player) => player,
          ),
        ),

        // Controles del video
        _buildVideoControls(state),

        // Subtítulos activos (20% de la pantalla)
        _buildActiveSubtitles(state),

        // Lista de subtítulos (40% restante)
        // Expanded(child: _buildSubtitlesList(state)),
      ],
    );
  }

  Widget _buildVideoControls(states.VideoPlayerReady state) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.grey[900],
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          // Botón de retroceso 10s
          IconButton(
            icon: const Icon(Icons.replay_10, color: Colors.white),
            onPressed: () =>
                _videoPlayerBloc.add(const events.VideoPlayerSeekBackward(10)),
          ),

          // Botón principal de play/pause
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue,
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                state.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 30,
              ),
              onPressed: () => _videoPlayerBloc.add(
                const events.VideoPlayerTogglePlayPause(),
              ),
            ),
          ),

          // Botón de adelanto 10s
          IconButton(
            icon: const Icon(Icons.forward_10, color: Colors.white),
            onPressed: () =>
                _videoPlayerBloc.add(const events.VideoPlayerSeekForward(10)),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveSubtitles(states.VideoPlayerReady state) {
    // Mostrar solo el subtítulo activo actual
    if (state.currentSubtitleIndex < 0 ||
        state.currentSubtitleIndex >= state.reel.subtitles.length) {
      return Container(
        height: 80,
        padding: const EdgeInsets.all(16),
        color: Colors.grey[850],
        child: const Center(
          child: Text(
            '',
            style: TextStyle(
              color: Colors.grey,
              fontSize: 16,
              fontStyle: FontStyle.italic,
            ),
          ),
        ),
      );
    }

    final activeSubtitle = state.reel.subtitles[state.currentSubtitleIndex];

    return Container(
      height: 200,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(16),
      color: AppColors.primaryBlue.withValues(alpha: 0.1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            state.reel.lingua,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[400],
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            activeSubtitle.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          if (activeSubtitle.translation.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              'Español',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[400],
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              activeSubtitle.translation,
              style: TextStyle(
                color: Colors.grey[300],
                fontSize: 14,
                fontStyle: FontStyle.italic,
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildSubtitlesList(states.VideoPlayerReady state) {
    print(
      '🎨 UI: Construyendo lista de subtítulos - currentSubtitleIndex: ${state.currentSubtitleIndex}',
    );

    return Container(
      color: Colors.grey[900],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la lista
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.grey[850],
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Todos los Subtítulos',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (state.currentSubtitleIndex >= 0)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primaryBlue,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      '${state.currentSubtitleIndex + 1} de ${state.reel.subtitles.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),
          ),

          // Lista de subtítulos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: state.reel.subtitles.length,
              itemBuilder: (context, index) {
                final subtitle = state.reel.subtitles[index];
                final isActive = index == state.currentSubtitleIndex;

                print(
                  '🎨 UI: Subtítulo $index - isActive: $isActive - Tiempo: ${subtitle.startTime} - ${subtitle.endTime}',
                );

                return GestureDetector(
                  onTap: () => _videoPlayerBloc.add(
                    events.VideoPlayerSeekToSubtitle(index),
                  ),
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: isActive
                          ? AppColors.primaryBlue.withValues(alpha: 0.2)
                          : Colors.grey[800],
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isActive
                            ? AppColors.primaryBlue
                            : Colors.transparent,
                        width: 2,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              '${subtitle.startTime} - ${subtitle.endTime}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[400],
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Spacer(),
                            if (subtitle.isWordKey)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.secondaryGreen,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: const Text(
                                  'Clave',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          subtitle.text,
                          style: TextStyle(
                            fontSize: 16,
                            color: isActive ? Colors.white : Colors.grey[300],
                            fontWeight: isActive
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        if (subtitle.translation.isNotEmpty) ...[
                          const SizedBox(height: 8),
                          Text(
                            subtitle.translation,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey[400],
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
