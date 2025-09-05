import 'package:freezed_annotation/freezed_annotation.dart';

part 'article.freezed.dart';
part 'article.g.dart';

@freezed
class Article with _$Article {
  const factory Article({
    required String id,
    required String teacherId,
    required String title,
    required String content,
    required String excerpt,
    required String coverImageUrl,
    required List<String> tags,
    required ArticleCategory category,
    required bool isPublished,
    required int readTime, // En minutos
    required int views,
    required int likes,
    required int comments,
    required DateTime createdAt,
    required DateTime updatedAt,
    required DateTime publishedAt,
    String? seoTitle,
    String? seoDescription,
    List<String>? images,
  }) = _Article;

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);
}

@freezed
class ArticleComment with _$ArticleComment {
  const factory ArticleComment({
    required String id,
    required String articleId,
    required String userId,
    required String userName,
    required String userAvatar,
    required String content,
    required DateTime createdAt,
    required DateTime updatedAt,
    String? parentId,
    required int likes,
    required bool isEdited,
  }) = _ArticleComment;

  factory ArticleComment.fromJson(Map<String, dynamic> json) =>
      _$ArticleCommentFromJson(json);
}

enum ArticleCategory {
  grammar,
  vocabulary,
  culture,
  pronunciation,
  tips,
  news,
  lifestyle,
  travel,
  business,
  other,
}
