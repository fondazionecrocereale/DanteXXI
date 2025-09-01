import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_colors.dart';
import '../blocs/radio/radio_bloc.dart';
import '../blocs/radio/radio_event.dart';
import '../blocs/radio/radio_state.dart';
import '../widgets/radio_stations_grid.dart';
import '../widgets/music_player_widget.dart';

class RadioPage extends StatelessWidget {
  const RadioPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Italiana'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Estaciones de Radio',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Escucha las mejores radios italianas en vivo',
                style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
              ),
              const SizedBox(height: 24),
              BlocProvider(
                create: (context) =>
                    RadioBloc()..add(const RadioEvent.loadStations()),
                child: Column(
                  children: [
                    // Reproductor de música
                    BlocBuilder<RadioBloc, RadioState>(
                      builder: (context, state) {
                        print(
                          '🎵 MusicPlayer rebuild - State: ${state.runtimeType}',
                        );
                        if (state is RadioLoaded) {
                          print(
                            '🎵 Current station: ${state.currentStation?.name}, isPlaying: ${state.isPlaying}',
                          );
                        }

                        return state.map(
                          initial: (_) => const SizedBox.shrink(),
                          loading: (_) => const SizedBox.shrink(),
                          loaded: (loadedState) {
                            if (loadedState.currentStation != null) {
                              return Padding(
                                padding: const EdgeInsets.only(bottom: 24),
                                child: MusicPlayerWidget(
                                  currentStation: loadedState.currentStation,
                                  isPlaying: loadedState.isPlaying,
                                  onPlayPause: () {
                                    print(
                                      '🎵 Play/Pause clicked - isPlaying: ${loadedState.isPlaying}',
                                    );
                                    if (loadedState.isPlaying) {
                                      context.read<RadioBloc>().add(
                                        const RadioEvent.pauseStation(),
                                      );
                                    } else {
                                      context.read<RadioBloc>().add(
                                        RadioEvent.playStation(
                                          loadedState.currentStation!,
                                        ),
                                      );
                                    }
                                  },
                                  onStop: () {
                                    print('🎵 Stop clicked');
                                    context.read<RadioBloc>().add(
                                      const RadioEvent.stopStation(),
                                    );
                                  },
                                ),
                              );
                            }
                            return const SizedBox.shrink();
                          },
                          error: (_) => const SizedBox.shrink(),
                        );
                      },
                    ),
                    // Grid de estaciones
                    const RadioStationsGrid(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
