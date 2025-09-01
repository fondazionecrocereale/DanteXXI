import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

import '../../core/constants/app_colors.dart';
import 'verb_tense_trainer_page.dart';

class VerbConjugationPage extends StatefulWidget {
  final String verbInfinito;
  final String jsonPath;

  const VerbConjugationPage({
    super.key,
    required this.verbInfinito,
    required this.jsonPath,
  });

  @override
  State<VerbConjugationPage> createState() => _VerbConjugationPageState();
}

class _VerbConjugationPageState extends State<VerbConjugationPage> {
  Map<String, dynamic>? _verbData;
  bool _isLoading = true;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _loadVerbData();
  }

  Future<void> _loadVerbData() async {
    try {
      final String jsonString = await rootBundle.loadString(widget.jsonPath);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);

      final List<dynamic> verbs = jsonData['verbs'] ?? [];
      final verb = verbs.firstWhere(
        (v) => v['infinito'] == widget.verbInfinito,
        orElse: () => null,
      );

      if (verb != null) {
        setState(() {
          _verbData = verb;
          _isLoading = false;
        });
      } else {
        setState(() {
          _errorMessage = 'Verbo no encontrado';
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
        title: Text('Conjugación: ${widget.verbInfinito}'),
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

    if (_verbData == null) {
      return const Center(child: Text('No se encontraron datos del verbo'));
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildVerbHeader(),
          const SizedBox(height: 24),
          _buildBasicInfo(),
          const SizedBox(height: 24),
          _buildConjugations(),
        ],
      ),
    );
  }

  Widget _buildVerbHeader() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryBlue,
            AppColors.primaryBlue.withValues(alpha: 0.8),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlue.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            _verbData!['infinito'],
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '[${_verbData!['pronunciation']}]',
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white70,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _verbData!['traduzione'],
            style: const TextStyle(
              fontSize: 24,
              color: Colors.white,
              fontWeight: FontWeight.w600,
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
          _buildInfoRow('Definición', _verbData!['definizione']),
          const SizedBox(height: 12),
          _buildInfoRow(
            'Participio Presente',
            _verbData!['participioPresente'],
          ),
          const SizedBox(height: 12),
          _buildInfoRow('Gerundio', _verbData!['gerundio']),
          const SizedBox(height: 12),
          _buildInfoRow('Participio Pasado', _verbData!['participioPassato']),
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 120,
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

  Widget _buildConjugations() {
    final conjugations = _verbData!['conjugations'] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Conjugaciones',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        ...conjugations.entries.map(
          (entry) =>
              _buildTenseCard(entry.key, entry.value as Map<String, dynamic>),
        ),
      ],
    );
  }

  Widget _buildTenseCard(String tense, Map<String, dynamic> conjugations) {
    final tenseNames = {
      'presente': 'Presente',
      'passatoProssimo': 'Passato Prossimo',
      'imperfetto': 'Imperfetto',
      'trapassatoProssimo': 'Trapassato Prossimo',
      'futuro': 'Futuro',
      'futuroAnteriore': 'Futuro Anteriore',
      'passatoRemoto': 'Passato Remoto',
      'presenteCongiuntivo': 'Presente Congiuntivo',
      'passatoCongiuntivo': 'Passato Congiuntivo',
      'imperfettoCongiuntivo': 'Imperfetto Congiuntivo',
      'trapassatoCongiuntivo': 'Trapassato Congiuntivo',
      'condizionalePresente': 'Condizionale Presente',
      'condizionalePassato': 'Condizionale Passato',
      'imperativoPresente': 'Imperativo Presente',
    };

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ExpansionTile(
        title: Text(
          tenseNames[tense] ?? tense,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: conjugations.entries.map((entry) {
                if (entry.value.isEmpty) return const SizedBox.shrink();

                return Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 12,
                  ),
                  margin: const EdgeInsets.only(bottom: 4),
                  decoration: BoxDecoration(
                    color: AppColors.backgroundSecondary,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    children: [
                      SizedBox(
                        width: 80,
                        child: Text(
                          _getPronounLabel(entry.key),
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.primaryBlue,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          entry.value,
                          style: const TextStyle(
                            fontSize: 14,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => VerbTenseTrainerPage(
                        verbInfinito: _verbData!['infinito'] as String,
                        tenseKey: tense,
                        tenseLabel: tenseNames[tense] ?? tense,
                        conjugations: Map<String, String>.from(conjugations),
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.fitness_center),
                label: const Text('Entrenar este tiempo'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getPronounLabel(String pronoun) {
    final labels = {
      'io': 'Io',
      'tu': 'Tu',
      'lui/lei': 'Lui/Lei',
      'noi': 'Noi',
      'voi': 'Voi',
      'loro': 'Loro',
    };
    return labels[pronoun] ?? pronoun;
  }
}
