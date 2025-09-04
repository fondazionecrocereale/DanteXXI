import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'exercise_screen.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key, required this.id, required this.title});

  final int id;
  final String title;

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    _playFeedbackSound();
    Timer(const Duration(seconds: 3), () {
      _loadLessonAndGenerateExercises();
    });
  }

  Future<void> _loadLessonAndGenerateExercises() async {
    try {
      // 1. Cargar el mapa de aprendizaje
      final String learningMapString = await rootBundle.loadString(
        'assets/data/italian_learning_map.json',
      );
      final Map<String, dynamic> learningMap = jsonDecode(learningMapString);

      // 2. Encontrar la lección específica
      final List<dynamic> sections = learningMap['sections'] ?? [];
      List<dynamic> allLessons = [];

      // Recopilar todas las lecciones de todas las secciones
      for (var section in sections) {
        final List<dynamic> sectionLessons = section['lessons'] ?? [];
        allLessons.addAll(sectionLessons);
      }

      final lesson = allLessons.firstWhere(
        (lesson) => lesson['id'] == widget.id,
        orElse: () => null,
      );

      if (lesson == null) {
        debugPrint('Lesson ${widget.id} not found in learning map');
        return;
      }

      // 3. Obtener los tipos de ejercicios de la lección
      final List<String> exerciseTypes = List<String>.from(
        lesson['exerciseTypes'] ?? [],
      );

      if (exerciseTypes.isEmpty) {
        debugPrint('No exercise types defined for lesson ${widget.id}');
        return;
      }

      // 4. Generar ejercicios dinámicamente basándose en los tipos
      final Map<String, dynamic> generatedExercise = _generateExerciseFromTypes(
        exerciseTypes,
        lesson,
      );

      // 5. Navegar al ExerciseScreen con el ejercicio generado
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ExerciseScreen(
            jsonPath: '', // No necesitamos jsonPath ahora
            lessonId: widget.id,
            sectionTitle: widget.title,
            exerciseData: generatedExercise, // Pasar el ejercicio generado
          ),
        ),
      );
    } catch (e, stackTrace) {
      debugPrint('Error loading lesson: $e\n$stackTrace');
      // Fallback: usar el sistema anterior
      _useFallbackSystem();
    }
  }

  Map<String, dynamic> _generateExerciseFromTypes(
    List<String> exerciseTypes,
    Map<String, dynamic> lesson,
  ) {
    final List<Map<String, dynamic>> content = [];

    for (String exerciseType in exerciseTypes) {
      final Map<String, dynamic> exercise = _createExerciseByType(
        exerciseType,
        lesson,
      );
      content.add(exercise);
    }

    return {
      'title': lesson['title'] ?? 'Lección ${lesson['id']}',
      'content': content,
    };
  }

  Map<String, dynamic> _createExerciseByType(
    String exerciseType,
    Map<String, dynamic> lesson,
  ) {
    switch (exerciseType) {
      case 'multiple_choice':
        return {
          'exerciseType': 'multiple_choice',
          'question': '¿Cuál es la forma correcta de saludar en italiano?',
          'sound': '',
          'options': ['Ciao', 'Grazie', 'Prego', 'Arrivederci'],
          'correctAnswer': 'Ciao',
          'soundWrongAnswer': 'wrong.mp3',
          'soundCorrectAnswer': 'correct.mp3',
        };

      case 'translation':
        return {
          'exerciseType': 'translation',
          'question': 'Ciao, come stai?',
          'sound': '',
          'wordOptions': ['Hola', 'como', 'estás', 'bien', 'mal', 'gracias'],
          'correctAnswer': ['Hola', 'como', 'estás'],
          'soundWrongAnswer': 'wrong.mp3',
          'soundCorrectAnswer': 'correct.mp3',
        };

      case 'fill_in_the_blank':
        return {
          'exerciseType': 'fill_in_the_blank',
          'question': 'Mi chiamo _____ (My name is)',
          'sound': '',
          'options': ['Marco', 'Maria', 'Giuseppe', 'Anna'],
          'correctAnswer': 'Marco',
          'soundWrongAnswer': 'wrong.mp3',
          'soundCorrectAnswer': 'correct.mp3',
        };

      case 'matching_pairs':
        return {
          'exerciseType': 'matching_pairs',
          'question': 'Empareja los saludos con sus significados',
          'sound': '',
          'options': [
            {'left': 'Ciao', 'right': 'Hola/Adiós'},
            {'left': 'Buongiorno', 'right': 'Buenos días'},
            {'left': 'Buonasera', 'right': 'Buenas tardes'},
            {'left': 'Arrivederci', 'right': 'Hasta luego'},
          ],
          'correctPairs': [
            {'left': 'Ciao', 'right': 'Hola/Adiós'},
            {'left': 'Buongiorno', 'right': 'Buenos días'},
            {'left': 'Buonasera', 'right': 'Buenas tardes'},
            {'left': 'Arrivederci', 'right': 'Hasta luego'},
          ],
          'soundWrongAnswer': 'wrong.mp3',
          'soundCorrectAnswer': 'correct.mp3',
        };

      case 'multiple_choice_alt':
        return {
          'exerciseType': 'multiple_choice_alt',
          'question': '¿Qué significa "Grazie" en italiano?',
          'sound': '',
          'options': ['Por favor', 'Gracias', 'De nada', 'Hasta luego'],
          'correctAnswer': 'Gracias',
          'soundWrongAnswer': 'wrong.mp3',
          'soundCorrectAnswer': 'correct.mp3',
        };

      default:
        return {
          'exerciseType': 'multiple_choice',
          'question': 'Ejercicio de tipo: $exerciseType',
          'sound': '',
          'options': ['Opción 1', 'Opción 2', 'Opción 3', 'Opción 4'],
          'correctAnswer': 'Opción 1',
          'soundWrongAnswer': 'wrong.mp3',
          'soundCorrectAnswer': 'correct.mp3',
        };
    }
  }

  void _useFallbackSystem() {
    String? jsonPath;

    switch (widget.id) {
      case 1:
        jsonPath = 'assets/curso/1.json';
        break;
      case 2:
        jsonPath = 'assets/curso/2.json';
        break;
      case 3:
        jsonPath = 'assets/curso/3.json';
        break;
      case 4:
        jsonPath = 'assets/curso/4.json';
        break;
      case 5:
        jsonPath = 'assets/curso/5.json';
        break;
      case 6:
        jsonPath = 'assets/curso/6.json';
        break;
      case 7:
        jsonPath = 'assets/curso/7.json';
        break;
      case 8:
        jsonPath = 'assets/curso/8.json';
        break;
      default:
        debugPrint('Unknown exercise ID: ${widget.id}');
        return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ExerciseScreen(
          jsonPath: jsonPath!,
          lessonId: widget.id,
          sectionTitle: widget.title,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playFeedbackSound() async {
    try {
      // Solo reproducir si el archivo existe y no está vacío
      await _audioPlayer.setAsset('assets/audio/splash.mp3');
      await _audioPlayer.play();
    } catch (e) {
      debugPrint('Error playing feedback sound: $e');
      // No mostrar error si es un archivo placeholder
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(133, 27, 27, 1),
      body: Center(
        // Removido const aquí
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // AnimatedImageContainer
            Container(
              width: 100,
              height: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.school,
                size: 50,
                color: Color.fromRGBO(133, 27, 27, 1),
              ),
            ),
            const SizedBox(height: 20),
            // AnimatedLoadingText
            const Text(
              'Cargando lección...',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
