import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/services/lesson_service.dart';
import 'package:dantexxi/domain/entities/question_model.dart';

class MultipleChoiceWidget extends StatefulWidget {
  final Question question;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLastQuestion;
  final int lessonId;
  final String sectionTitle;

  const MultipleChoiceWidget({
    super.key,
    required this.question,
    required this.onNext,
    required this.onPrevious,
    required this.isLastQuestion,
    required this.lessonId,
    required this.sectionTitle,
  });

  @override
  State<MultipleChoiceWidget> createState() => _MultipleChoiceWidgetState();
}

class _MultipleChoiceWidgetState extends State<MultipleChoiceWidget> {
  String? selectedAnswer;
  bool showResult = false;
  bool isCorrect = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

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
    });
    _playFeedbackSound(isCorrect);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Row(
              children: List.generate(
                3,
                (index) => const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 2.0),
                  child: Icon(Icons.favorite, color: Colors.red, size: 20),
                ),
              ),
            ),
            const Spacer(),
            const SizedBox(width: 48),
          ],
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: Colors.purple[100],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                "NUEVA PALABRA",
                style: GoogleFonts.getFont(
                  'Tinos',
                  fontSize: 14,
                  color: Colors.purple[800],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(
              widget.question.question,
              style: GoogleFonts.getFont(
                'Tinos',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
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
                  if (widget.lessonId > 1)
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
                        horizontal: 50,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: Text(
                      widget.isLastQuestion ? "Finalizar" : "Siguiente",
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
    );
  }
}
