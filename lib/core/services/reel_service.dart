import 'package:dio/dio.dart';
import '../../domain/entities/reel.dart';

/// Servicio para obtener y gestionar reels educativos desde la API
class ReelService {
  static const String _baseUrl = 'https://dantexxi-api.onrender.com';
  static const String _reelsEndpoint = '/reels';

  /// Obtener todos los reels disponibles
  static Future<List<Reel>> getReels() async {
    try {
      print('🎬 ReelService.getReels() - Obteniendo reels desde la API...');

      final dio = Dio();
      final response = await dio.get('$_baseUrl$_reelsEndpoint');

      print(
        '✅ ReelService.getReels() - Respuesta exitosa: ${response.statusCode}',
      );

      if (response.statusCode == 200) {
        final List<dynamic> reelsJson = response.data;
        final reels = reelsJson.map((json) => Reel.fromJson(json)).toList();

        print('🎬 ReelService.getReels() - ${reels.length} reels obtenidos');

        // Filtrar solo reels visibles
        final visibleReels = reels.where((reel) => reel.visible).toList();
        print(
          '👁️ ReelService.getReels() - ${visibleReels.length} reels visibles',
        );

        return visibleReels;
      } else {
        throw Exception('Error al obtener reels: ${response.statusCode}');
      }
    } catch (e) {
      print('❌ ReelService.getReels() - Error: $e');
      rethrow;
    }
  }

  /// Obtener un reel específico por ID
  static Future<Reel?> getReelById(int id) async {
    try {
      print('🎬 ReelService.getReelById() - Obteniendo reel ID: $id');

      final reels = await getReels();
      final reel = reels.firstWhere((r) => r.id == id);

      print('✅ ReelService.getReelById() - Reel encontrado: ${reel.name}');
      return reel;
    } catch (e) {
      print('❌ ReelService.getReelById() - Error: $e');
      return null;
    }
  }

  /// Obtener reels por nivel CEFR
  static Future<List<Reel>> getReelsByLevel(String level) async {
    try {
      print('🎬 ReelService.getReelsByLevel() - Filtrando por nivel: $level');

      final reels = await getReels();
      final filteredReels = reels.where((r) => r.livello == level).toList();

      print(
        '✅ ReelService.getReelsByLevel() - ${filteredReels.length} reels para nivel $level',
      );
      return filteredReels;
    } catch (e) {
      print('❌ ReelService.getReelsByLevel() - Error: $e');
      return [];
    }
  }

  /// Obtener reels por categoría
  static Future<List<Reel>> getReelsByCategory(String category) async {
    try {
      print(
        '🎬 ReelService.getReelsByCategory() - Filtrando por categoría: $category',
      );

      final reels = await getReels();
      final filteredReels = reels.where((r) => r.category == category).toList();

      print(
        '✅ ReelService.getReelsByCategory() - ${filteredReels.length} reels para categoría $category',
      );
      return filteredReels;
    } catch (e) {
      print('❌ ReelService.getReelsByCategory() - Error: $e');
      return [];
    }
  }

  /// Obtener reels destacados (más vistos)
  static Future<List<Reel>> getFeaturedReels({int limit = 5}) async {
    try {
      print(
        '🎬 ReelService.getFeaturedReels() - Obteniendo $limit reels destacados',
      );

      final reels = await getReels();

      // Ordenar por número de vistas y tomar los primeros
      final featuredReels = reels.where((r) => r.visible).toList()
        ..sort((a, b) => b.views.compareTo(a.views));

      final result = featuredReels.take(limit).toList();

      print(
        '✅ ReelService.getFeaturedReels() - ${result.length} reels destacados obtenidos',
      );
      return result;
    } catch (e) {
      print('❌ ReelService.getFeaturedReels() - Error: $e');
      return [];
    }
  }

  /// Extraer URL de YouTube de la URL completa
  static String extractYouTubeId(String url) {
    try {
      // Extraer ID de YouTube de diferentes formatos de URL
      final uri = Uri.parse(url);

      if (uri.host.contains('youtube.com') || uri.host.contains('youtu.be')) {
        if (uri.host.contains('youtu.be')) {
          return uri.pathSegments.first;
        } else {
          return uri.queryParameters['v'] ?? '';
        }
      }

      return '';
    } catch (e) {
      print('❌ ReelService.extractYouTubeId() - Error: $e');
      return '';
    }
  }

  /// Obtener URL de thumbnail de YouTube
  static String getYouTubeThumbnail(String videoId) {
    if (videoId.isEmpty) return '';

    // Diferentes calidades de thumbnail disponibles
    return 'https://img.youtube.com/vi/$videoId/maxresdefault.jpg';
  }
}
