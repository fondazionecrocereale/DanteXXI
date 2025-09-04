import 'package:dantexxi/domain/entities/question_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/services/lesson_service.dart';

class FillInTheBlankWidget extends StatefulWidget {
  final Question question;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLastQuestion;
  final String sectionTitle;
  final int lessonId;

  const FillInTheBlankWidget({
    super.key,
    required this.question,
    required this.onNext,
    required this.onPrevious,
    required this.isLastQuestion,
    required this.sectionTitle,
    required this.lessonId,
  });

  @override
  State<FillInTheBlankWidget> createState() => _FillInTheBlankWidgetState();
}

class _FillInTheBlankWidgetState extends State<FillInTheBlankWidget> {
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
    if (soundPath.isNotEmpty) {
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
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
                      lives,
                      (index) => const Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: Text(
                  "COMPLETAR EL ESPACIO",
                  style: GoogleFonts.getFont(
                    'Tinos',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
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
              const SizedBox(height: 40),
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
              if (!showResult)
                Center(
                  child: ElevatedButton(
                    onPressed: selectedAnswer != null
                        ? () => checkAnswer(selectedAnswer!)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300],
                      foregroundColor: Colors.black,
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
                        widget.isLastQuestion ? "REINICIAR" : "CONTINUAR",
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
