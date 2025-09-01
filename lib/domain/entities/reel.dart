import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'reel.freezed.dart';
part 'reel.g.dart';

@freezed
class Reel with _$Reel {
  const factory Reel({
    required int id,
    required String author,
    required String category,
    required String chiave,
    required String chiaveTranslation,
    required String chiaveTranslationEN,
    required String chiaveTranslationPR,
    required String description,
    required String image,
    required String lingua,
    required String livello,
    required String name,
    required List<Subtitle> subtitles,
    required String url,
    required int views,
    required bool visible,
    required DateTime createdAt,
  }) = _Reel;

  factory Reel.fromJson(Map<String, dynamic> json) {
    // Parsear subtítulos desde string JSON
    List<Subtitle> parsedSubtitles = [];
    if (json['subtitles'] is String) {
      try {
        final subtitlesJson = jsonDecode(json['subtitles'] as String);
        parsedSubtitles = (subtitlesJson as List)
            .map((subtitle) => Subtitle.fromJson(subtitle))
            .toList();
      } catch (e) {
        print('❌ Error al parsear subtítulos: $e');
        parsedSubtitles = [];
      }
    } else if (json['subtitles'] is List) {
      parsedSubtitles = (json['subtitles'] as List)
          .map((subtitle) => Subtitle.fromJson(subtitle))
          .toList();
    }

    return Reel(
      id: json['id'] ?? json['idx'] ?? 0,
      author: json['author'] ?? '',
      category: json['category'] ?? '',
      chiave: json['chiave'] ?? '',
      chiaveTranslation:
          json['chiave_translation'] ?? json['chiaveTranslation'] ?? '',
      chiaveTranslationEN:
          json['chiave_translation_en'] ?? json['chiaveTranslationEN'] ?? '',
      chiaveTranslationPR:
          json['chiave_translation_pr'] ?? json['chiaveTranslationPR'] ?? '',
      description: json['description'] ?? '',
      image: json['image'] ?? '',
      lingua: json['lingua'] ?? '',
      livello: json['livello'] ?? '',
      name: json['name'] ?? '',
      subtitles: parsedSubtitles,
      url: json['url'] ?? '',
      views: json['views'] ?? 0,
      visible: json['visible'] ?? true,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
    );
  }
}

@freezed
class Subtitle with _$Subtitle {
  const factory Subtitle({
    required String endTime,
    required bool isWordKey,
    required String startTime,
    required String text,
    required String translation,
    required String translationEN,
    required String translationPR,
  }) = _Subtitle;

  factory Subtitle.fromJson(Map<String, dynamic> json) =>
      _$SubtitleFromJson(json);
}
