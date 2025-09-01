import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/services/lesson_service.dart';
import 'package:dantexxi/domain/entities/question_model.dart';

class TranslationWidget extends StatefulWidget {
  final Question question;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLastQuestion;
  final int currentQuestionIndex;
  final String sectionTitle;
  final int lessonId;

  const TranslationWidget({
    super.key,
    required this.question,
    required this.onNext,
    required this.onPrevious,
    required this.isLastQuestion,
    required this.currentQuestionIndex,
    required this.sectionTitle,
    required this.lessonId,
  });

  @override
  State<TranslationWidget> createState() => _TranslationWidgetState();
}

class _TranslationWidgetState extends State<TranslationWidget> {
  List<String> selectedWords = [];
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

  void selectWord(String word) {
    setState(() {
      selectedWords.add(word);
    });
  }

  void removeWord(int index) {
    setState(() {
      selectedWords.removeAt(index);
    });
  }

  void checkAnswer() {
    setState(() {
      isCorrect =
          selectedWords.join(' ') ==
          widget.question.correctAnswerAsList?.join(' ');
      showResult = true;
    });
    _playFeedbackSound(isCorrect);
  }

  void resetAndNavigate(VoidCallback navigationCallback) {
    setState(() {
      selectedWords = [];
      showResult = false;
      isCorrect = false;
    });
    navigationCallback();
    _playQuestionSound(widget.question.sound);
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
              "Escribe esto en español",
              style: GoogleFonts.getFont(
                'Tinos',
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.person, size: 80, color: Colors.black),
                const SizedBox(width: 10),
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Row(
                    children: [
                      Text(
                        widget.question.question,
                        style: GoogleFonts.getFont(
                          'Tinos',
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(width: 10),
                      IconButton(
                        icon: const Icon(
                          Icons.volume_up,
                          color: Colors.blue,
                          size: 24,
                        ),
                        onPressed: () {
                          _playQuestionSound(widget.question.sound);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[300]!),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Wrap(
                      spacing: 5,
                      children: selectedWords.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: () => removeWord(entry.key),
                          child: Chip(
                            label: Text(
                              entry.value,
                              style: GoogleFonts.getFont('Tinos', fontSize: 14),
                            ),
                            backgroundColor: Colors.grey[200],
                            deleteIcon: const Icon(Icons.close, size: 16),
                            onDeleted: () => removeWord(entry.key),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: widget.question.wordOptions!.map((word) {
                return GestureDetector(
                  onTap: selectedWords.contains(word) || showResult
                      ? null
                      : () => selectWord(word),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: selectedWords.contains(word)
                          ? Colors.grey[300]
                          : Colors.white,
                      border: Border.all(color: Colors.grey[300]!),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      word,
                      style: GoogleFonts.getFont(
                        'Tinos',
                        fontSize: 16,
                        color: selectedWords.contains(word)
                            ? Colors.grey
                            : Colors.black,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 20),
            if (!showResult && selectedWords.isNotEmpty)
              ElevatedButton(
                onPressed: checkAnswer,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 100,
                    vertical: 15,
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
            if (showResult) ...[
              Text(
                isCorrect
                    ? "¡Correcto! 🎉"
                    : "Incorrecto. Respuesta correcta: ${widget.question.correctAnswerAsList?.join(' ') ?? ''}",
                style: GoogleFonts.getFont(
                  'Tinos',
                  fontSize: 16,
                  color: isCorrect ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (widget.currentQuestionIndex > 0)
                    ElevatedButton(
                      onPressed: () => resetAndNavigate(widget.onPrevious),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
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
                  const SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {
                      widget.isLastQuestion
                          ? () => LessonService.completeLessonAndNavigate(
                              context: context,
                              sectionTitle: widget.sectionTitle,
                              lessonId: widget.lessonId,
                            )
                          : resetAndNavigate(widget.onNext);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
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
