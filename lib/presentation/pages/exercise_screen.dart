import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import '../../domain/entities/question_model.dart';
import '../widgets/exercises/multiple_choice_widget.dart';
import '../widgets/exercises/multiple_choice_alt_widget.dart';
import '../widgets/exercises/fill_in_the_blank_widget.dart';
import '../widgets/exercises/matching_pairs_widget.dart';
import '../widgets/exercises/translation_widget.dart';
import 'home_page.dart';

class ExerciseScreen extends StatefulWidget {
  final String jsonPath;
  final String sectionTitle;
  final int lessonId;
  final Map<String, dynamic>? exerciseData; // Nuevo parámetro opcional

  const ExerciseScreen({
    super.key,
    required this.jsonPath,
    required this.sectionTitle,
    required this.lessonId,
    this.exerciseData, // Nuevo parámetro opcional
  });

  @override
  State<ExerciseScreen> createState() => _ExerciseScreenState();
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  GrammarExercise? exercise;
  int currentQuestionIndex = 0;
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    if (widget.exerciseData != null) {
      // Si tenemos exerciseData, usarlo directamente
      _loadExerciseFromData();
    } else {
      // Si no, cargar desde jsonPath (sistema anterior)
      _loadExerciseData();
    }
  }

  void _loadExerciseFromData() {
    try {
      setState(() {
        exercise = GrammarExercise.fromJson(widget.exerciseData!);
        errorMessage = null;
      });
    } catch (e, stackTrace) {
      debugPrint('Error loading exercise from data: $e\n$stackTrace');
      setState(() {
        errorMessage = 'Failed to load exercise: $e';
      });
    }
  }

  Future<void> _loadExerciseData() async {
    try {
      final String jsonString = await rootBundle.loadString(widget.jsonPath);
      final Map<String, dynamic> jsonData = jsonDecode(jsonString);
      setState(() {
        exercise = GrammarExercise.fromJson(jsonData);
        errorMessage = null;
      });
    } catch (e, stackTrace) {
      debugPrint('Error loading exercise data: $e\n$stackTrace');
      setState(() {
        errorMessage = 'Failed to load exercise: $e';
      });
    }
  }

  void nextQuestion() {
    setState(() {
      if (currentQuestionIndex < (exercise!.content.length - 1)) {
        currentQuestionIndex++;
      } else {
        currentQuestionIndex = 0; // Restart
      }
    });
  }

  void previousQuestion() {
    setState(() {
      if (currentQuestionIndex > 0) {
        currentQuestionIndex--;
      }
    });
  }

  Widget _getExerciseWidget(Question question) {
    switch (question.exerciseType) {
      case 'multiple_choice':
        return MultipleChoiceWidget(
          question: question,
          onNext: nextQuestion,
          onPrevious: previousQuestion,
          isLastQuestion: currentQuestionIndex == exercise!.content.length - 1,
          lessonId: widget.lessonId,
          sectionTitle: widget.sectionTitle,
        );
      case 'multiple_choice_alt':
        return MultipleChoiceAltWidget(
          question: question,
          onNext: nextQuestion,
          onPrevious: previousQuestion,
          isLastQuestion: currentQuestionIndex == exercise!.content.length - 1,
          lessonId: widget.lessonId,
          sectionTitle: widget.sectionTitle,
        );
      case 'fill_in_the_blank':
        return FillInTheBlankWidget(
          question: question,
          onNext: nextQuestion,
          onPrevious: previousQuestion,
          isLastQuestion: currentQuestionIndex == exercise!.content.length - 1,
          lessonId: widget.lessonId,
          sectionTitle: widget.sectionTitle,
        );
      case 'matching_pairs':
        return MatchingPairsWidget(
          question: question,
          onNext: nextQuestion,
          onPrevious: previousQuestion,
          isLastQuestion: currentQuestionIndex == exercise!.content.length - 1,
          currentQuestionIndex: currentQuestionIndex,
          lessonId: widget.lessonId,
          sectionTitle: widget.sectionTitle,
        );
      case 'translation':
        return TranslationWidget(
          question: question,
          onNext: nextQuestion,
          onPrevious: previousQuestion,
          isLastQuestion: currentQuestionIndex == exercise!.content.length - 1,
          currentQuestionIndex: currentQuestionIndex,
          lessonId: widget.lessonId,
          sectionTitle: widget.sectionTitle,
        );
      default:
        return const Center(child: Text('Tipo de ejercicio no soportado'));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (errorMessage != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                errorMessage!,
                style: const TextStyle(color: Colors.red, fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                  );
                },
                child: const Text('Back to Home'),
              ),
            ],
          ),
        ),
      );
    }

    if (exercise == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    final currentQuestion = exercise!.content[currentQuestionIndex];
    return _getExerciseWidget(currentQuestion);
  }
}
