import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart';

class AudiobookPlayerPage extends StatefulWidget {
  final Map<String, dynamic> audiobook;
  final Map<String, dynamic> chapter;
  final int chapterIndex;

  const AudiobookPlayerPage({
    super.key,
    required this.audiobook,
    required this.chapter,
    required this.chapterIndex,
  });

  @override
  State<AudiobookPlayerPage> createState() => _AudiobookPlayerPageState();
}

class _AudiobookPlayerPageState extends State<AudiobookPlayerPage> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool _isPlaying = false;
  Duration _position = Duration.zero;
  Duration _duration = Duration.zero;
  int _currentSubtitleIndex = 0;
  final Set<int> _expandedSubtitles = {};

  // ScrollController para el auto-scroll
  final ScrollController _scrollController = ScrollController();

  // Mapa para almacenar las keys globales de cada subtítulo
  final Map<int, GlobalKey> _subtitleKeys = {};

  @override
  void initState() {
    super.initState();
    _initializeAudio();
    _audioPlayer.positionStream.listen((position) {
      setState(() {
        _position = position;
        _updateCurrentSubtitle();
      });
    });
    _audioPlayer.durationStream.listen((duration) {
      setState(() {
        _duration = duration ?? Duration.zero;
      });
    });

    // Listener para detectar cuando el audio termine
    _audioPlayer.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        debugPrint('🎵 Audio completado - deteniendo reproducción');
        setState(() {
          _isPlaying = false;
          _position = Duration.zero; // Resetear posición al inicio
        });

        // Opcional: mostrar mensaje de que el audio terminó
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text(
                '🎧 Audio completado - Click en play para repetir',
              ),
              duration: const Duration(seconds: 3),
              backgroundColor: const Color(0xFF10B981),
              action: SnackBarAction(
                label: 'REPETIR',
                textColor: Colors.white,
                onPressed: () {
                  _repeatFromBeginning();
                },
              ),
            ),
          );
        }
      }
    });

    // Inicializar las keys globales
    _initializeSubtitleKeys();
  }

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayer.setUrl(widget.audiobook['url'] ?? '');
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  Duration _parseTime(String timeString) {
    try {
      // Manejar formato HH:MM:SS.mmm (con milisegundos)
      if (timeString.contains('.')) {
        final parts = timeString.split('.');
        final timeParts = parts[0].split(':');
        final milliseconds = int.tryParse(parts[1]) ?? 0;

        if (timeParts.length == 3) {
          final hours = int.tryParse(timeParts[0]) ?? 0;
          final minutes = int.tryParse(timeParts[1]) ?? 0;
          final seconds = int.tryParse(timeParts[2]) ?? 0;
          return Duration(
            hours: hours,
            minutes: minutes,
            seconds: seconds,
            milliseconds: milliseconds,
          );
        }
      }

      // Manejar formato HH:MM:SS (sin milisegundos)
      final parts = timeString.split(':');
      if (parts.length == 3) {
        final hours = int.tryParse(parts[0]) ?? 0;
        final minutes = int.tryParse(parts[1]) ?? 0;
        final seconds = int.tryParse(parts[2]) ?? 0;
        return Duration(hours: hours, minutes: minutes, seconds: seconds);
      }

      // Manejar formato MM:SS
      if (parts.length == 2) {
        final minutes = int.tryParse(parts[0]) ?? 0;
        final seconds = int.tryParse(parts[1]) ?? 0;
        return Duration(minutes: minutes, seconds: seconds);
      }

      return Duration.zero;
    } catch (e) {
      debugPrint('Error parsing time: $timeString - $e');
      return Duration.zero;
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  String _formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));

    // Mostrar milisegundos solo si son significativos
    if (duration.inMilliseconds % 1000 > 0) {
      final milliseconds = (duration.inMilliseconds % 1000).toString().padLeft(
        3,
        '0',
      );
      return '$minutes:$seconds.$milliseconds';
    }

    return '$minutes:$seconds';
  }

  void _playPause() {
    if (_isPlaying) {
      _pause();
    } else {
      _play();
    }
  }

  void _play() {
    _audioPlayer.play();
    setState(() => _isPlaying = true);
  }

  void _pause() {
    _audioPlayer.pause();
    setState(() => _isPlaying = false);
  }

  void _seekTo(Duration position) {
    _audioPlayer.seek(position);
  }

  // Reproducir desde el inicio y marcar el primer subtítulo
  void _repeatFromBeginning() {
    debugPrint('🔄 Reproduciendo desde el inicio');

    // Resetear estado
    setState(() {
      _currentSubtitleIndex = 0; // Primer subtítulo
      _position = Duration.zero;
      _expandedSubtitles.clear(); // Cerrar todas las traducciones
    });

    // Hacer seek al inicio del audio
    _audioPlayer.seek(Duration.zero);

    // Reproducir automáticamente
    _audioPlayer.play();
    setState(() => _isPlaying = true);

    // Auto-scroll al primer subtítulo
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToCurrentSubtitle();
    });

    // Backup adicional para asegurar el scroll
    Future.delayed(const Duration(milliseconds: 200), () {
      if (mounted) {
        _scrollToCurrentSubtitle();
      }
    });

    // Mostrar feedback visual
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('🔄 Reproduciendo desde el inicio'),
        duration: Duration(seconds: 2),
        backgroundColor: Color(0xFF3B82F6),
      ),
    );
  }

  void _toggleSubtitleExpansion(int index) {
    setState(() {
      if (_expandedSubtitles.contains(index)) {
        _expandedSubtitles.remove(index);
      } else {
        _expandedSubtitles.add(index);
      }
    });
  }

  void _seekToSubtitle(int index) {
    final subtitles = widget.chapter['subtitles'] as List<dynamic>? ?? [];
    if (index < subtitles.length) {
      final subtitle = subtitles[index];
      final rawTime = subtitle['startTime'] ?? '00:00:00';
      final startTime = _parseTime(rawTime);

      debugPrint('🎯 Seek a subtítulo $index: ${subtitle['text'] ?? ''}');
      debugPrint('   Tiempo raw: $rawTime');
      debugPrint('   Tiempo parsed: ${_formatTime(startTime)}');
      debugPrint('   Duration: ${startTime.inMilliseconds}ms');

      // Verificar que el tiempo sea válido
      if (startTime > Duration.zero) {
        // Actualizar el índice del subtítulo actual PRIMERO
        setState(() {
          _currentSubtitleIndex = index;
        });

        // Hacer seek en el audio
        _audioPlayer.seek(startTime);

        // Auto-scroll al subtítulo seleccionado con múltiples intentos
        WidgetsBinding.instance.addPostFrameCallback((_) {
          _scrollToCurrentSubtitle();
        });

        // Backup adicional para asegurar el scroll
        Future.delayed(const Duration(milliseconds: 150), () {
          if (mounted) {
            _scrollToCurrentSubtitle();
          }
        });

        // Backup final para casos extremos
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted) {
            _scrollToCurrentSubtitle();
          }
        });

        // Mostrar feedback visual
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Saltando a: ${subtitle['text'] ?? ''}'),
            duration: const Duration(seconds: 1),
            backgroundColor: const Color(0xFF3B82F6),
          ),
        );
      } else {
        debugPrint('⚠️ Tiempo inválido para subtítulo $index');
      }
    } else {
      debugPrint('⚠️ Índice de subtítulo fuera de rango: $index');
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    _scrollController.dispose();
    _subtitleKeys.clear();
    super.dispose();
  }

  // Inicializar las keys globales para todos los subtítulos
  void _initializeSubtitleKeys() {
    for (int i = 0; i < widget.chapter['subtitles'].length; i++) {
      _subtitleKeys[i] = GlobalKey();
    }
  }

  // Actualizar el subtítulo actual basado en la posición del audio
  void _updateCurrentSubtitle() {
    final subtitles = widget.chapter['subtitles'] as List<dynamic>? ?? [];
    if (subtitles.isEmpty) return;

    // Buscar el subtítulo actual basado en la posición del audio
    int newIndex = -1;
    for (int i = 0; i < subtitles.length; i++) {
      final subtitle = subtitles[i];
      final startTime = _parseTime(subtitle['startTime'] ?? '00:00:00');
      final endTime = _parseTime(subtitle['endTime'] ?? '00:00:00');

      // Verificar si la posición actual está dentro del rango del subtítulo
      if (_position >= startTime && _position < endTime) {
        newIndex = i;
        break;
      }
    }

    // Solo actualizar si encontramos un subtítulo diferente
    if (newIndex != -1 && newIndex != _currentSubtitleIndex) {
      setState(() {
        _currentSubtitleIndex = newIndex;
      });

      // Auto-scroll al subtítulo actual después de un pequeño delay
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToCurrentSubtitle();
      });

      // Backup adicional después de un delay más largo
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          _scrollToCurrentSubtitle();
        }
      });

      debugPrint(
        '🔄 Subtítulo actualizado: $_currentSubtitleIndex -> $newIndex',
      );
      debugPrint('   Posición audio: ${_formatTime(_position)}');
    }
  }

  // Scroll al subtítulo actual para que se vea en la parte superior
  void _scrollToCurrentSubtitle() {
    if (!_scrollController.hasClients) return;

    try {
      // Obtener la key del subtítulo actual
      final currentKey = _subtitleKeys[_currentSubtitleIndex];
      if (currentKey?.currentContext == null) {
        debugPrint(
          '⚠️ Context no disponible para subtítulo $_currentSubtitleIndex',
        );
        // Usar fallback si no hay context
        _scrollToCurrentSubtitleFallback();
        return;
      }

      // Obtener la posición exacta del subtítulo usando RenderBox
      final RenderBox renderBox =
          currentKey!.currentContext!.findRenderObject() as RenderBox;
      final position = renderBox.localToGlobal(Offset.zero);

      // Calcular el offset necesario para posicionar el subtítulo EXACTAMENTE en la parte superior
      // Consideramos la altura del AppBar y un pequeño margen
      final appBarHeight = 56.0; // Altura estándar del AppBar
      final topMargin = 100.0; // Margen superior adicional

      final targetOffset =
          _scrollController.offset + position.dy - appBarHeight - topMargin;

      // Obtener límites del scroll
      final maxOffset = _scrollController.position.maxScrollExtent;
      final adjustedOffset = targetOffset.clamp(0.0, maxOffset);

      // Solo hacer scroll si es necesario
      if ((adjustedOffset - _scrollController.offset).abs() > 10) {
        // Scroll suave al subtítulo actual
        _scrollController.animateTo(
          adjustedOffset,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
        );

        debugPrint('🔄 Auto-scroll: Subtítulo $_currentSubtitleIndex');
        debugPrint('   Posición real: ${position.dy}');
        debugPrint('   Target: $targetOffset, Adjusted: $adjustedOffset');
        debugPrint('   AppBar Height: $appBarHeight, Top Margin: $topMargin');
      } else {
        debugPrint('✅ No es necesario hacer scroll');
      }
    } catch (e) {
      debugPrint('Error en auto-scroll: $e');
      // Fallback al método anterior si falla
      _scrollToCurrentSubtitleFallback();
    }
  }

  // Método fallback para casos donde el método principal falla
  void _scrollToCurrentSubtitleFallback() {
    try {
      // Calcular altura más precisa basada en el contenido real
      final itemHeight = 80.0; // Altura aproximada de subtítulo + margen
      final appBarHeight = 56.0; // Altura del AppBar
      final topMargin = 20.0; // Margen superior mínimo

      final targetOffset =
          (_currentSubtitleIndex * itemHeight) + appBarHeight + topMargin;
      final maxOffset = _scrollController.position.maxScrollExtent;
      final adjustedOffset = targetOffset.clamp(0.0, maxOffset);

      _scrollController.animateTo(
        adjustedOffset,
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
      );

      debugPrint('🔄 Fallback scroll: Subtítulo $_currentSubtitleIndex');
      debugPrint(
        '   Item Height: $itemHeight, AppBar Height: $appBarHeight, Top Margin: $topMargin',
      );
      debugPrint('   Target: $targetOffset, Adjusted: $adjustedOffset');
    } catch (e) {
      debugPrint('Error en fallback scroll: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Barra superior minimalista
            _buildTopBar(),

            // Contenido del libro - página limpia
            Expanded(child: _buildBookPage()),

            // Indicador de progreso del capítulo
            // _buildChapterProgress(),

            // Indicador de auto-scroll (solo en debug)
            //if (kDebugMode) _buildAutoScrollIndicator(),

            // Debug info (solo en debug)
            // if (kDebugMode) _buildDebugInfo(),

            // Reproductor elegante
            _buildElegantPlayer(),
          ],
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    final progress = _duration.inMilliseconds > 0
        ? (_position.inMilliseconds / _duration.inMilliseconds * 100).round()
        : 0;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        children: [
          // Información del capítulo
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.chapter['capitolo'] ?? 'Capitolo'} ($progress%)',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF6B46C1),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${widget.audiobook['author'] ?? ''} - ${widget.audiobook['name'] ?? ''}',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF9CA3AF),
                  ),
                ),
              ],
            ),
          ),

          // Iconos de la derecha
          Row(
            children: [
              Icon(Icons.more_vert, color: Colors.black87, size: 20),
              const SizedBox(width: 12),
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: const Color(0xFF10B981), width: 2),
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildBookPage() {
    final subtitles = widget.chapter['subtitles'] as List<dynamic>? ?? [];

    if (subtitles.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.menu_book_outlined,
              size: 48,
              color: const Color(0xFF9CA3AF),
            ),
            const SizedBox(height: 16),
            Text(
              'Página en blanco',
              style: GoogleFonts.inter(
                fontSize: 18,
                color: const Color(0xFF6B7280),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Contenido del texto
          Expanded(
            child: ListView.builder(
              controller: _scrollController, // Agregar el ScrollController
              itemCount: subtitles.length,
              itemBuilder: (context, index) {
                final subtitle = subtitles[index];
                final isCurrent = index == _currentSubtitleIndex;
                final isExpanded = _expandedSubtitles.contains(index);
                final translation = subtitle['translation'] ?? '';

                // Crear o obtener la key global para este subtítulo
                _subtitleKeys[index] ??= GlobalKey();

                return Container(
                  key: _subtitleKeys[index], // Asignar la key global
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Texto principal con botón de traducción
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                          horizontal: 16,
                        ),
                        decoration: BoxDecoration(
                          color: isCurrent
                              ? const Color(0xFF3B82F6).withOpacity(0.15)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(8),
                          border: isCurrent
                              ? Border.all(
                                  color: const Color(0xFF3B82F6),
                                  width: 2.0,
                                )
                              : null,
                          boxShadow: isCurrent
                              ? [
                                  BoxShadow(
                                    color: const Color(
                                      0xFF3B82F6,
                                    ).withOpacity(0.2),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ]
                              : null,
                        ),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Botón de ojo para mostrar/ocultar traducción
                            GestureDetector(
                              onTap: () => _toggleSubtitleExpansion(index),
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: isCurrent
                                      ? const Color(0xFF3B82F6)
                                      : const Color(0xFF9CA3AF),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  isExpanded
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),

                            // Indicador de subtítulo actual
                            if (isCurrent) ...[
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF3B82F6),
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Text(
                                  'ACTUAL',
                                  style: GoogleFonts.inter(
                                    fontSize: 8,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                            const SizedBox(width: 12),
                            // Texto del subtítulo
                            Expanded(
                              child: GestureDetector(
                                onTap: () => _seekToSubtitle(index),
                                child: Text(
                                  subtitle['text'] ?? '',
                                  style: GoogleFonts.crimsonText(
                                    fontSize: 16,
                                    height: 1.6,
                                    color: isCurrent
                                        ? Colors.black87
                                        : Colors.black54,
                                    fontWeight: isCurrent
                                        ? FontWeight.w600
                                        : FontWeight.w400,
                                  ),
                                  textAlign: TextAlign.justify,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Traducción expandible
                      if (isExpanded && translation.isNotEmpty)
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          margin: const EdgeInsets.only(top: 8, left: 16),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: const Color(0xFFF3F4F6),
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: const Color(0xFFE5E7EB)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                translation,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  color: const Color(0xFF374151),
                                  fontStyle: FontStyle.italic,
                                  height: 1.4,
                                ),
                              ),
                              const SizedBox(height: 8),
                              // Indicador de tiempo discreto
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 6,
                                      vertical: 2,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFE5E7EB),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Text(
                                      _formatTime(
                                        _parseTime(
                                          subtitle['startTime'] ?? '00:00:00',
                                        ),
                                      ),
                                      style: GoogleFonts.inter(
                                        fontSize: 10,
                                        color: const Color(0xFF6B7280),
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChapterProgress() {
    final subtitles = widget.chapter['subtitles'] as List<dynamic>? ?? [];
    if (subtitles.isEmpty) return const SizedBox.shrink();

    final currentSubtitle = subtitles[_currentSubtitleIndex];
    final startTime = _parseTime(currentSubtitle['startTime'] ?? '00:00:00');
    final endTime = _parseTime(currentSubtitle['endTime'] ?? '00:00:00');

    // Calcular progreso del subtítulo actual
    double subtitleProgress = 0.0;
    if (endTime > startTime) {
      final subtitleDuration = endTime - startTime;
      final elapsedInSubtitle = _position - startTime;
      if (elapsedInSubtitle.inMilliseconds > 0) {
        subtitleProgress =
            elapsedInSubtitle.inMilliseconds / subtitleDuration.inMilliseconds;
        subtitleProgress = subtitleProgress.clamp(0.0, 1.0);
      }
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: Column(
        children: [
          // Barra de progreso del subtítulo actual
          LinearProgressIndicator(
            value: subtitleProgress,
            backgroundColor: const Color(0xFFE5E7EB),
            valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF3B82F6)),
            minHeight: 4,
          ),
          const SizedBox(height: 8),
          // Información del subtítulo actual
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Subtítulo ${_currentSubtitleIndex + 1} de ${subtitles.length}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF6B7280),
                ),
              ),
              Text(
                '${_formatTime(_position)} / ${_formatTime(_duration)}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  color: const Color(0xFF6B7280),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAutoScrollIndicator() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFE8F5E8),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFF4CAF50)),
      ),
      child: Row(
        children: [
          Icon(Icons.auto_awesome, color: const Color(0xFF4CAF50), size: 16),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Auto-scroll activado',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    color: const Color(0xFF2E7D32),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  'Subtítulo ${_currentSubtitleIndex + 1} de ${widget.chapter['subtitles']?.length ?? 0} visible',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    color: const Color(0xFF2E7D32),
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: const Color(0xFF4CAF50),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              'ON',
              style: GoogleFonts.inter(
                fontSize: 10,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDebugInfo() {
    final subtitles = widget.chapter['subtitles'] as List<dynamic>? ?? [];
    if (subtitles.isEmpty) return const SizedBox.shrink();

    final currentSubtitle = subtitles[_currentSubtitleIndex];
    final startTime = _parseTime(currentSubtitle['startTime'] ?? '00:00:00');
    final endTime = _parseTime(currentSubtitle['endTime'] ?? '00:00:00');

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF3CD),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: const Color(0xFFFFEAA7)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🔍 Debug Info',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF856404),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Posición: ${_formatTime(_position)}',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF856404),
            ),
          ),
          Text(
            'Subtítulo: ${_currentSubtitleIndex + 1}',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF856404),
            ),
          ),
          Text(
            'Rango: ${_formatTime(startTime)} - ${_formatTime(endTime)}',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF856404),
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '📏 Scroll Info:',
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF856404),
            ),
          ),
          Text(
            'Target: ${(_currentSubtitleIndex * 85.0 + 16.0).toStringAsFixed(1)}',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF856404),
            ),
          ),
          Text(
            'Current: ${_scrollController.hasClients ? _scrollController.offset.toStringAsFixed(1) : '0.0'}',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF856404),
            ),
          ),
          Text(
            'Max: ${_scrollController.hasClients ? _scrollController.position.maxScrollExtent.toStringAsFixed(1) : '0.0'}',
            style: GoogleFonts.inter(
              fontSize: 10,
              color: const Color(0xFF856404),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildElegantPlayer() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          // Menú
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.menu, color: const Color(0xFF6B7280), size: 20),
          ),

          const SizedBox(width: 16),

          // Navegación
          Icon(Icons.chevron_left, color: const Color(0xFF9CA3AF), size: 24),

          const SizedBox(width: 16),

          // Botón de reproducción principal
          GestureDetector(
            onTap: _playPause,
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF3B82F6),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF3B82F6).withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.white,
                size: 28,
              ),
            ),
          ),

          const SizedBox(width: 16),

          // Navegación
          Icon(Icons.chevron_right, color: const Color(0xFF9CA3AF), size: 24),

          const Spacer(),

          // Idioma
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: const Color(0xFFF3F4F6),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              'ES',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: const Color(0xFF374151),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
