import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';
import '../../domain/entities/audiobook.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AudiobookSection extends StatefulWidget {
  const AudiobookSection({super.key});

  @override
  State<AudiobookSection> createState() => _AudiobookSectionState();
}

class _AudiobookSectionState extends State<AudiobookSection> {
  List<Audiobook> _audiobooks = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadAudiobooks();
  }

  Future<void> _loadAudiobooks() async {
    try {
      setState(() {
        _isLoading = true;
        _error = null;
      });

      final jsonString = await rootBundle.loadString(
        'assets/data/italian_audiobooks.json',
      );
      final jsonData = json.decode(jsonString);

      final List<Audiobook> allAudiobooks = [];

      for (final audiobookData in jsonData) {
        final chapters = (audiobookData['capitoli'] as List<dynamic>?) ?? [];
        final List<AudioChapter> audioChapters = [];

        for (final chapter in chapters) {
          final subtitles = (chapter['subtitles'] as List<dynamic>?) ?? [];
          final List<AudioSubtitle> audioSubtitles = [];

          for (final subtitle in subtitles) {
            final audioSubtitle = AudioSubtitle(
              text: subtitle['text'] ?? '',
              startTime: subtitle['startTime'] ?? '00:00:00.000',
              endTime: subtitle['endTime'] ?? '00:00:00.000',
              translation: subtitle['translation'] ?? '',
              translationEN: subtitle['translationEN'] ?? '',
              translationPR: subtitle['translationPR'] ?? '',
              isWordKey: subtitle['isWordKey'] ?? false,
            );
            audioSubtitles.add(audioSubtitle);
          }

          final audioChapter = AudioChapter(
            id: chapter['capitolo'] ?? '',
            title: chapter['capitolo'] ?? 'Capítulo',
            duration: Duration(minutes: chapter['duration'] ?? 0),
            subtitles: audioSubtitles,
          );
          audioChapters.add(audioChapter);
        }

        final audiobook = Audiobook(
          id: audiobookData['name'] ?? '',
          title: audiobookData['name'] ?? '',
          author: audiobookData['author'] ?? '',
          description: audiobookData['description'] ?? '',
          coverImage: audiobookData['image'] ?? '',
          audioUrl: audiobookData['url'] ?? '',
          duration: Duration(minutes: audiobookData['duration'] ?? 0),
          level: audiobookData['level'] ?? 'A1',
          chapters: audioChapters,
          isBookmarked: false,
          progress: 0.0,
        );

        allAudiobooks.add(audiobook);
      }

      setState(() {
        _audiobooks = allAudiobooks;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading audiobooks: $e');
      setState(() {
        _error = 'Error al cargar audiolibros: $e';
        _isLoading = false;
      });
      // Fallback a datos de muestra si hay error
      _audiobooks = _generateSampleAudiobooks();
    }
  }

  List<Audiobook> _generateSampleAudiobooks() {
    return [
      Audiobook(
        id: '1',
        title: 'La Divina Comedia - Infierno',
        author: 'Dante Alighieri',
        description:
            'Primera parte de la obra maestra de Dante, narrando su viaje por los nueve círculos del infierno.',
        coverImage: 'assets/images/divina_comedia_inferno.jpg',
        audioUrl: 'https://example.com/audio/inferno.mp3',
        duration: Duration(minutes: 45),
        level: 'B1',
        chapters: [
          AudioChapter(
            id: '1',
            title: 'Canto I: La Selva Oscura',
            duration: Duration(minutes: 8),
            subtitles: [],
          ),
          AudioChapter(
            id: '2',
            title: 'Canto II: Virgilio',
            duration: Duration(minutes: 10),
            subtitles: [],
          ),
          AudioChapter(
            id: '3',
            title: 'Canto III: La Puerta del Infierno',
            duration: Duration(minutes: 12),
            subtitles: [],
          ),
        ],
        isBookmarked: false,
        progress: 0.0,
      ),
      Audiobook(
        id: '2',
        title: 'Cuentos Italianos Clásicos',
        author: 'Varios Autores',
        description:
            'Una colección de cuentos populares italianos, perfectos para principiantes.',
        coverImage: 'assets/images/cuentos_italianos.jpg',
        audioUrl: 'https://example.com/audio/cuentos.mp3',
        duration: Duration(minutes: 30),
        level: 'A2',
        chapters: [
          AudioChapter(
            id: '1',
            title: 'Pinocchio',
            duration: Duration(minutes: 15),
            subtitles: [],
          ),
          AudioChapter(
            id: '2',
            title: 'La Bella y la Bestia',
            duration: Duration(minutes: 15),
            subtitles: [],
          ),
        ],
        isBookmarked: true,
        progress: 0.5,
      ),
      Audiobook(
        id: '3',
        title: 'Gramática Italiana en Audio',
        author: 'Prof. Maria Rossi',
        description:
            'Aprende gramática italiana de manera auditiva con ejemplos prácticos.',
        coverImage: 'assets/images/gramatica_italiana.jpg',
        audioUrl: 'https://example.com/audio/gramatica.mp3',
        duration: Duration(minutes: 60),
        level: 'A1',
        chapters: [
          AudioChapter(
            id: '1',
            title: 'Artículos',
            duration: Duration(minutes: 10),
            subtitles: [],
          ),
          AudioChapter(
            id: '2',
            title: 'Sustantivos',
            duration: Duration(minutes: 12),
            subtitles: [],
          ),
          AudioChapter(
            id: '3',
            title: 'Adjetivos',
            duration: Duration(minutes: 15),
            subtitles: [],
          ),
          AudioChapter(
            id: '4',
            title: 'Verbos',
            duration: Duration(minutes: 23),
            subtitles: [],
          ),
        ],
        isBookmarked: false,
        progress: 0.0,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(color: AppColors.primaryBlue),
      );
    }

    return Container(
      color: AppColors.backgroundCard,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Descubre el italiano a través de la literatura',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: _audiobooks.length,
              itemBuilder: (context, index) {
                return AudiobookCard(
                  audiobook: _audiobooks[index],
                  onTap: () => _onAudiobookTap(_audiobooks[index]),
                  onBookmarkToggle: () => _toggleBookmark(_audiobooks[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _onAudiobookTap(Audiobook audiobook) {
    // Aquí navegarías al reproductor de audiolibros
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo: ${audiobook.title}'),
        backgroundColor: AppColors.primaryBlue,
      ),
    );
  }

  void _toggleBookmark(Audiobook audiobook) {
    setState(() {
      final index = _audiobooks.indexWhere((a) => a.id == audiobook.id);
      if (index != -1) {
        _audiobooks[index] = _audiobooks[index].copyWith(
          isBookmarked: !_audiobooks[index].isBookmarked,
        );
      }
    });
  }
}

class AudiobookCard extends StatelessWidget {
  final Audiobook audiobook;
  final VoidCallback onTap;
  final VoidCallback onBookmarkToggle;

  const AudiobookCard({
    super.key,
    required this.audiobook,
    required this.onTap,
    required this.onBookmarkToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              // Cover Image
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: AppColors.primaryBlue.withOpacity(0.1),
                ),
                child: Icon(
                  Icons.headphones,
                  size: 40,
                  color: AppColors.primaryBlue,
                ),
              ),
              const SizedBox(width: 16),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            audiobook.title,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        IconButton(
                          onPressed: onBookmarkToggle,
                          icon: Icon(
                            audiobook.isBookmarked
                                ? Icons.bookmark
                                : Icons.bookmark_border,
                            color: audiobook.isBookmarked
                                ? AppColors.primaryBlue
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      audiobook.author,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      audiobook.description,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.primaryBlue.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Text(
                            audiobook.level,
                            style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${audiobook.duration.inMinutes} min',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const Spacer(),
                        if (audiobook.progress > 0)
                          Text(
                            '${(audiobook.progress * 100).toInt()}%',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              color: AppColors.primaryBlue,
                            ),
                          ),
                      ],
                    ),
                    if (audiobook.progress > 0) ...[
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: audiobook.progress,
                        backgroundColor: AppColors.backgroundCard,
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBlue,
                        ),
                      ),
                    ],
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
