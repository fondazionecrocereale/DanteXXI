import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/radio_station.dart';
import '../blocs/radio/radio_bloc.dart';
import '../blocs/radio/radio_event.dart';
import '../blocs/radio/radio_state.dart';

class RadioStationsGrid extends StatelessWidget {
  const RadioStationsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RadioBloc, RadioState>(
      builder: (context, state) {
        print('🔄 RadioStationsGrid rebuild - State: ${state.runtimeType}');
        if (state is RadioLoaded) {
          print(
            '📻 Current station: ${state.currentStation?.name}, isPlaying: ${state.isPlaying}',
          );
        }

        return state.map(
          initial: (_) => const SizedBox.shrink(),
          loading: (_) => _buildLoadingGrid(),
          loaded: (loadedState) => _buildStationsGrid(context, loadedState),
          error: (errorState) => _buildErrorWidget(context, errorState.message),
        );
      },
    );
  }

  Widget _buildLoadingGrid() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
          ),
          child: const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget _buildStationsGrid(BuildContext context, RadioLoaded state) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85, // Reducido para dar más espacio vertical
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: state.stations.length,
      itemBuilder: (context, index) {
        final station = state.stations[index];
        final isCurrentlyPlaying =
            state.currentStation?.id == station.id && state.isPlaying;

        return _buildStationCard(context, station, isCurrentlyPlaying);
      },
    );
  }

  Widget _buildStationCard(
    BuildContext context,
    RadioStation station,
    bool isPlaying,
  ) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          print('🎯 Click en radio: ${station.name}, isPlaying: $isPlaying');
          if (isPlaying) {
            context.read<RadioBloc>().add(const RadioEvent.pauseStation());
          } else {
            context.read<RadioBloc>().add(RadioEvent.playStation(station));
          }
        },
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(12),
            border: isPlaying
                ? Border.all(color: AppColors.primaryBlue, width: 2)
                : null,
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Logo de la radio
              Expanded(
                flex: 3,
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(12),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: station.logo,
                      fit: BoxFit.contain,
                      placeholder: (context, url) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.radio,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(
                          Icons.radio,
                          size: 28,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              // Información de la radio
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(8, 4, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        station.name,
                        style: const TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        station.category,
                        style: TextStyle(
                          fontSize: 10,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        children: [
                          Icon(
                            isPlaying
                                ? Icons.pause_circle_filled
                                : Icons.play_circle_filled,
                            size: 16,
                            color: isPlaying
                                ? AppColors.primaryBlue
                                : AppColors.textSecondary,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              isPlaying ? 'Reproduciendo' : 'Reproducir',
                              style: TextStyle(
                                fontSize: 9,
                                color: isPlaying
                                    ? AppColors.primaryBlue
                                    : AppColors.textSecondary,
                                fontWeight: FontWeight.w600,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Error al cargar las radios',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            message,
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              context.read<RadioBloc>().add(const RadioEvent.loadStations());
            },
            child: const Text('Reintentar'),
          ),
        ],
      ),
    );
  }
}
