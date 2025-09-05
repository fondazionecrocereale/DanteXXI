// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ArticleImpl _$$ArticleImplFromJson(Map<String, dynamic> json) =>
    _$ArticleImpl(
      id: json['id'] as String,
      teacherId: json['teacherId'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      excerpt: json['excerpt'] as String,
      coverImageUrl: json['coverImageUrl'] as String,
      tags: (json['tags'] as List<dynamic>).map((e) => e as String).toList(),
      category: $enumDecode(_$ArticleCategoryEnumMap, json['category']),
      isPublished: json['isPublished'] as bool,
      readTime: (json['readTime'] as num).toInt(),
      views: (json['views'] as num).toInt(),
      likes: (json['likes'] as num).toInt(),
      comments: (json['comments'] as num).toInt(),
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      publishedAt: DateTime.parse(json['publishedAt'] as String),
      seoTitle: json['seoTitle'] as String?,
      seoDescription: json['seoDescription'] as String?,
      images:
          (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$ArticleImplToJson(_$ArticleImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'teacherId': instance.teacherId,
      'title': instance.title,
      'content': instance.content,
      'excerpt': instance.excerpt,
      'coverImageUrl': instance.coverImageUrl,
      'tags': instance.tags,
      'category': _$ArticleCategoryEnumMap[instance.category]!,
      'isPublished': instance.isPublished,
      'readTime': instance.readTime,
      'views': instance.views,
      'likes': instance.likes,
      'comments': instance.comments,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'publishedAt': instance.publishedAt.toIso8601String(),
      'seoTitle': instance.seoTitle,
      'seoDescription': instance.seoDescription,
      'images': instance.images,
    };

const _$ArticleCategoryEnumMap = {
  ArticleCategory.grammar: 'grammar',
  ArticleCategory.vocabulary: 'vocabulary',
  ArticleCategory.culture: 'culture',
  ArticleCategory.pronunciation: 'pronunciation',
  ArticleCategory.tips: 'tips',
  ArticleCategory.news: 'news',
  ArticleCategory.lifestyle: 'lifestyle',
  ArticleCategory.travel: 'travel',
  ArticleCategory.business: 'business',
  ArticleCategory.other: 'other',
};

_$ArticleCommentImpl _$$ArticleCommentImplFromJson(Map<String, dynamic> json) =>
    _$ArticleCommentImpl(
      id: json['id'] as String,
      articleId: json['articleId'] as String,
      userId: json['userId'] as String,
      userName: json['userName'] as String,
      userAvatar: json['userAvatar'] as String,
      content: json['content'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      parentId: json['parentId'] as String?,
      likes: (json['likes'] as num).toInt(),
      isEdited: json['isEdited'] as bool,
    );

Map<String, dynamic> _$$ArticleCommentImplToJson(
        _$ArticleCommentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'articleId': instance.articleId,
      'userId': instance.userId,
      'userName': instance.userName,
      'userAvatar': instance.userAvatar,
      'content': instance.content,
      'createdAt': instance.createdAt.toIso8601String(),
      'updatedAt': instance.updatedAt.toIso8601String(),
      'parentId': instance.parentId,
      'likes': instance.likes,
      'isEdited': instance.isEdited,
    };
