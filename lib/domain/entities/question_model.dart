class GrammarExercise {
  final String title;
  final List<Question> content;

  GrammarExercise({required this.title, required this.content});

  factory GrammarExercise.fromJson(Map<String, dynamic> json) {
    return GrammarExercise(
      title: json['title'] as String,
      content: (json['content'] as List<dynamic>)
          .map((item) => Question.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Question {
  final String exerciseType;
  final String question;
  final String? sound;
  final dynamic options; // Puede ser List<String> o List<Map<String, String>>
  final List<String>? wordOptions; // Para translation
  final dynamic correctAnswer; // Puede ser String o List<String>
  final List<Map<String, String>>? correctPairs; // Para matching_pairs
  final String soundWrongAnswer;
  final String soundCorrectAnswer;

  Question({
    required this.exerciseType,
    required this.question,
    this.sound,
    this.options,
    this.wordOptions,
    this.correctAnswer,
    this.correctPairs,
    required this.soundWrongAnswer,
    required this.soundCorrectAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      exerciseType: json['exerciseType'] as String,
      question: json['question'] as String,
      sound: json['sound'] as String? ?? '',
      options: json['options'],
      correctAnswer: json['correctAnswer'],
      correctPairs: json['correctPairs'] != null
          ? (json['correctPairs'] as List)
                .map((item) => Map<String, String>.from(item as Map))
                .toList()
          : null,
      soundWrongAnswer: json['soundWrongAnswer'] ?? '',
      soundCorrectAnswer: json['soundCorrectAnswer'] ?? '',
      wordOptions: json['wordOptions'] != null
          ? List<String>.from(json['wordOptions'] as List)
          : null,
    );
  }

  // Getters útiles para facilitar el uso
  List<String>? get optionsAsStringList {
    if (options is List<String>) return options as List<String>;
    return null;
  }

  List<Map<String, String>>? get optionsAsMapList {
    if (options is List<Map<String, String>>) {
      return options as List<Map<String, String>>;
    }
    return null;
  }

  String? get correctAnswerAsString {
    if (correctAnswer is String) return correctAnswer as String;
    return null;
  }

  List<String>? get correctAnswerAsList {
    if (correctAnswer is List<String>) {
      return List<String>.from(correctAnswer as List);
    }
    return null;
  }
}
