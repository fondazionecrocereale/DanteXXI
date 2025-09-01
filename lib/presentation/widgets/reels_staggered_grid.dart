import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../core/constants/app_colors.dart';
import '../../domain/entities/reel.dart';
import '../blocs/reels/reels_bloc.dart';
import '../blocs/reels/reels_event.dart';
import '../blocs/reels/reels_state.dart';
import 'reels_staggered_shimmer.dart';
import '../pages/video_player_page.dart';

class ReelsStaggeredGrid extends StatelessWidget {
  const ReelsStaggeredGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReelsBloc, ReelsState>(
      builder: (context, state) {
        if (state is ReelsLoading) {
          return const ReelsStaggeredShimmer();
        }

        if (state is ReelsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                const SizedBox(height: 16),
                Text(
                  'Error al cargar los reels',
                  style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                ),
                const SizedBox(height: 8),
                Text(
                  state.message,
                  style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<ReelsBloc>().add(const RefreshReels());
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        if (state is ReelsLoaded) {
          if (state.reels.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.video_library_outlined,
                    size: 64,
                    color: Colors.grey[400],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'No hay reels disponibles',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                  ),
                ],
              ),
            );
          }

          return MasonryGridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
            itemCount: state.reels.length,
            itemBuilder: (context, index) {
              final reel = state.reels[index];
              return _buildReelCard(context, reel);
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildReelCard(BuildContext context, Map<String, dynamic> reel) {
    final imageUrl = reel['image'] ?? '';
    final title = reel['name'] ?? 'Sin título';
    final description = reel['description'] ?? '';
    final author = reel['author'] ?? '';
    final category = reel['category'] ?? '';
    final livello = reel['livello'] ?? '';
    final views = reel['views'] ?? 0;
    final url = reel['url'] ?? '';

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Crear un objeto Reel a partir de los datos del reel
          final reelObject = Reel(
            id: reel['id'] ?? 0,
            name: title,
            author: author,
            description: description,
            image: imageUrl,
            url: url,
            lingua: reel['lingua'] ?? 'it',
            livello: livello,
            category: category,
            chiave: reel['chiave'] ?? '',
            chiaveTranslation: reel['chiaveTranslation'] ?? '',
            chiaveTranslationEN: reel['chiaveTranslationEN'] ?? '',
            chiaveTranslationPR: reel['chiaveTranslationPR'] ?? '',
            views: _getViewCount(views),
            visible: reel['visible'] ?? true,
            createdAt: reel['createdAt'] != null
                ? DateTime.parse(reel['createdAt'])
                : DateTime.now(),
            subtitles:
                (reel['subtitles'] as List<dynamic>?)
                    ?.map((subtitle) => Subtitle.fromJson(subtitle))
                    .toList() ??
                [],
          );

          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => VideoPlayerPage(reel: reelObject),
            ),
          );
        },
        child: Container(
          height: 280, // Altura fija para el Stack
          decoration: BoxDecoration(
            color: AppColors.backgroundCard,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: AppColors.shadowLight.withValues(alpha: 0.1),
                blurRadius: 12,
                offset: const Offset(0, 4),
                spreadRadius: 0,
              ),
              BoxShadow(
                color: AppColors.shadowLight.withValues(alpha: 0.05),
                blurRadius: 4,
                offset: const Offset(0, 2),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Imagen de fondo que cubre toda la tarjeta
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: CachedNetworkImage(
                  imageUrl: imageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                  placeholder: (context, url) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[300]!, Colors.grey[400]!],
                      ),
                    ),
                    child: const Center(
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        valueColor: AlwaysStoppedAnimation<Color>(
                          AppColors.primaryBlue,
                        ),
                      ),
                    ),
                  ),
                  errorWidget: (context, url, error) => Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [Colors.grey[300]!, Colors.grey[400]!],
                      ),
                    ),
                    child: const Icon(
                      Icons.video_library_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),

              // Gradiente overlay para mejor contraste del texto
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.1),
                      Colors.black.withValues(alpha: 0.3),
                      Colors.black.withValues(alpha: 0.6),
                    ],
                    stops: const [0.0, 0.5, 0.7, 1.0],
                  ),
                ),
              ),

              // Indicador de video
              Positioned(
                top: 12,
                right: 12,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),

              // Duración del video
              Positioned(
                top: 12,
                left: 12,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.8),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Text(
                    '3:45',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              // Contenido del reel superpuesto sobre la imagen
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.fromLTRB(12, 16, 12, 12),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(16),
                      bottomRight: Radius.circular(16),
                    ),
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.8),
                      ],
                      stops: const [0.0, 1.0],
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Título más compacto
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),

                      const SizedBox(height: 4),

                      // Autor y descripción en una sola línea
                      Row(
                        children: [
                          if (author.isNotEmpty) ...[
                            Icon(
                              Icons.person_outline,
                              size: 12,
                              color: Colors.white.withValues(alpha: 0.8),
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                author,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withValues(alpha: 0.8),
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],

                          if (author.isNotEmpty && description.isNotEmpty) ...[
                            const SizedBox(width: 8),
                            Container(
                              width: 3,
                              height: 3,
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                          ],

                          if (description.isNotEmpty) ...[
                            Expanded(
                              child: Text(
                                description,
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ],
                      ),

                      const SizedBox(height: 8),

                      // Información adicional compacta
                      Row(
                        children: [
                          if (livello.isNotEmpty) ...[
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: AppColors.primaryBlue.withValues(
                                  alpha: 0.9,
                                ),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.3),
                                  width: 0.5,
                                ),
                              ),
                              child: Text(
                                livello,
                                style: const TextStyle(
                                  fontSize: 9,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],

                          const Spacer(),

                          if (_getViewCount(views) > 0) ...[
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.visibility_outlined,
                                  size: 12,
                                  color: Colors.white.withValues(alpha: 0.8),
                                ),
                                const SizedBox(width: 3),
                                Text(
                                  _formatViews(views),
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ],
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

  String _formatViews(dynamic views) {
    // Convertir a int de forma segura
    int viewCount = 0;
    if (views is int) {
      viewCount = views;
    } else if (views is String) {
      viewCount = int.tryParse(views) ?? 0;
    } else if (views is double) {
      viewCount = views.toInt();
    }

    if (viewCount >= 1000000) {
      return '${(viewCount / 1000000).toStringAsFixed(1)}M';
    } else if (viewCount >= 1000) {
      return '${(viewCount / 1000).toStringAsFixed(1)}K';
    }
    return viewCount.toString();
  }

  int _getViewCount(dynamic views) {
    if (views is int) {
      return views;
    } else if (views is String) {
      return int.tryParse(views) ?? 0;
    } else if (views is double) {
      return views.toInt();
    }
    return 0;
  }
}
