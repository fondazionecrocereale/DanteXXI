import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'radio_event.dart';
import 'radio_state.dart';
import '../../../core/services/radio_service.dart';
import '../../../domain/entities/radio_station.dart';

class RadioBloc extends Bloc<RadioEvent, RadioState> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  RadioBloc() : super(const RadioState.initial()) {
    on<RadioEvent>((event, emit) async {
      await event.map(
        loadStations: (_) => _onLoadStations(emit),
        playStation: (e) => _onPlayStation(e.station, emit),
        pauseStation: (_) => _onPauseStation(emit),
        stopStation: (_) => _onStopStation(emit),
        setVolume: (e) => _onSetVolume(e.volume, emit),
      );
    });

    // Escuchar cambios en el estado del reproductor
    _audioPlayer.playerStateStream.listen((playerState) {
      print('🎵 Player state changed: ${playerState.processingState}');
      final currentState = state;
      if (currentState is RadioLoaded) {
        if (playerState.processingState == ProcessingState.completed) {
          print('🎵 Stream completado');
          emit(currentState.copyWith(isPlaying: false));
        } else if (playerState.processingState == ProcessingState.ready) {
          print('🎵 Player ready - actualizando estado');
          // Solo actualizar si no está reproduciendo
          if (!currentState.isPlaying) {
            emit(currentState.copyWith(isPlaying: true));
          }
        } else if (playerState.processingState == ProcessingState.buffering) {
          print('🎵 Player buffering');
        }
      }
    });
  }

  Future<void> _onLoadStations(Emitter<RadioState> emit) async {
    emit(const RadioState.loading());
    try {
      final stations = RadioService.getRadioStations();
      emit(RadioState.loaded(stations: stations));
      print('📻 Cargadas ${stations.length} estaciones de radio');
    } catch (e) {
      print('❌ Error al cargar estaciones: $e');
      emit(RadioState.error('Error al cargar las estaciones de radio: $e'));
    }
  }

  Future<void> _onPlayStation(
    RadioStation station,
    Emitter<RadioState> emit,
  ) async {
    try {
      final currentState = state;
      if (currentState is RadioLoaded) {
        print('🎵 Iniciando reproducción de: ${station.name}');

        // Emitir estado inmediatamente para actualizar la UI
        emit(
          currentState.copyWith(
            currentStation: station,
            isPlaying: false, // Primero como false mientras carga
          ),
        );

        // Si hay una estación reproduciéndose, la detenemos
        await _audioPlayer.stop();

        // Configurar el reproductor para mejor compatibilidad
        await _audioPlayer.setAudioSource(
          AudioSource.uri(Uri.parse(station.streamUrl)),
          preload: true,
        );

        // Intentar reproducir
        await _audioPlayer.play();

        // Emitir estado de reproducción exitosa
        emit(currentState.copyWith(currentStation: station, isPlaying: true));

        print('🎵 Reproduciendo exitosamente: ${station.name}');
      }
    } catch (e) {
      print('❌ Error al reproducir radio: $e');
      final currentState = state;
      if (currentState is RadioLoaded) {
        emit(currentState.copyWith(currentStation: null, isPlaying: false));
      }
    }
  }

  Future<void> _onPauseStation(Emitter<RadioState> emit) async {
    try {
      await _audioPlayer.pause();
      final currentState = state;
      if (currentState is RadioLoaded) {
        emit(currentState.copyWith(isPlaying: false));
        print('⏸️ Pausado: ${currentState.currentStation?.name}');
      }
    } catch (e) {
      print('❌ Error al pausar: $e');
      final currentState = state;
      if (currentState is RadioLoaded) {
        emit(currentState.copyWith(isPlaying: false));
      }
    }
  }

  Future<void> _onStopStation(Emitter<RadioState> emit) async {
    try {
      await _audioPlayer.stop();
      final currentState = state;
      if (currentState is RadioLoaded) {
        emit(currentState.copyWith(currentStation: null, isPlaying: false));
        print('⏹️ Detenido');
      }
    } catch (e) {
      print('❌ Error al detener: $e');
      final currentState = state;
      if (currentState is RadioLoaded) {
        emit(currentState.copyWith(currentStation: null, isPlaying: false));
      }
    }
  }

  Future<void> _onSetVolume(double volume, Emitter<RadioState> emit) async {
    try {
      await _audioPlayer.setVolume(volume);
      final currentState = state;
      if (currentState is RadioLoaded) {
        emit(currentState.copyWith(volume: volume));
      }
    } catch (e) {
      emit(RadioState.error('Error al ajustar el volumen: $e'));
    }
  }

  @override
  Future<void> close() {
    _audioPlayer.dispose();
    return super.close();
  }
}
