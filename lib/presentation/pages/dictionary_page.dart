import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';

  final List<WordCategory> _categories = [
    WordCategory(
      name: 'Saludos',
      icon: Icons.waving_hand,
      color: AppColors.primaryBlue,
      wordCount: 25,
    ),
    WordCategory(
      name: 'Números',
      icon: Icons.numbers,
      color: AppColors.secondaryGreen,
      wordCount: 30,
    ),
    WordCategory(
      name: 'Colores',
      icon: Icons.palette,
      color: AppColors.secondaryOrange,
      wordCount: 15,
    ),
    WordCategory(
      name: 'Familia',
      icon: Icons.family_restroom,
      color: AppColors.secondaryBlue,
      wordCount: 20,
    ),
    WordCategory(
      name: 'Comida',
      icon: Icons.restaurant,
      color: AppColors.secondaryPurple,
      wordCount: 40,
    ),
    WordCategory(
      name: 'Animales',
      icon: Icons.pets,
      color: AppColors.success,
      wordCount: 35,
    ),
  ];

  final List<DictionaryWord> _words = [
    DictionaryWord(
      id: '1',
      italian: 'Ciao',
      spanish: 'Hola/Adiós',
      english: 'Hello/Goodbye',
      pronunciation: 'chào',
      category: 'Saludos',
      difficulty: 'A1',
      isFavorite: true,
      color: AppColors.primaryBlue,
    ),
    DictionaryWord(
      id: '2',
      italian: 'Buongiorno',
      spanish: 'Buenos días',
      english: 'Good morning',
      pronunciation: 'bwon-yór-no',
      category: 'Saludos',
      difficulty: 'A1',
      isFavorite: false,
      color: AppColors.primaryBlue,
    ),
    DictionaryWord(
      id: '3',
      italian: 'Buonasera',
      spanish: 'Buenas tardes',
      english: 'Good evening',
      pronunciation: 'bwo-na-sé-ra',
      category: 'Saludos',
      difficulty: 'A1',
      isFavorite: false,
      color: AppColors.primaryBlue,
    ),
    DictionaryWord(
      id: '4',
      italian: 'Uno',
      spanish: 'Uno',
      english: 'One',
      pronunciation: 'ú-no',
      category: 'Números',
      difficulty: 'A1',
      isFavorite: true,
      color: AppColors.secondaryGreen,
    ),
    DictionaryWord(
      id: '5',
      italian: 'Due',
      spanish: 'Dos',
      english: 'Two',
      pronunciation: 'dú-e',
      category: 'Números',
      difficulty: 'A1',
      isFavorite: false,
      color: AppColors.secondaryGreen,
    ),
    DictionaryWord(
      id: '6',
      italian: 'Rosso',
      spanish: 'Rojo',
      english: 'Red',
      pronunciation: 'rós-so',
      category: 'Colores',
      difficulty: 'A1',
      isFavorite: false,
      color: AppColors.secondaryOrange,
    ),
    DictionaryWord(
      id: '7',
      italian: 'Verde',
      spanish: 'Verde',
      english: 'Green',
      pronunciation: 'vér-de',
      category: 'Colores',
      difficulty: 'A1',
      isFavorite: true,
      color: AppColors.secondaryOrange,
    ),
    DictionaryWord(
      id: '8',
      italian: 'Mamma',
      spanish: 'Mamá',
      english: 'Mom',
      pronunciation: 'mám-ma',
      category: 'Familia',
      difficulty: 'A1',
      isFavorite: false,
      color: AppColors.secondaryBlue,
    ),
    DictionaryWord(
      id: '9',
      italian: 'Pizza',
      spanish: 'Pizza',
      english: 'Pizza',
      pronunciation: 'pít-tsa',
      category: 'Comida',
      difficulty: 'A1',
      isFavorite: true,
      color: AppColors.secondaryPurple,
    ),
    DictionaryWord(
      id: '10',
      italian: 'Gatto',
      spanish: 'Gato',
      english: 'Cat',
      pronunciation: 'gát-to',
      category: 'Animales',
      difficulty: 'A1',
      isFavorite: false,
      color: AppColors.success,
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diccionario'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Barra de búsqueda
            _buildSearchBar(),

            // Categorías
            _buildCategoryTabs(),

            // Lista de palabras
            Expanded(child: _buildWordsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Buscar palabras en italiano...',
          hintStyle: TextStyle(color: AppColors.textLight),
          prefixIcon: Icon(Icons.search, color: AppColors.textSecondary),
          suffixIcon: _searchQuery.isNotEmpty
              ? IconButton(
                  icon: Icon(Icons.clear, color: AppColors.textSecondary),
                  onPressed: () {
                    _searchController.clear();
                  },
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
        style: const TextStyle(fontSize: 16, color: AppColors.textPrimary),
      ),
    );
  }

  Widget _buildCategoryTabs() {
    return Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategoryIndex == index;

          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategoryIndex = index;
              });
            },
            child: Container(
              width: 100,
              margin: const EdgeInsets.only(right: 12),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isSelected ? category.color : AppColors.backgroundCard,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: isSelected ? category.color : AppColors.borderLight,
                  width: isSelected ? 2 : 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: category.color.withValues(alpha: 0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [
                        BoxShadow(
                          color: AppColors.shadowLight,
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    category.icon,
                    color: isSelected ? AppColors.primaryWhite : category.color,
                    size: 24,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    category.name,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryWhite
                          : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildWordsList() {
    final filteredWords = _words.where((word) {
      final matchesSearch =
          _searchQuery.isEmpty ||
          word.italian.toLowerCase().contains(_searchQuery) ||
          word.spanish.toLowerCase().contains(_searchQuery) ||
          word.english.toLowerCase().contains(_searchQuery);

      final matchesCategory =
          _selectedCategoryIndex == 0 ||
          word.category == _categories[_selectedCategoryIndex].name;

      return matchesSearch && matchesCategory;
    }).toList();

    if (filteredWords.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              _searchQuery.isEmpty
                  ? 'No hay palabras disponibles'
                  : 'No se encontraron resultados',
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
            ),
            if (_searchQuery.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(
                'Intenta con otra palabra o cambia la categoría',
                style: TextStyle(fontSize: 14, color: AppColors.textLight),
                textAlign: TextAlign.center,
              ),
            ],
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: filteredWords.length,
      itemBuilder: (context, index) {
        final word = filteredWords[index];
        return _buildWordCard(word);
      },
    );
  }

  Widget _buildWordCard(DictionaryWord word) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _showWordDetails(word),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    // Palabra en italiano
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            word.italian,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: AppColors.textPrimary,
                            ),
                          ),

                          const SizedBox(height: 4),

                          Text(
                            '[${word.pronunciation}]',
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Botón de favorito
                    IconButton(
                      onPressed: () => _toggleFavorite(word),
                      icon: Icon(
                        word.isFavorite
                            ? Icons.favorite
                            : Icons.favorite_border,
                        color: word.isFavorite
                            ? AppColors.error
                            : AppColors.textLight,
                        size: 28,
                      ),
                    ),

                    // Botón de audio
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: word.color,
                        borderRadius: BorderRadius.circular(24),
                        boxShadow: [
                          BoxShadow(
                            color: word.color.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Icon(
                        Icons.volume_up,
                        color: AppColors.primaryWhite,
                        size: 24,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Traducciones
                Row(
                  children: [
                    Expanded(
                      child: _buildTranslation(
                        label: 'Español',
                        text: word.spanish,
                        color: AppColors.primaryBlue,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _buildTranslation(
                        label: 'English',
                        text: word.english,
                        color: AppColors.secondaryGreen,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),

                // Información adicional
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: word.color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        word.category,
                        style: TextStyle(
                          color: word.color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: _getDifficultyColor(
                          word.difficulty,
                        ).withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        word.difficulty,
                        style: TextStyle(
                          color: _getDifficultyColor(word.difficulty),
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTranslation({
    required String label,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            text,
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty) {
      case 'A1':
        return AppColors.success;
      case 'A2':
        return AppColors.warning;
      case 'B1':
      case 'B2':
        return AppColors.error;
      default:
        return AppColors.textSecondary;
    }
  }

  void _toggleFavorite(DictionaryWord word) {
    setState(() {
      // En una implementación real, esto se guardaría en la base de datos
      word.isFavorite = !word.isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          word.isFavorite
              ? '${word.italian} agregado a favoritos'
              : '${word.italian} removido de favoritos',
        ),
        backgroundColor: word.color,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showWordDetails(DictionaryWord word) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _buildWordDetailsSheet(word),
    );
  }

  Widget _buildWordDetailsSheet(DictionaryWord word) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Contenido
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Palabra principal
                  Center(
                    child: Column(
                      children: [
                        Text(
                          word.italian,
                          style: const TextStyle(
                            fontSize: 36,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '[${word.pronunciation}]',
                          style: TextStyle(
                            fontSize: 18,
                            color: AppColors.textSecondary,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Traducciones detalladas
                  _buildDetailedTranslation(
                    label: 'Español',
                    text: word.spanish,
                    color: AppColors.primaryBlue,
                  ),

                  const SizedBox(height: 16),

                  _buildDetailedTranslation(
                    label: 'English',
                    text: word.english,
                    color: AppColors.secondaryGreen,
                  ),

                  const SizedBox(height: 32),

                  // Botones de acción
                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _playAudio(word),
                          icon: const Icon(Icons.volume_up),
                          label: const Text('Escuchar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: word.color,
                            foregroundColor: AppColors.primaryWhite,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: ElevatedButton.icon(
                          onPressed: () => _practiceWord(word),
                          icon: const Icon(Icons.school),
                          label: const Text('Practicar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.backgroundSecondary,
                            foregroundColor: AppColors.textPrimary,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailedTranslation({
    required String label,
    required String text,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 18, color: AppColors.textPrimary),
          ),
        ],
      ),
    );
  }

  void _playAudio(DictionaryWord word) {
    // TODO: Implementar reproducción de audio
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo audio: ${word.italian}'),
        backgroundColor: word.color,
      ),
    );
  }

  void _practiceWord(DictionaryWord word) {
    // TODO: Implementar práctica de la palabra
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Iniciando práctica: ${word.italian}'),
        backgroundColor: word.color,
      ),
    );
  }
}

class WordCategory {
  final String name;
  final IconData icon;
  final Color color;
  final int wordCount;

  WordCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.wordCount,
  });
}

class DictionaryWord {
  final String id;
  final String italian;
  final String spanish;
  final String english;
  final String pronunciation;
  final String category;
  final String difficulty;
  bool isFavorite;
  final Color color;

  DictionaryWord({
    required this.id,
    required this.italian,
    required this.spanish,
    required this.english,
    required this.pronunciation,
    required this.category,
    required this.difficulty,
    required this.isFavorite,
    required this.color,
  });
}
