import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import 'verb_conjugation_page.dart';
import 'noun_details_page.dart';

class DictionaryPage extends StatefulWidget {
  const DictionaryPage({super.key});

  @override
  State<DictionaryPage> createState() => _DictionaryPageState();
}

class _DictionaryPageState extends State<DictionaryPage> {
  final TextEditingController _searchController = TextEditingController();
  int _selectedCategoryIndex = 0;
  String _searchQuery = '';
  List<DictionaryWord> _allWords = [];
  List<DictionaryWord> _filteredWords = [];
  bool _isLoading = true;

  final List<WordCategory> _categories = [
    WordCategory(
      name: 'Todos',
      icon: Icons.language,
      color: AppColors.primaryBlue,
      wordCount: 0,
      jsonFile: '', // No necesita archivo específico
    ),
    WordCategory(
      name: 'Verbos',
      icon: Icons.run_circle,
      color: AppColors.secondaryGreen,
      wordCount: 0,
      jsonFile: 'assets/dictionary/verbs_conjugation.json',
    ),
    WordCategory(
      name: 'Adjetivos',
      icon: Icons.color_lens,
      color: AppColors.secondaryOrange,
      wordCount: 0,
      jsonFile: 'assets/dictionary/adjectives.json',
    ),
    WordCategory(
      name: 'Sustantivos',
      icon: Icons.category,
      color: AppColors.secondaryBlue,
      wordCount: 0,
      jsonFile: 'assets/dictionary/nouns_detailed.json',
    ),
    WordCategory(
      name: 'Conjunciones',
      icon: Icons.link,
      color: AppColors.secondaryPurple,
      wordCount: 0,
      jsonFile: 'assets/dictionary/conjunctions.json',
    ),
    WordCategory(
      name: 'Interjecciones',
      icon: Icons.sentiment_satisfied,
      color: AppColors.success,
      wordCount: 0,
      jsonFile: 'assets/dictionary/interjections.json',
    ),
    WordCategory(
      name: 'Adverbios',
      icon: Icons.speed,
      color: AppColors.warning,
      wordCount: 0,
      jsonFile: 'assets/dictionary/adverbs.json',
    ),
    WordCategory(
      name: 'Preposiciones',
      icon: Icons.arrow_forward,
      color: AppColors.error,
      wordCount: 0,
      jsonFile: 'assets/dictionary/prepositions.json',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
    _loadAllDictionaryData();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadAllDictionaryData() async {
    try {
      List<DictionaryWord> allWords = [];

      for (var category in _categories) {
        // Saltar la categoría "Todos" ya que no tiene archivo específico
        if (category.name == 'Todos') continue;

        try {
          final String jsonString = await rootBundle.loadString(
            category.jsonFile,
          );
          final Map<String, dynamic> jsonData = jsonDecode(jsonString);

          // Determinar qué array usar basado en el nombre de la categoría
          String arrayKey = 'words'; // default
          switch (category.name) {
            case 'Verbos':
              arrayKey = 'verbs';
              break;
            case 'Sustantivos':
              arrayKey = 'nouns';
              break;
            case 'Adjetivos':
              arrayKey = 'adjectives';
              break;
            case 'Conjunciones':
              arrayKey = 'conjunctions';
              break;
            case 'Interjecciones':
              arrayKey = 'interjections';
              break;
            case 'Adverbios':
              arrayKey = 'adverbs';
              break;
            case 'Preposiciones':
              arrayKey = 'prepositions';
              break;
          }

          final List<dynamic> wordsList = jsonData[arrayKey] ?? [];
          for (int i = 0; i < wordsList.length; i++) {
            var wordData = Map<String, dynamic>.from(wordsList[i]);
            // Agregar la categoría y un ID único al wordData
            wordData['category'] = category.name;
            wordData['id'] = '${category.name.toLowerCase()}_${i + 1}';
            allWords.add(DictionaryWord.fromJson(wordData, category.color));
          }
        } catch (e) {
          debugPrint('Error loading ${category.jsonFile}: $e');
        }
      }

      setState(() {
        _allWords = allWords;
        _filteredWords = allWords;
        _isLoading = false;
        _updateCategoryCounts();
      });
    } catch (e) {
      debugPrint('Error loading dictionary data: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _updateCategoryCounts() {
    for (int i = 0; i < _categories.length; i++) {
      final categoryName = _categories[i].name;
      int count;

      if (categoryName == 'Todos') {
        // Para "Todos", contar todas las palabras
        count = _allWords.length;
      } else {
        // Para otras categorías, contar solo las palabras de esa categoría
        count = _allWords.where((word) => word.category == categoryName).length;
      }

      _categories[i] = _categories[i].copyWith(wordCount: count);
    }
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
      _filterWords();
    });
  }

  void _filterWords() {
    if (_searchQuery.isEmpty && _selectedCategoryIndex == 0) {
      // Si no hay búsqueda y está seleccionada "Todos", mostrar todas las palabras
      _filteredWords = _allWords;
    } else {
      _filteredWords = _allWords.where((word) {
        final matchesSearch =
            _searchQuery.isEmpty ||
            word.word.toLowerCase().contains(_searchQuery) ||
            word.spanish.toLowerCase().contains(_searchQuery) ||
            word.english.toLowerCase().contains(_searchQuery);

        final matchesCategory =
            _selectedCategoryIndex == 0 || // "Todos" siempre coincide
            word.category == _categories[_selectedCategoryIndex].name;

        return matchesSearch && matchesCategory;
      }).toList();
    }
  }

  void _onCategorySelected(int index) {
    setState(() {
      _selectedCategoryIndex = index;
      _filterWords();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Diccionario Gramatical'),
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
      height: 125,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = _selectedCategoryIndex == index;

          return GestureDetector(
            onTap: () => _onCategorySelected(index),
            child: Container(
              width: category.name == 'Todos' ? 80 : 100,
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
                      fontSize: category.name == 'Todos' ? 11 : 12,
                      fontWeight: FontWeight.w600,
                      color: isSelected
                          ? AppColors.primaryWhite
                          : AppColors.textPrimary,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    '${category.wordCount}',
                    style: TextStyle(
                      fontSize: 10,
                      color: isSelected
                          ? AppColors.primaryWhite.withValues(alpha: 0.8)
                          : AppColors.textSecondary,
                    ),
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
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_filteredWords.isEmpty) {
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
      itemCount: _filteredWords.length,
      itemBuilder: (context, index) {
        final word = _filteredWords[index];
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
                            word.word,
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
                        text: word.translation['spanish'] is String
                            ? word.translation['spanish']
                            : word.translation['spanish']?['word'] ?? '',
                        color: AppColors.primaryBlue,
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: _buildTranslation(
                        label: 'English',
                        text: word.translation['english'] is String
                            ? word.translation['english']
                            : word.translation['english']?['word'] ?? '',
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

                    if (word.gender.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundSecondary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          word.gender,
                          style: const TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],

                    if (word.abbreviation.isNotEmpty) ...[
                      const SizedBox(width: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.success.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          word.abbreviation,
                          style: TextStyle(
                            color: AppColors.success,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
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
      word.isFavorite = !word.isFavorite;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          word.isFavorite
              ? '${word.word} agregado a favoritos'
              : '${word.word} removido de favoritos',
        ),
        backgroundColor: word.color,
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _showWordDetails(DictionaryWord word) {
    // Siempre mostrar el modal primero
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
                          word.word,
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

                  // Información de la palabra
                  if (word.meaning.isNotEmpty)
                    _buildDetailedTranslation(
                      label: 'Significado',
                      text: word.meaning,
                      color: AppColors.primaryBlue,
                    ),

                  if (word.meaning.isNotEmpty) const SizedBox(height: 16),

                 
                  // Ejemplos
                  if (word.examples.isNotEmpty)
                    _buildDetailedTranslation(
                      label: 'Ejemplos',
                      text: word.examples.join('\n'),
                      color: AppColors.success,
                    ),

                  const SizedBox(height: 32),

                  // Botones de acción
                  Column(
                    children: [
                      // Botones específicos según categoría
                      if (word.category == 'Verbos') ...[
                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () => _showVerbConjugation(word),
                                icon: const Icon(Icons.table_chart),
                                label: const Text('Ver Tabla de Conjugación'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.success,
                                  foregroundColor: AppColors.primaryWhite,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],

                      

                      // Botones generales
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
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
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
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }

  void _playAudio(DictionaryWord word) {
    // TODO: Implementar reproducción de audio
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Reproduciendo audio: ${word.word}'),
        backgroundColor: word.color,
      ),
    );
  }

  void _practiceWord(DictionaryWord word) {
    // TODO: Implementar práctica de la palabra
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Iniciando práctica: ${word.word}'),
        backgroundColor: word.color,
      ),
    );
  }

  void _showVerbConjugation(DictionaryWord word) {
    Navigator.pop(context); // Cerrar el modal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => VerbConjugationPage(
          verbInfinito: word.word,
          jsonPath: 'assets/dictionary/verbs_conjugation.json',
        ),
      ),
    );
  }

  void _showNounDetails(DictionaryWord word) {
    Navigator.pop(context); // Cerrar el modal
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NounDetailsPage(
          nounWord: word.word,
          jsonPath: 'assets/dictionary/nouns_detailed.json',
        ),
      ),
    );
  }
}

class WordCategory {
  final String name;
  final IconData icon;
  final Color color;
  final int wordCount;
  final String jsonFile;

  WordCategory({
    required this.name,
    required this.icon,
    required this.color,
    required this.wordCount,
    required this.jsonFile,
  });

  WordCategory copyWith({
    String? name,
    IconData? icon,
    Color? color,
    int? wordCount,
    String? jsonFile,
  }) {
    return WordCategory(
      name: name ?? this.name,
      icon: icon ?? this.icon,
      color: color ?? this.color,
      wordCount: wordCount ?? this.wordCount,
      jsonFile: jsonFile ?? this.jsonFile,
    );
  }
}

class DictionaryWord {
  final String id;
  final String word;
  final String meaning;
  final String abbreviation;
  final String pronunciation;
  final String category;
  final String gender;
  final String lingua;
  final Map<String, dynamic> translation;
  final List<String> examples;
  bool isFavorite;
  final Color color;
  final Map<String, dynamic>? additionalData;

  DictionaryWord({
    required this.id,
    required this.word,
    required this.meaning,
    required this.abbreviation,
    required this.pronunciation,
    required this.category,
    required this.gender,
    required this.lingua,
    required this.translation,
    required this.examples,
    required this.isFavorite,
    required this.color,
    this.additionalData,
  });

  factory DictionaryWord.fromJson(Map<String, dynamic> json, Color color) {
    final String category = json['category'] ?? '';

    // Determinar la palabra visible
    String resolvedWord = json['word'] ?? '';
    if (category == 'Verbos' && (resolvedWord.isEmpty)) {
      resolvedWord = json['infinito'] ?? '';
    }

    // Significado / definición
    String resolvedMeaning = json['meaning'] ?? '';
    if (resolvedMeaning.isEmpty && category == 'Verbos') {
      resolvedMeaning = json['definizione'] ?? '';
    }

    // Abreviatura / tipo (v., agg., etc.)
    String resolvedAbbreviation = json['abbreviation'] ?? '';
    if (resolvedAbbreviation.isEmpty && category == 'Verbos') {
      resolvedAbbreviation = json['tipo'] ?? '';
    }

    // Traducciones: para verbos mapear 'traduzione' -> spanish si no hay estructura 'translation'
    Map<String, dynamic> resolvedTranslation = {};
    if (json['translation'] is Map<String, dynamic>) {
      resolvedTranslation = Map<String, dynamic>.from(json['translation']);
    } else if (category == 'Verbos' && json['traduzione'] != null) {
      resolvedTranslation = {'spanish': json['traduzione']};
    }

    return DictionaryWord(
      id: json['id'] ?? '',
      word: resolvedWord,
      meaning: resolvedMeaning,
      abbreviation: resolvedAbbreviation,
      pronunciation: json['pronunciation'] ?? '',
      category: category,
      gender: json['gender'] ?? '',
      lingua: json['lingua'] ?? '',
      translation: resolvedTranslation,
      examples: List<String>.from(json['examples'] ?? []),
      isFavorite: json['isFavorite'] ?? false,
      color: color,
      additionalData: json,
    );
  }

  // Getters para compatibilidad con el código existente
  String get italian => word;
  String get spanish =>
      translation['spanish']?['word'] ?? translation['spanish'] ?? '';
  String get english =>
      translation['english']?['word'] ?? translation['english'] ?? '';
  String get difficulty => 'A1';
}
