import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'reels_event.dart';
import 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  final Dio _dio;

  ReelsBloc({required Dio dio}) : _dio = dio, super(ReelsInitial()) {
    on<LoadReels>(_onLoadReels);
    on<RefreshReels>(_onRefreshReels);
  }

  Future<void> _onLoadReels(LoadReels event, Emitter<ReelsState> emit) async {
    emit(ReelsLoading());

    try {
      final response = await _dio.get('/reels');

      if (response.statusCode == 200) {
        // La API devuelve directamente un array, no un objeto con 'data'
        final List<dynamic> reelsData = response.data;
        final List<Map<String, dynamic>> reels = reelsData
            .map((reel) => Map<String, dynamic>.from(reel))
            .toList();
        emit(ReelsLoaded(reels));
      } else {
        emit(const ReelsError('Error al cargar los reels'));
      }
    } catch (e) {
      emit(ReelsError('Error de conexión: $e'));
    }
  }

  Future<void> _onRefreshReels(
    RefreshReels event,
    Emitter<ReelsState> emit,
  ) async {
    add(const LoadReels());
  }
}
