import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';
import '../../domain/entities/reel.dart';
import '../widgets/video_card.dart';
import '../../core/services/reel_service.dart';
import 'video_player_page.dart';

class ReelsPage extends StatefulWidget {
  const ReelsPage({super.key});

  @override
  State<ReelsPage> createState() => _ReelsPageState();
}

class _ReelsPageState extends State<ReelsPage> {
  List<Reel> _reels = [];
  bool _isLoading = true;
  bool _isRefreshing = false;
  String _selectedCategory = 'Todas';
  String _selectedLevel = 'Todos';

  final List<String> _categories = [
    'Todas',
    'Educación',
    'Conversación',
    'Gramática',
    'Vocabulario',
    'Cultura',
    'Viajes',
    'Negocios',
  ];

  final List<String> _levels = ['Todos', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  @override
  void initState() {
    super.initState();
    _loadReels();
  }

  Future<void> _loadReels() async {
    setState(() => _isLoading = true);

    try {
      // Obtener reels desde la API real
      final reels = await ReelService.getReels();

      setState(() {
        _reels = reels;
        _isLoading = false;
      });
    } catch (e) {
      print('❌ Error al cargar reels: $e');
      // Fallback a datos de muestra si hay error
      setState(() {
        _reels = _generateSampleReels();
        _isLoading = false;
      });

      // Mostrar mensaje de error
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar reels: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  Future<void> _refreshReels() async {
    setState(() => _isRefreshing = true);

    try {
      // Obtener reels desde la API real
      final reels = await ReelService.getReels();

      setState(() {
        _reels = reels;
        _isRefreshing = false;
      });

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Reels actualizados'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      }
    } catch (e) {
      print('❌ Error al actualizar reels: $e');
      setState(() => _isRefreshing = false);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al actualizar: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  List<Reel> _generateSampleReels() {
    return [
      Reel(
        id: 1,
        author: 'Prof. Marco Rossi',
        category: 'Educación',
        chiave: 'Ciao, come stai?',
        chiaveTranslation: 'Hola, ¿cómo estás?',
        chiaveTranslationEN: 'Hello, how are you?',
        chiaveTranslationPR: 'Olá, como você está?',
        description:
            'Aprende los saludos básicos en italiano con ejemplos prácticos.',
        image: 'assets/images/saludos.jpg',
        lingua: 'italiano',
        livello: 'A1',
        name: 'Saludos Básicos',
        subtitles: [],
        url: 'https://www.youtube.com/watch?v=example1',
        views: 1250,
        visible: true,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      Reel(
        id: 2,
        author: 'Prof. Elena Bianchi',
        category: 'Conversación',
        chiave: 'Mi piace la pizza',
        chiaveTranslation: 'Me gusta la pizza',
        chiaveTranslationEN: 'I like pizza',
        chiaveTranslationPR: 'Eu gosto de pizza',
        description:
            'Expresiones útiles para hablar sobre comida y preferencias.',
        image: 'assets/images/comida.jpg',
        lingua: 'italiano',
        livello: 'A2',
        name: 'Hablando de Comida',
        subtitles: [],
        url: 'https://www.youtube.com/watch?v=example2',
        views: 890,
        visible: true,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
      ),
      Reel(
        id: 3,
        author: 'Prof. Antonio Verdi',
        category: 'Gramática',
        chiave: 'Io sono, tu sei, lui è',
        chiaveTranslation: 'Yo soy, tú eres, él es',
        chiaveTranslationEN: 'I am, you are, he is',
        chiaveTranslationPR: 'Eu sou, você é, ele é',
        description: 'Conjugación del verbo essere en presente.',
        image: 'assets/images/gramatica.jpg',
        lingua: 'italiano',
        livello: 'A1',
        name: 'Verbo Essere',
        subtitles: [],
        url: 'https://www.youtube.com/watch?v=example3',
        views: 2100,
        visible: true,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
      ),
    ];
  }

  List<Reel> get _filteredReels {
    return _reels.where((reel) {
      final categoryMatch =
          _selectedCategory == 'Todas' || reel.category == _selectedCategory;
      final levelMatch =
          _selectedLevel == 'Todos' || reel.livello == _selectedLevel;
      return categoryMatch && levelMatch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCard,
      appBar: AppBar(
        title: Text(
          AppTexts.reels,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          if (_isRefreshing)
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppColors.primaryBlue,
                ),
              ),
            ),
        ],
      ),
      body: Column(
        children: [
          // Indicador de fuente de datos
          if (_reels.isNotEmpty &&
              _reels.first.id > 100) // IDs altos indican datos de la API
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              color: AppColors.primaryBlue.withOpacity(0.1),
              child: Row(
                children: [
                  Icon(
                    Icons.cloud_done,
                    color: AppColors.primaryBlue,
                    size: 16,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Conectado a la API de Dantexxi',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.primaryBlue,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          // Filtros
          Container(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Filtro de categorías
                Row(
                  children: [
                    Text(
                      'Categoría:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _categories.map((category) {
                            final isSelected = _selectedCategory == category;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FilterChip(
                                label: Text(category),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedCategory = category;
                                  });
                                },
                                backgroundColor: AppColors.backgroundCard,
                                selectedColor: AppColors.primaryBlue
                                    .withOpacity(0.2),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? AppColors.primaryBlue
                                      : AppColors.textSecondary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                // Filtro de niveles
                Row(
                  children: [
                    Text(
                      'Nivel:',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _levels.map((level) {
                            final isSelected = _selectedLevel == level;
                            return Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: FilterChip(
                                label: Text(level),
                                selected: isSelected,
                                onSelected: (selected) {
                                  setState(() {
                                    _selectedLevel = level;
                                  });
                                },
                                backgroundColor: AppColors.backgroundCard,
                                selectedColor: AppColors.primaryBlue
                                    .withOpacity(0.2),
                                labelStyle: TextStyle(
                                  color: isSelected
                                      ? AppColors.primaryBlue
                                      : AppColors.textSecondary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Lista de videos
          Expanded(
            child: _isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: AppColors.primaryBlue,
                    ),
                  )
                : _filteredReels.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.video_library_outlined,
                          size: 64,
                          color: AppColors.textSecondary,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          'No se encontraron videos',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Intenta cambiar los filtros',
                          style: TextStyle(
                            fontSize: 14,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: _refreshReels,
                          icon: const Icon(Icons.refresh),
                          label: const Text('Recargar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlue,
                            foregroundColor: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: _refreshReels,
                    color: AppColors.primaryBlue,
                    child: ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredReels.length,
                      itemBuilder: (context, index) {
                        return VideoCard(
                          reel: _filteredReels[index],
                          onTap: () => _onVideoTap(_filteredReels[index]),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  void _onVideoTap(Reel reel) {
    // Navegar al reproductor de video
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => VideoPlayerPage(reel: reel)),
    );
  }
}
