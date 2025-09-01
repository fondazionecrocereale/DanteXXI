import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/services/lesson_service.dart';
import 'package:dantexxi/domain/entities/question_model.dart';

class MultipleChoiceAltWidget extends StatefulWidget {
  final Question question;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLastQuestion;
  final int lessonId;
  final String sectionTitle;

  const MultipleChoiceAltWidget({
    super.key,
    required this.question,
    required this.onNext,
    required this.onPrevious,
    required this.isLastQuestion,
    required this.lessonId,
    required this.sectionTitle,
  });

  @override
  State<MultipleChoiceAltWidget> createState() =>
      _MultipleChoiceAltWidgetState();
}

class _MultipleChoiceAltWidgetState extends State<MultipleChoiceAltWidget> {
  String? selectedAnswer;
  bool showResult = false;
  bool isCorrect = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int lives = 2;
  double progress = 0.1;

  @override
  void initState() {
    super.initState();
    _playQuestionSound(widget.question.sound);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playQuestionSound(String? soundUrl) async {
    if (soundUrl != null && soundUrl.isNotEmpty) {
      try {
        await _audioPlayer.setAsset('assets/audio/$soundUrl');
        await _audioPlayer.play();
      } catch (e) {
        debugPrint('Error playing question sound: $e');
      }
    }
  }

  Future<void> _playFeedbackSound(bool isCorrect) async {
    final soundPath = isCorrect
        ? widget.question.soundCorrectAnswer
        : widget.question.soundWrongAnswer;
    if (soundPath != null && soundPath.isNotEmpty) {
      try {
        await _audioPlayer.setAsset('assets/audio/$soundPath');
        await _audioPlayer.play();
      } catch (e) {
        debugPrint('Error playing feedback sound: $e');
      }
    }
  }

  void checkAnswer(String answer) {
    setState(() {
      selectedAnswer = answer;
      isCorrect = answer == widget.question.correctAnswer;
      showResult = true;
      if (!isCorrect && lives > 0) {
        lives--;
      }
    });
    _playFeedbackSound(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ejercicio'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barra superior con vidas y progreso
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const SizedBox(width: 48), // Espacio para balancear
                  Expanded(
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[300],
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        Colors.green,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Row(
                    children: List.generate(
                      2,
                      (index) => Padding(
                        padding: const EdgeInsets.only(left: 4.0),
                        child: Icon(
                          Icons.favorite,
                          color: index < lives ? Colors.red : Colors.grey,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              // Personaje y pregunta en globo de chat
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: const Center(
                      child: Text("👦", style: TextStyle(fontSize: 40)),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.question.question,
                      style: GoogleFonts.getFont(
                        'Tinos',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Instrucción
              Center(
                child: Text(
                  "Selecciona el significado correcto",
                  style: GoogleFonts.getFont(
                    'Tinos',
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Opciones de respuesta
              ...List.generate(widget.question.optionsAsStringList!.length, (
                index,
              ) {
                final option = widget.question.optionsAsStringList![index];
                final isSelected = selectedAnswer == option;
                Color? borderColor;
                if (showResult && isSelected) {
                  borderColor = isCorrect ? Colors.green : Colors.red;
                }

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: GestureDetector(
                    onTap: showResult ? null : () => checkAnswer(option),
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: borderColor ?? Colors.grey[300]!,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Text(
                          option,
                          style: GoogleFonts.getFont(
                            'Tinos',
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const Spacer(),

              // Botón de verificar (cuando no se ha mostrado resultado)
              if (!showResult)
                Center(
                  child: ElevatedButton(
                    onPressed: selectedAnswer != null
                        ? () => checkAnswer(selectedAnswer!)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 100,
                        vertical: 16,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      "VERIFICAR",
                      style: GoogleFonts.getFont(
                        'Tinos',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

              // Resultado y botones de navegación
              if (showResult) ...[
                Center(
                  child: Text(
                    isCorrect
                        ? "¡Correcto! 🎉"
                        : "Incorrecto. La respuesta correcta es: ${widget.question.correctAnswer}",
                    style: GoogleFonts.getFont(
                      'Tinos',
                      fontSize: 16,
                      color: isCorrect ? Colors.green : Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: widget.onPrevious,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        "Anterior",
                        style: GoogleFonts.getFont('Tinos', fontSize: 16),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: widget.isLastQuestion
                          ? () => LessonService.completeLessonAndNavigate(
                              context: context,
                              sectionTitle: widget.sectionTitle,
                              lessonId: widget.lessonId,
                            )
                          : widget.onNext,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        widget.isLastQuestion ? "Finalizar" : "CONTINUAR",
                        style: GoogleFonts.getFont(
                          'Tinos',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
