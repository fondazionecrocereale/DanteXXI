import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'audiobook_player_page.dart';

class AudiobookDetailsPage extends StatefulWidget {
  final Map<String, dynamic> audiobook;

  const AudiobookDetailsPage({
    super.key,
    required this.audiobook,
  });

  @override
  State<AudiobookDetailsPage> createState() => _AudiobookDetailsPageState();
}

class _AudiobookDetailsPageState extends State<AudiobookDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // App bar personalizado con imagen de fondo
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: AppColors.primaryBlue,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  // Imagen de fondo
                  Image.network(
                    widget.audiobook['image'] ?? '',
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: AppColors.borderLight,
                        child: Icon(
                          Icons.book,
                          size: 80,
                          color: AppColors.textSecondary,
                        ),
                      );
                    },
                  ),
                  // Gradiente oscuro para mejor legibilidad
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withValues(alpha: 0.7),
                        ],
                      ),
                    ),
                  ),
                  // Información del audiolibro
                  Positioned(
                    bottom: 20,
                    left: 20,
                    right: 20,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: _getLevelColor(widget.audiobook['level']).withValues(alpha: 0.9),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.audiobook['level'] ?? '',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          widget.audiobook['name'] ?? '',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.audiobook['author'] ?? '',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white.withValues(alpha: 0.9),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.play_circle_filled, color: Colors.white, size: 32),
                onPressed: () => _playAudiobook(),
              ),
            ],
          ),
          
          // Contenido del audiolibro
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Descripción
                  Text(
                    'Descripción',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.audiobook['description'] ?? '',
                    style: TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // Información adicional
                  _buildInfoSection(),
                  const SizedBox(height: 24),
                  
                  // Capítulos
                  Text(
                    'Capítulos',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildChaptersList(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Column(
        children: [
          _buildInfoRow('Categoría', widget.audiobook['category'] ?? ''),
          _buildInfoRow('Género', widget.audiobook['genere'] ?? ''),
          _buildInfoRow('Año', widget.audiobook['anno'] ?? ''),
          _buildInfoRow('Duración', widget.audiobook['duration'] ?? ''),
          _buildInfoRow('Idioma', _getLanguageName(widget.audiobook['lingua'] ?? '')),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildChaptersList() {
    final chapters = widget.audiobook['capitoli'] as List<dynamic>? ?? [];
    
    if (chapters.isEmpty) {
      return Center(
        child: Column(
          children: [
            Icon(Icons.book, size: 48, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              'No hay capítulos disponibles',
              style: TextStyle(
                fontSize: 16,
                color: AppColors.textSecondary,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: chapters.length,
      itemBuilder: (context, index) {
        final chapter = chapters[index];
        return _buildChapterCard(chapter, index);
      },
    );
  }

  Widget _buildChapterCard(Map<String, dynamic> chapter, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.borderLight),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () => _navigateToPlayer(chapter, index),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Número del capítulo
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: AppColors.primaryBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryBlue,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                // Información del capítulo
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chapter['capitolo'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(Icons.access_time, size: 16, color: AppColors.textSecondary),
                          const SizedBox(width: 4),
                          Text(
                            chapter['duration'] ?? '',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                
                // Icono de play
                Icon(
                  Icons.play_circle_outline,
                  size: 28,
                  color: AppColors.primaryBlue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Color _getLevelColor(String? level) {
    switch (level) {
      case 'A1':
      case 'A2':
        return AppColors.success;
      case 'B1':
      case 'B2':
        return AppColors.warning;
      case 'C1':
      case 'C2':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  String _getLanguageName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'it':
        return 'Italiano';
      case 'es':
        return 'Español';
      case 'en':
        return 'Inglés';
      case 'fr':
        return 'Francés';
      case 'de':
        return 'Alemán';
      default:
        return languageCode;
    }
  }

  void _playAudiobook() {
    // Reproducir desde el primer capítulo
    final chapters = widget.audiobook['capitoli'] as List<dynamic>? ?? [];
    if (chapters.isNotEmpty) {
      _navigateToPlayer(chapters[0], 0);
    }
  }

  void _navigateToPlayer(Map<String, dynamic> chapter, int chapterIndex) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AudiobookPlayerPage(
          audiobook: widget.audiobook,
          chapter: chapter,
          chapterIndex: chapterIndex,
        ),
      ),
    );
  }
}
