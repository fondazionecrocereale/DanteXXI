import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/radio_station.dart';

class MusicPlayerWidget extends StatefulWidget {
  final RadioStation? currentStation;
  final bool isPlaying;
  final VoidCallback? onPlayPause;
  final VoidCallback? onStop;

  const MusicPlayerWidget({
    super.key,
    this.currentStation,
    required this.isPlaying,
    this.onPlayPause,
    this.onStop,
  });

  @override
  State<MusicPlayerWidget> createState() => _MusicPlayerWidgetState();
}

class _MusicPlayerWidgetState extends State<MusicPlayerWidget> {
  double _volume = 1.0;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _audioPlayer.setVolume(_volume);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.currentStation == null) {
      return const SizedBox.shrink();
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Información de la radio actual
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.radio,
                  size: 30,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentStation!.name,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.currentStation!.category,
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.isPlaying ? 'Reproduciendo...' : 'Pausado',
                      style: TextStyle(
                        fontSize: 11,
                        color: widget.isPlaying
                            ? AppColors.primaryBlue
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Controles de reproducción
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Botón de parar
              IconButton(
                onPressed: widget.onStop,
                icon: const Icon(Icons.stop),
                iconSize: 32,
                color: AppColors.textSecondary,
              ),
              const SizedBox(width: 16),

              // Botón de play/pause
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: IconButton(
                  onPressed: widget.onPlayPause,
                  icon: Icon(
                    widget.isPlaying ? Icons.pause : Icons.play_arrow,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // Control de volumen
          Row(
            children: [
              const Icon(
                Icons.volume_down,
                size: 20,
                color: AppColors.textSecondary,
              ),
              Expanded(
                child: Slider(
                  value: _volume,
                  onChanged: (value) {
                    setState(() {
                      _volume = value;
                    });
                    _audioPlayer.setVolume(value);
                  },
                  activeColor: AppColors.primaryBlue,
                  inactiveColor: AppColors.textSecondary.withValues(alpha: 0.3),
                ),
              ),
              const Icon(
                Icons.volume_up,
                size: 20,
                color: AppColors.textSecondary,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
