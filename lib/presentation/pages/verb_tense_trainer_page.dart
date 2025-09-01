import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class VerbTenseTrainerPage extends StatefulWidget {
  final String verbInfinito;
  final String tenseKey;
  final String tenseLabel;
  final Map<String, String> conjugations;

  const VerbTenseTrainerPage({
    super.key,
    required this.verbInfinito,
    required this.tenseKey,
    required this.tenseLabel,
    required this.conjugations,
  });

  @override
  State<VerbTenseTrainerPage> createState() => _VerbTenseTrainerPageState();
}

class _VerbTenseTrainerPageState extends State<VerbTenseTrainerPage> {
  int _currentQuestionIndex = 0;
  int _correctAnswers = 0;
  String? _selectedAnswer;
  bool _showingResult = false;
  List<String> _questions = [];
  List<List<String>> _options = [];

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    _questions = widget.conjugations.keys
        .where((k) => widget.conjugations[k]!.isNotEmpty)
        .toList();
    _questions.shuffle();

    _options = _questions.map((pronoun) {
      final correctAnswer = widget.conjugations[pronoun]!;
      final otherAnswers = widget.conjugations.values
          .where((v) => v != correctAnswer && v.isNotEmpty)
          .take(3)
          .toList();

      final options = [correctAnswer, ...otherAnswers];
      options.shuffle();
      return options;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    if (_questions.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: const Center(child: Text('No hay conjugaciones disponibles')),
      );
    }

    final isFinished = _currentQuestionIndex >= _questions.length;

    return Scaffold(
      appBar: AppBar(
        title: Text('Entrenar: ${widget.verbInfinito} • ${widget.tenseLabel}'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: isFinished ? _buildResultsScreen() : _buildQuestionScreen(),
      ),
    );
  }

  Widget _buildQuestionScreen() {
    final currentPronoun = _questions[_currentQuestionIndex];
    final correctAnswer = widget.conjugations[currentPronoun]!;
    final options = _options[_currentQuestionIndex];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Progreso
        Row(
          children: [
            Text(
              'Pregunta ${_currentQuestionIndex + 1} de ${_questions.length}',
              style: TextStyle(fontSize: 16, color: AppColors.textSecondary),
            ),
            const Spacer(),
            Text(
              'Correctas: $_correctAnswers',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.success,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        LinearProgressIndicator(
          value: _currentQuestionIndex / _questions.length,
          backgroundColor: AppColors.borderLight,
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primaryBlue),
        ),
        const SizedBox(height: 32),

        // Pregunta
        Center(
          child: Column(
            children: [
              Text(
                'Conjuga el verbo "${widget.verbInfinito}" para:',
                style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: AppColors.primaryBlue,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primaryBlue.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Text(
                  _getPronounLabel(currentPronoun),
                  style: const TextStyle(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 40),

        // Opciones
        Expanded(
          child: ListView.builder(
            itemCount: options.length,
            itemBuilder: (context, index) {
              final option = options[index];
              final isSelected = _selectedAnswer == option;
              final isCorrect = option == correctAnswer;

              Color? backgroundColor;
              Color? borderColor;
              Color? textColor;

              if (_showingResult && isSelected) {
                backgroundColor = isCorrect
                    ? AppColors.success
                    : AppColors.error;
                borderColor = isCorrect ? AppColors.success : AppColors.error;
                textColor = Colors.white;
              } else if (_showingResult && isCorrect) {
                backgroundColor = AppColors.success.withValues(alpha: 0.1);
                borderColor = AppColors.success;
                textColor = AppColors.success;
              } else if (isSelected) {
                backgroundColor = AppColors.primaryBlue.withValues(alpha: 0.1);
                borderColor = AppColors.primaryBlue;
                textColor = AppColors.primaryBlue;
              } else {
                backgroundColor = AppColors.backgroundCard;
                borderColor = AppColors.borderLight;
                textColor = AppColors.textPrimary;
              }

              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: _showingResult ? null : () => _selectAnswer(option),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: borderColor, width: 2),
                      ),
                      child: Center(
                        child: Text(
                          option,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Botón siguiente
        if (_showingResult)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: _nextQuestion,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                _currentQuestionIndex == _questions.length - 1
                    ? 'Ver Resultados'
                    : 'Siguiente Pregunta',
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildResultsScreen() {
    final percentage = (_correctAnswers / _questions.length * 100).round();

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          percentage >= 80 ? Icons.celebration : Icons.thumb_up,
          size: 80,
          color: percentage >= 80 ? AppColors.success : AppColors.warning,
        ),
        const SizedBox(height: 24),
        Text(
          '¡Entrenamiento Completado!',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 16),
        Text(
          'Respuestas correctas: $_correctAnswers de ${_questions.length}',
          style: TextStyle(fontSize: 18, color: AppColors.textSecondary),
        ),
        const SizedBox(height: 8),
        Text(
          '$percentage%',
          style: TextStyle(
            fontSize: 36,
            fontWeight: FontWeight.bold,
            color: percentage >= 80 ? AppColors.success : AppColors.warning,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            Expanded(
              child: ElevatedButton(
                onPressed: _restart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.secondaryGreen,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Entrenar de Nuevo'),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: ElevatedButton(
                onPressed: () => Navigator.of(context).pop(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text('Volver'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _selectAnswer(String answer) {
    if (_showingResult) return;

    setState(() {
      _selectedAnswer = answer;
      _showingResult = true;
    });

    final currentPronoun = _questions[_currentQuestionIndex];
    final correctAnswer = widget.conjugations[currentPronoun]!;
    final isCorrect = answer == correctAnswer;

    if (isCorrect) {
      _correctAnswers++;
    }
  }

  void _nextQuestion() {
    setState(() {
      _currentQuestionIndex++;
      _selectedAnswer = null;
      _showingResult = false;
    });
  }

  void _restart() {
    setState(() {
      _currentQuestionIndex = 0;
      _correctAnswers = 0;
      _selectedAnswer = null;
      _showingResult = false;
    });
    _generateQuestions();
  }

  String _getPronounLabel(String pronoun) {
    const labels = {
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
