import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:google_fonts/google_fonts.dart';

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
  Set<int> _expandedSubtitles = {};

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
  }

  Future<void> _initializeAudio() async {
    try {
      await _audioPlayer.setUrl(widget.audiobook['url'] ?? '');
    } catch (e) {
      debugPrint('Error loading audio: $e');
    }
  }

  void _updateCurrentSubtitle() {
    final subtitles = widget.chapter['subtitles'] as List<dynamic>? ?? [];
    if (subtitles.isEmpty) return;

    for (int i = 0; i < subtitles.length; i++) {
      final subtitle = subtitles[i];
      final startTime = _parseTime(subtitle['startTime'] ?? '00:00:00');
      final endTime = _parseTime(subtitle['endTime'] ?? '00:00:00');

      if (_position >= startTime && _position <= endTime) {
        setState(() {
          _currentSubtitleIndex = i;
        });
        break;
      }
    }
  }

  Duration _parseTime(String timeString) {
    final parts = timeString.split(':');
    if (parts.length == 3) {
      final hours = int.tryParse(parts[0]) ?? 0;
      final minutes = int.tryParse(parts[1]) ?? 0;
      final seconds = int.tryParse(parts[2]) ?? 0;
      return Duration(hours: hours, minutes: minutes, seconds: seconds);
    }
    return Duration.zero;
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  void _playPause() {
    if (_isPlaying) {
      _audioPlayer.pause();
    } else {
      _audioPlayer.play();
    }
    setState(() {
      _isPlaying = !_isPlaying;
    });
  }

  void _seekTo(Duration position) {
    _audioPlayer.seek(position);
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
      final startTime = _parseTime(subtitle['startTime'] ?? '00:00:00');
      _audioPlayer.seek(startTime);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
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
          // Título del capítulo
          Text(
            widget.chapter['capitolo'] ?? 'Capitolo',
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
              letterSpacing: 1.2,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 32),

          // Contenido del texto
          Expanded(
            child: ListView.builder(
              itemCount: subtitles.length,
              itemBuilder: (context, index) {
                final subtitle = subtitles[index];
                final isCurrent = index == _currentSubtitleIndex;
                final isExpanded = _expandedSubtitles.contains(index);
                final translation = subtitle['translation'] ?? '';

                return Container(
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Texto principal
                      GestureDetector(
                        onTap: () => _seekToSubtitle(index),
                        onDoubleTap: () => _toggleSubtitleExpansion(index),
                        child: Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          decoration: BoxDecoration(
                            color: isCurrent
                                ? const Color(0xFFD1FAE5)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            subtitle['text'] ?? '',
                            style: GoogleFonts.crimsonText(
                              fontSize: 16,
                              height: 1.6,
                              color: Colors.black87,
                            ),
                            textAlign: TextAlign.justify,
                          ),
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
                          child: Text(
                            translation,
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              color: const Color(0xFF374151),
                              fontStyle: FontStyle.italic,
                              height: 1.4,
                            ),
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
