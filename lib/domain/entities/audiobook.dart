class Audiobook {
  final String id;
  final String title;
  final String author;
  final String description;
  final String coverImage;
  final String audioUrl;
  final Duration duration;
  final String level;
  final List<AudioChapter> chapters;
  final bool isBookmarked;
  final double progress;

  const Audiobook({
    required this.id,
    required this.title,
    required this.author,
    required this.description,
    required this.coverImage,
    required this.audioUrl,
    required this.duration,
    required this.level,
    required this.chapters,
    required this.isBookmarked,
    required this.progress,
  });

  Audiobook copyWith({
    String? id,
    String? title,
    String? author,
    String? description,
    String? coverImage,
    String? audioUrl,
    Duration? duration,
    String? level,
    List<AudioChapter>? chapters,
    bool? isBookmarked,
    double? progress,
  }) {
    return Audiobook(
      id: id ?? this.id,
      title: title ?? this.title,
      author: author ?? this.author,
      description: description ?? this.description,
      coverImage: coverImage ?? this.coverImage,
      audioUrl: audioUrl ?? this.audioUrl,
      duration: duration ?? this.duration,
      level: level ?? this.level,
      chapters: chapters ?? this.chapters,
      isBookmarked: isBookmarked ?? this.isBookmarked,
      progress: progress ?? this.progress,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'author': author,
      'description': description,
      'coverImage': coverImage,
      'audioUrl': audioUrl,
      'duration': duration.inMinutes,
      'level': level,
      'chapters': chapters.map((c) => c.toJson()).toList(),
      'isBookmarked': isBookmarked,
      'progress': progress,
    };
  }

  factory Audiobook.fromJson(Map<String, dynamic> json) {
    return Audiobook(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      author: json['author'] ?? '',
      description: json['description'] ?? '',
      coverImage: json['coverImage'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      duration: Duration(minutes: json['duration'] ?? 0),
      level: json['level'] ?? '',
      chapters:
          (json['chapters'] as List<dynamic>?)
              ?.map((c) => AudioChapter.fromJson(c))
              .toList() ??
          [],
      isBookmarked: json['isBookmarked'] ?? false,
      progress: (json['progress'] ?? 0.0).toDouble(),
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Audiobook && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'Audiobook(id: $id, title: $title, author: $author)';
  }
}

class AudioChapter {
  final String id;
  final String title;
  final Duration duration;
  final List<AudioSubtitle> subtitles;

  const AudioChapter({
    required this.id,
    required this.title,
    required this.duration,
    required this.subtitles,
  });

  AudioChapter copyWith({
    String? id,
    String? title,
    Duration? duration,
    List<AudioSubtitle>? subtitles,
  }) {
    return AudioChapter(
      id: id ?? this.id,
      title: title ?? this.title,
      duration: duration ?? this.duration,
      subtitles: subtitles ?? this.subtitles,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'duration': duration.inMinutes,
      'subtitles': subtitles.map((s) => s.toJson()).toList(),
    };
  }

  factory AudioChapter.fromJson(Map<String, dynamic> json) {
    return AudioChapter(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      duration: Duration(minutes: json['duration'] ?? 0),
      subtitles:
          (json['subtitles'] as List<dynamic>?)
              ?.map((s) => AudioSubtitle.fromJson(s))
              .toList() ??
          [],
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AudioChapter && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;

  @override
  String toString() {
    return 'AudioChapter(id: $id, title: $title, duration: $duration)';
  }
}

class AudioSubtitle {
  final String text;
  final String startTime;
  final String endTime;
  final String translation;
  final String translationEN;
  final String translationPR;
  final bool isWordKey;

  const AudioSubtitle({
    required this.text,
    required this.startTime,
    required this.endTime,
    required this.translation,
    required this.translationEN,
    required this.translationPR,
    required this.isWordKey,
  });

  AudioSubtitle copyWith({
    String? text,
    String? startTime,
    String? endTime,
    String? translation,
    String? translationEN,
    String? translationPR,
    bool? isWordKey,
  }) {
    return AudioSubtitle(
      text: text ?? this.text,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      translation: translation ?? this.translation,
      translationEN: translationEN ?? this.translationEN,
      translationPR: translationPR ?? this.translationPR,
      isWordKey: isWordKey ?? this.isWordKey,
    );
  }

  // Convertir tiempo de formato "HH:MM:SS.ms" a segundos
  double get startTimeInSeconds {
    return _parseTimeString(startTime);
  }

  double get endTimeInSeconds {
    return _parseTimeString(endTime);
  }

  double _parseTimeString(String timeString) {
    try {
      final parts = timeString.split(':');
      if (parts.length == 3) {
        final hours = int.parse(parts[0]);
        final minutes = int.parse(parts[1]);
        final seconds = double.parse(parts[2]);
        return hours * 3600 + minutes * 60 + seconds;
      }
      return 0.0;
    } catch (e) {
      return 0.0;
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'startTime': startTime,
      'endTime': endTime,
      'translation': translation,
      'translationEN': translationEN,
      'translationPR': translationPR,
      'isWordKey': isWordKey,
    };
  }

  factory AudioSubtitle.fromJson(Map<String, dynamic> json) {
    return AudioSubtitle(
      text: json['text'] ?? '',
      startTime: json['startTime'] ?? '00:00:00.000',
      endTime: json['endTime'] ?? '00:00:00.000',
      translation: json['translation'] ?? '',
      translationEN: json['translationEN'] ?? '',
      translationPR: json['translationPR'] ?? '',
      isWordKey: json['isWordKey'] ?? false,
    );
  }
}
