import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';
import 'audiobook_details_page.dart';

class AudiobooksPage extends StatefulWidget {
  const AudiobooksPage({super.key});

  @override
  State<AudiobooksPage> createState() => _AudiobooksPageState();
}

class _AudiobooksPageState extends State<AudiobooksPage> {
  List<Map<String, dynamic>> _audiobooks = [];
  bool _isLoading = true;
  String? _errorMessage;
  String _searchQuery = '';
  String _selectedCategory = 'Todas';
  String _selectedLevel = 'Todos';

  final List<String> _categories = [
    'Todas',
    'Letteratura Classica',
    'Letteratura per Bambini',
    'Filosofia Politica',
    'Didattica',
    'Folclore',
  ];

  final List<String> _levels = ['Todos', 'A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  @override
  void initState() {
    super.initState();
    _loadAudiobooks();
  }

  Future<void> _loadAudiobooks() async {
    try {
      final String jsonString = await rootBundle.loadString(
        'assets/data/italian_audiobooks.json',
      );
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      setState(() {
        _audiobooks = List<Map<String, dynamic>>.from(
          jsonData['italian_audiobooks'],
        );
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Error al cargar los audiolibros: $e';
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredAudiobooks {
    return _audiobooks.where((audiobook) {
      final matchesSearch =
          audiobook['name'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          ) ||
          audiobook['author'].toString().toLowerCase().contains(
            _searchQuery.toLowerCase(),
          );

      final matchesCategory =
          _selectedCategory == 'Todas' ||
          audiobook['category'] == _selectedCategory;
      final matchesLevel =
          _selectedLevel == 'Todos' || audiobook['level'] == _selectedLevel;

      return matchesSearch && matchesCategory && matchesLevel;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              AppColors.primaryBlue.withValues(alpha: 0.1),
              Colors.white,
            ],
          ),
        ),
        child: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _errorMessage != null
            ? Center(child: Text(_errorMessage!))
            : CustomScrollView(
                slivers: [
                  _buildAppBar(),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        _buildSearchAndFilters(),
                        _buildCategoriesSection(),
                        _buildFeaturedSection(),
                        _buildNewReleasesSection(),
                        const SizedBox(
                          height: 100,
                        ), // Espacio para bottom navigation
                      ],
                    ),
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 120,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.primaryBlue,
      flexibleSpace: FlexibleSpaceBar(
        title: const Text(
          'Audītōria',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppColors.primaryBlue,
                AppColors.primaryBlue.withValues(alpha: 0.8),
              ],
            ),
          ),
          child: const Center(
            child: Icon(Icons.headphones, size: 60, color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _buildSearchAndFilters() {
    return Container(
      margin: const EdgeInsets.all(20),
      child: Column(
        children: [
          // Barra de búsqueda mejorada
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(25),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: TextField(
              onChanged: (value) => setState(() => _searchQuery = value),
              decoration: InputDecoration(
                hintText: '🔍 Buscar audiolibros...',
                hintStyle: TextStyle(
                  color: AppColors.textSecondary.withValues(alpha: 0.7),
                  fontSize: 16,
                ),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.primaryBlue,
                ),
                border: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),

          // Filtros mejorados
          Row(
            children: [
              Expanded(
                child: _buildFilterDropdown(
                  value: _selectedCategory,
                  items: _categories,
                  onChanged: (value) =>
                      setState(() => _selectedCategory = value!),
                  label: 'Categoría',
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _buildFilterDropdown(
                  value: _selectedLevel,
                  items: _levels,
                  onChanged: (value) => setState(() => _selectedLevel = value!),
                  label: 'Nivel',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCategoriesSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Categoriae',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categories.map((category) {
                final isSelected = _selectedCategory == category;
                return Container(
                  margin: const EdgeInsets.only(right: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(25),
                      onTap: () => setState(() => _selectedCategory = category),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppColors.primaryBlue
                              : Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Text(
                          category,
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.textPrimary,
                            fontWeight: FontWeight.w600,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedSection() {
    final featuredAudiobooks = _filteredAudiobooks.take(5).toList();

    if (featuredAudiobooks.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tibi commendata',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: CarouselSlider.builder(
              itemCount: featuredAudiobooks.length,
              itemBuilder: (context, index, realIndex) {
                return _buildFeaturedCard(featuredAudiobooks[index]);
              },
              options: CarouselOptions(
                height: 200,
                enlargeCenterPage: true,
                autoPlay: true,
                autoPlayInterval: const Duration(seconds: 4),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                viewportFraction: 0.8,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedCard(Map<String, dynamic> audiobook) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Imagen de fondo
            Image.network(
              audiobook['image'] ?? '',
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
            // Gradiente oscuro
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.8),
                  ],
                ),
              ),
            ),
            // Contenido
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
                      color: _getLevelColor(
                        audiobook['level'],
                      ).withValues(alpha: 0.9),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      audiobook['level'] ?? '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    audiobook['name'] ?? '',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    audiobook['author'] ?? '',
                    style: TextStyle(
                      color: Colors.white.withValues(alpha: 0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            // Botón de play
            Positioned(
              top: 20,
              right: 20,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.play_arrow,
                    color: Colors.white,
                    size: 24,
                  ),
                  onPressed: () => _navigateToAudiobookDetails(audiobook),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewReleasesSection() {
    final newReleases = _filteredAudiobooks.take(10).toList();

    if (newReleases.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nova Editiones',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 150,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: newReleases.length,
              itemBuilder: (context, index) {
                return _buildNewReleaseCard(newReleases[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNewReleaseCard(Map<String, dynamic> audiobook) {
    return Container(
      width: 280,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => _navigateToAudiobookDetails(audiobook),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Imagen
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image:
                        audiobook['image'] != null &&
                            audiobook['image'].isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(audiobook['image']),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      audiobook['image'] == null || audiobook['image'].isEmpty
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.borderLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.book,
                            size: 40,
                            color: AppColors.textSecondary,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),

                // Información
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audiobook['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        audiobook['author'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
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
                              color: _getLevelColor(
                                audiobook['level'],
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              audiobook['level'] ?? '',
                              style: TextStyle(
                                color: _getLevelColor(audiobook['level']),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                            audiobook['duration'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
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
                  size: 32,
                  color: AppColors.primaryBlue,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterDropdown({
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
    required String label,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      items: items
          .map((item) => DropdownMenuItem(value: item, child: Text(item)))
          .toList(),
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.borderLight),
        ),
        filled: true,
        fillColor: AppColors.backgroundCard,
      ),
    );
  }

  Widget _buildAudiobooksList() {
    final filteredAudiobooks = _filteredAudiobooks;

    if (filteredAudiobooks.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.search_off, size: 64, color: AppColors.textSecondary),
            const SizedBox(height: 16),
            Text(
              'No se encontraron audiolibros',
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredAudiobooks.length,
      itemBuilder: (context, index) {
        final audiobook = filteredAudiobooks[index];
        return _buildAudiobookCard(audiobook);
      },
    );
  }

  Widget _buildAudiobookCard(Map<String, dynamic> audiobook) {
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
          onTap: () => _navigateToAudiobookDetails(audiobook),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                // Imagen del audiolibro
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    image: DecorationImage(
                      image: NetworkImage(audiobook['image'] ?? ''),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: audiobook['image'] == null
                      ? Container(
                          decoration: BoxDecoration(
                            color: AppColors.borderLight,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            Icons.book,
                            size: 40,
                            color: AppColors.textSecondary,
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),

                // Información del audiolibro
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        audiobook['name'] ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        audiobook['author'] ?? '',
                        style: TextStyle(
                          fontSize: 14,
                          color: AppColors.primaryBlue,
                          fontWeight: FontWeight.w600,
                        ),
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
                              color: _getLevelColor(
                                audiobook['level'],
                              ).withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              audiobook['level'] ?? '',
                              style: TextStyle(
                                color: _getLevelColor(audiobook['level']),
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
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
                            audiobook['duration'] ?? '',
                            style: TextStyle(
                              fontSize: 12,
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
                  size: 32,
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

  void _navigateToAudiobookDetails(Map<String, dynamic> audiobook) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => AudiobookDetailsPage(audiobook: audiobook),
      ),
    );
  }
}
