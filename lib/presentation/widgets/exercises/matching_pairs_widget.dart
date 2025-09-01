import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/services/lesson_service.dart';
import 'package:dantexxi/domain/entities/question_model.dart';

class MatchingPairsWidget extends StatefulWidget {
  final Question question;
  final VoidCallback onNext;
  final VoidCallback onPrevious;
  final bool isLastQuestion;
  final int currentQuestionIndex;
  final int lessonId;
  final String sectionTitle;

  const MatchingPairsWidget({
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
  State<MatchingPairsWidget> createState() => _MatchingPairsWidgetState();
}

class _MatchingPairsWidgetState extends State<MatchingPairsWidget> {
  String? firstSelected;
  String? secondSelected;
  List<Map<String, String>> matchedPairs = [];
  bool showResult = false;
  bool isCorrect = false;
  final AudioPlayer _audioPlayer = AudioPlayer();
  int lives = 3;

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

  void selectWord(String word, bool isLeftColumn) {
    if (showResult ||
        matchedPairs.any(
          (pair) => pair['left'] == word || pair['right'] == word,
        )) {
      return;
    }

    setState(() {
      if (isLeftColumn) {
        firstSelected = word;
      } else {
        secondSelected = word;
      }

      if (firstSelected != null && secondSelected != null) {
        checkPair();
      }
    });
  }

  void checkPair() {
    if (firstSelected == null || secondSelected == null) return;

    final correctPairs = widget.question.correctPairs ?? [];
    setState(() {
      isCorrect = correctPairs.any(
        (pair) =>
            pair['left'] == firstSelected && pair['right'] == secondSelected,
      );

      if (isCorrect) {
        matchedPairs.add({'left': firstSelected!, 'right': secondSelected!});
        firstSelected = null;
        secondSelected = null;
        showResult = false;
      } else {
        lives--;
        showResult = true;
      }
    });

    _playFeedbackSound(isCorrect);
  }

  void resetAndNavigate(VoidCallback navigationCallback) {
    setState(() {
      firstSelected = null;
      secondSelected = null;
      matchedPairs = [];
      showResult = false;
      isCorrect = false;
      lives = 3;
    });
    navigationCallback();
    _playQuestionSound(widget.question.sound);
  }

  @override
  Widget build(BuildContext context) {
    final options = List<Map<String, String>>.from(
      widget.question.optionsAsMapList ?? [],
    )..shuffle();
    final leftWords = options.map((pair) => pair['left'] as String).toList();
    final rightWords = options.map((pair) => pair['right'] as String).toList()
      ..shuffle();

    final totalPairs = widget.question.correctPairs?.length ?? 0;
    final progress = totalPairs > 0 ? matchedPairs.length / totalPairs : 0.0;

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
                    onPressed: () => Navigator.of(context).pop(),
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
                      3,
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
              Center(
                child: Text(
                  "Empareja las palabras",
                  style: GoogleFonts.getFont(
                    'Tinos',
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: leftWords.map((word) {
                        final isMatched = matchedPairs.any(
                          (pair) => pair['left'] == word,
                        );
                        final isSelected = firstSelected == word;

                        return GestureDetector(
                          onTap: isMatched
                              ? null
                              : () => selectWord(word, true),
                          child: Container(
                            width: 140,
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                              color: isSelected && !isMatched
                                  ? Colors.blue[100]
                                  : isMatched
                                  ? Colors.green[100]
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                word,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Tinos',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: rightWords.map((word) {
                        final isMatched = matchedPairs.any(
                          (pair) => pair['right'] == word,
                        );
                        final isSelected = secondSelected == word;

                        return GestureDetector(
                          onTap: isMatched
                              ? null
                              : () => selectWord(word, false),
                          child: Container(
                            width: 140,
                            padding: const EdgeInsets.all(16.0),
                            margin: const EdgeInsets.symmetric(vertical: 4.0),
                            decoration: BoxDecoration(
                              color: isSelected && !isMatched
                                  ? Colors.blue[100]
                                  : isMatched
                                  ? Colors.green[100]
                                  : Colors.white,
                              border: Border.all(
                                color: Colors.grey[300]!,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                word,
                                textAlign: TextAlign.center,
                                style: GoogleFonts.getFont(
                                  'Tinos',
                                  fontSize: 16,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
              if (showResult && !isCorrect) ...[
                Center(
                  child: Text(
                    lives > 0
                        ? "Incorrecto. ¡Intenta de nuevo!"
                        : "¡Game Over!",
                    style: GoogleFonts.getFont(
                      'Tinos',
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              if (matchedPairs.length == totalPairs && lives > 0) ...[
                Center(
                  child: Text(
                    "¡Correcto! 🎉",
                    style: GoogleFonts.getFont(
                      'Tinos',
                      fontSize: 16,
                      color: Colors.green,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 20),
              ],
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.currentQuestionIndex > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 10.0),
                        child: ElevatedButton(
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
                      ),
                    ElevatedButton(
                      onPressed: () {
                        if (matchedPairs.length == totalPairs && lives > 0) {
                          resetAndNavigate(widget.onNext);
                        } else if (firstSelected != null &&
                            secondSelected != null) {
                          checkPair();
                        } else {
                          widget.isLastQuestion
                              ? () => LessonService.completeLessonAndNavigate(
                                  context: context,
                                  sectionTitle: widget.sectionTitle,
                                  lessonId: widget.lessonId,
                                )
                              : widget.onNext;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            matchedPairs.length == totalPairs && lives > 0
                            ? Colors.blue
                            : Colors.grey[300],
                        foregroundColor:
                            matchedPairs.length == totalPairs && lives > 0
                            ? Colors.white
                            : Colors.black,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 15,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        matchedPairs.length == totalPairs && lives > 0
                            ? (widget.isLastQuestion
                                  ? "Reiniciar"
                                  : "Siguiente")
                            : "Verificar",
                        style: GoogleFonts.getFont(
                          'Tinos',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
