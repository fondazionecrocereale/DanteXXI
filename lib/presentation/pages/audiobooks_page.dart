import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../../core/constants/app_colors.dart';
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
  String _selectedCategory = 'Tutte';

  final List<String> _categories = [
    'Tutte',
    'Letteratura Classica',
    'Letteratura per Bambini',
    'Filosofia Politica',
    'Didattica',
    'Folclore',
  ];

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
        _errorMessage = 'Errore nel caricamento degli audiolibri: $e';
        _isLoading = false;
      });
    }
  }

  List<Map<String, dynamic>> get _filteredAudiobooks {
    return _audiobooks.where((audiobook) {
      final matchesCategory =
          _selectedCategory == 'Tutte' ||
          audiobook['category'] == _selectedCategory;

      return matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Audiolibri',
          style: TextStyle(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _errorMessage != null
          ? Center(child: Text(_errorMessage!))
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildCategoriesSection(),
                  _buildFeaturedSection(),
                  _buildNewReleasesSection(),
                  const SizedBox(height: 32),

                  // Lista completa de audiobooks
                  _buildAllAudiobooksSection(),

                  const SizedBox(height: 100), // Espacio para bottom navigation
                ],
              ),
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
            'Categorie',
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
            'Raccomandati',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: featuredAudiobooks.map((audiobook) {
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: _buildFeaturedAudiobookCard(
                    title: audiobook['name'] ?? '',
                    author: audiobook['author'] ?? '',
                    description:
                        audiobook['description'] ?? 'Audiolibro in italiano',
                    level: audiobook['level'] ?? 'A1',
                    duration: audiobook['duration'] ?? '00:00',
                    color: _getLevelColor(audiobook['level']),
                    image: audiobook['image'] ?? '',
                    audiobookData: audiobook,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedAudiobookCard({
    required String title,
    required String author,
    required String description,
    required String level,
    required String duration,
    required Color color,
    required String image,
    Map<String, dynamic>? audiobookData,
  }) {
    return Container(
      width: 200,
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
          onTap: () => _navigateToAudiobookDetails(
            audiobookData ??
                {
                  'name': title,
                  'author': author,
                  'description': description,
                  'level': level,
                  'duration': duration,
                  'image': image,
                },
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.headphones, color: color, size: 24),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
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
                  author,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
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

  Widget _buildNewReleasesSection() {
    final newReleases = _filteredAudiobooks.take(10).toList();

    if (newReleases.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Nuove Uscite',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: newReleases.map((audiobook) {
                return Container(
                  margin: const EdgeInsets.only(right: 16),
                  child: _buildFeaturedAudiobookCard(
                    title: audiobook['name'] ?? '',
                    author: audiobook['author'] ?? '',
                    description:
                        audiobook['description'] ?? 'Audiolibro in italiano',
                    level: audiobook['level'] ?? 'A1',
                    duration: audiobook['duration'] ?? '00:00',
                    color: _getLevelColor(audiobook['level']),
                    image: audiobook['image'] ?? '',
                    audiobookData: audiobook,
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGridAudiobookCard(Map<String, dynamic> audiobook) {
    return _buildFeaturedAudiobookCard(
      title: audiobook['name'] ?? '',
      author: audiobook['author'] ?? '',
      description: audiobook['description'] ?? 'Audiolibro in italiano',
      level: audiobook['level'] ?? 'A1',
      duration: audiobook['duration'] ?? '00:00',
      color: _getLevelColor(audiobook['level']),
      image: audiobook['image'] ?? '',
      audiobookData: audiobook,
    );
  }

  Widget _buildAllAudiobooksSection() {
    final allAudiobooks = _filteredAudiobooks;

    if (allAudiobooks.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Tutti gli Audiolibri',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.75,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: allAudiobooks.length,
            itemBuilder: (context, index) {
              final audiobook = allAudiobooks[index];
              return _buildGridAudiobookCard(audiobook);
            },
          ),
        ],
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
