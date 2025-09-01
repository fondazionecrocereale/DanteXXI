import 'package:flutter/material.dart';

class DivineComedyModel {
  final String title;
  final List<String> cefrRange;
  final ColorModel baseColor;
  final ColorModel textColor;
  final ColorModel cardColor;
  final String backgroundImage;
  final List<Lesson> lessons;

  DivineComedyModel({
    required this.title,
    required this.cefrRange,
    required this.baseColor,
    required this.textColor,
    required this.cardColor,
    required this.backgroundImage,
    required this.lessons,
  });

  factory DivineComedyModel.fromJson(Map<String, dynamic> json) {
    return DivineComedyModel(
      title: json['title'],
      cefrRange: List<String>.from(json['cefr_range']),
      baseColor: ColorModel.fromJson(json['baseColor']),
      textColor: ColorModel.fromJson(json['textColor']),
      cardColor: ColorModel.fromJson(json['cardColor']),
      backgroundImage: json['backgroundImage'],
      lessons: (json['lessons'] as List<dynamic>)
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
    );
  }

  factory DivineComedyModel.fromFirestore(Map<String, dynamic> data) {
    return DivineComedyModel(
      title: data['title'] ?? '',
      cefrRange: List<String>.from(data['cefr_range'] ?? []),
      baseColor: ColorModel.fromJson(data['baseColor'] ?? {}),
      textColor: ColorModel.fromJson(data['textColor'] ?? {}),
      cardColor: ColorModel.fromJson(data['cardColor'] ?? {}),
      backgroundImage: data['backgroundImage'] ?? '',
      lessons: (data['lessons'] as List<dynamic>? ?? [])
          .map((lesson) => Lesson.fromJson(lesson))
          .toList(),
    );
  }
}

class Lesson {
  final int id;
  final bool isCompleted;
  final bool isUnlocked;
  final String livello;
  final List<int> nextLessonIds;
  final Position position;
  final String title;
  final String uid;

  Lesson({
    required this.id,
    required this.isCompleted,
    required this.isUnlocked,
    required this.livello,
    required this.nextLessonIds,
    required this.position,
    required this.title,
    required this.uid,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      isCompleted: json['isCompleted'],
      isUnlocked: json['isUnlocked'],
      livello: json['livello'],
      nextLessonIds: List<int>.from(json['nextLessonIds']),
      position: Position.fromJson(json['position']),
      title: json['title'],
      uid: json['uid'],
    );
  }

  factory Lesson.fromMap(Map<String, dynamic> data, {required String docId}) {
    return Lesson(
      id: data['id'] ?? 0,
      isCompleted: data['isCompleted'] ?? false,
      isUnlocked: data['isUnlocked'] ?? false,
      livello: data['livello'] ?? '',
      nextLessonIds: List<int>.from(data['nextLessonIds'] ?? []),
      position: Position.fromJson(data['position'] ?? {'x': 0.0, 'y': 0.0}),
      title: data['title'] ?? '',
      uid: data['uid'] ?? '',
    );
  }

  // Add dummy factory method
  factory Lesson.dummy() {
    return Lesson(
      id: 0,
      isCompleted: false,
      isUnlocked: false,
      livello: '',
      nextLessonIds: [],
      position: Position(x: 0.0, y: 0.0),
      title: '',
      uid: '',
    );
  }
}

class Position {
  final double x;
  final double y;

  Position({required this.x, required this.y});

  factory Position.fromJson(Map<String, dynamic> json) {
    return Position(
      x: (json['x'] as num).toDouble(),
      y: (json['y'] as num).toDouble(),
    );
  }
}

class ColorModel {
  final int red;
  final int green;
  final int blue;

  ColorModel({required this.red, required this.green, required this.blue});

  factory ColorModel.fromJson(Map<String, dynamic> json) {
    return ColorModel(
      red: json['red'] ?? 0,
      green: json['green'] ?? 0,
      blue: json['blue'] ?? 0,
    );
  }

  Color toColor() => Color.fromRGBO(red, green, blue, 1.0);
}
