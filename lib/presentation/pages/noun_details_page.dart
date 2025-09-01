import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';

class NounDetailsPage extends StatefulWidget {
  final String nounWord;
  final String jsonPath;

  const NounDetailsPage({
    super.key,
    required this.nounWord,
    required this.jsonPath,
  });

  @override
  State<NounDetailsPage> createState() => _NounDetailsPageState();
}

class _NounDetailsPageState extends State<NounDetailsPage> {
  Map<String, dynamic>? _nounData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadNounData();
  }

  Future<void> _loadNounData() async {
    try {
      final String jsonString = await rootBundle.loadString(widget.jsonPath);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      final List<dynamic> nouns = jsonData['dictionary'] ?? [];
      final noun = nouns.firstWhere(
        (n) => n['word'] == widget.nounWord,
        orElse: () => null,
      );

      if (noun != null) {
        setState(() {
          _nounData = noun;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Sustantivo no encontrado';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Error cargando datos: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sustantivo: ${widget.nounWord}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error, size: 64, color: AppColors.error),
            const SizedBox(height: 16),
            Text(
              _errorMessage!,
              style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    if (_nounData == null) {
      return const Center(
        child: Text('No se encontraron datos del sustantivo'),
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildNounHeader(),
          const SizedBox(height: 24),
          _buildBasicInfo(),
          const SizedBox(height: 24),
          _buildTranslations(),
          const SizedBox(height: 24),
          _buildExamples(),
        ],
      ),
    );
  }

  Widget _buildNounHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.secondaryOrange,
            AppColors.secondaryOrange.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.secondaryOrange.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          // Imagen del sustantivo (si existe)
          if (_nounData!['image'] != null && _nounData!['image'].isNotEmpty)
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(40),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(40),
                child: Image.network(
                  _nounData!['image'],
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Icon(
                      Icons.image_not_supported,
                      size: 40,
                      color: AppColors.textSecondary,
                    );
                  },
                ),
              ),
            ),
          if (_nounData!['image'] != null && _nounData!['image'].isNotEmpty)
            const SizedBox(height: 16),

          Text(
            _nounData!['word'],
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '[${_nounData!['pronunciation']}]',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              _getGenderLabel(_nounData!['gender']),
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBasicInfo() {
    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Información Básica',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          _buildInfoRow('Significado', _nounData!['meaning']),
          const SizedBox(height: 12),
          _buildInfoRow('Tipo', _nounData!['abbreviation']),
          const SizedBox(height: 12),
          _buildInfoRow('Lengua', _nounData!['lingua']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
          ),
        ),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontSize: 14, color: AppColors.textPrimary),
          ),
        ),
      ],
    );
  }

  Widget _buildTranslations() {
    final translations = _nounData!['translation'] as Map<String, dynamic>;

    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Traducciones',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...translations.entries.map(
            (entry) => _buildTranslationCard(
              entry.key,
              entry.value as Map<String, dynamic>,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTranslationCard(
    String language,
    Map<String, dynamic> translation,
  ) {
    final languageNames = {
      'spanish': 'Español',
      'french': 'Francés',
      'german': 'Alemán',
      'english': 'Inglés',
    };

    final languageColors = {
      'spanish': AppColors.primaryBlue,
      'french': AppColors.secondaryBlue,
      'german': AppColors.secondaryGreen,
      'english': AppColors.secondaryOrange,
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color:
            languageColors[language]?.withValues(alpha: 0.05) ??
            AppColors.backgroundSecondary,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color:
              languageColors[language]?.withValues(alpha: 0.2) ??
              AppColors.borderLight,
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: languageColors[language] ?? AppColors.primaryBlue,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Center(
              child: Text(
                languageNames[language]?.substring(0, 1).toUpperCase() ??
                    language.substring(0, 1).toUpperCase(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  languageNames[language] ?? language,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: languageColors[language] ?? AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  translation['word'],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Género: ${_getGenderLabel(translation['gender'])}',
                  style: TextStyle(fontSize: 12, color: AppColors.textLight),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExamples() {
    final examples = _nounData!['examples'] as List<dynamic>;

    if (examples.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(20),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Ejemplos',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          ...examples.asMap().entries.map(
            (entry) => Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.backgroundSecondary,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: AppColors.borderLight),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: AppColors.secondaryOrange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                        height: 1.4,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getGenderLabel(String gender) {
    final labels = {
      'masculine': 'Masculino',
      'feminine': 'Femenino',
      'neuter': 'Neutro',
      'maschile': 'Masculino',
      'feminile': 'Femenino',
    };
    return labels[gender] ?? gender;
  }
}
