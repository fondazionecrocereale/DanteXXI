// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'article.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Article _$ArticleFromJson(Map<String, dynamic> json) {
  return _Article.fromJson(json);
}

/// @nodoc
mixin _$Article {
  String get id => throw _privateConstructorUsedError;
  String get teacherId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  String get excerpt => throw _privateConstructorUsedError;
  String get coverImageUrl => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  ArticleCategory get category => throw _privateConstructorUsedError;
  bool get isPublished => throw _privateConstructorUsedError;
  int get readTime => throw _privateConstructorUsedError; // En minutos
  int get views => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  int get comments => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  DateTime get publishedAt => throw _privateConstructorUsedError;
  String? get seoTitle => throw _privateConstructorUsedError;
  String? get seoDescription => throw _privateConstructorUsedError;
  List<String>? get images => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleCopyWith<Article> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCopyWith<$Res> {
  factory $ArticleCopyWith(Article value, $Res Function(Article) then) =
      _$ArticleCopyWithImpl<$Res, Article>;
  @useResult
  $Res call(
      {String id,
      String teacherId,
      String title,
      String content,
      String excerpt,
      String coverImageUrl,
      List<String> tags,
      ArticleCategory category,
      bool isPublished,
      int readTime,
      int views,
      int likes,
      int comments,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime publishedAt,
      String? seoTitle,
      String? seoDescription,
      List<String>? images});
}

/// @nodoc
class _$ArticleCopyWithImpl<$Res, $Val extends Article>
    implements $ArticleCopyWith<$Res> {
  _$ArticleCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teacherId = null,
    Object? title = null,
    Object? content = null,
    Object? excerpt = null,
    Object? coverImageUrl = null,
    Object? tags = null,
    Object? category = null,
    Object? isPublished = null,
    Object? readTime = null,
    Object? views = null,
    Object? likes = null,
    Object? comments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishedAt = null,
    Object? seoTitle = freezed,
    Object? seoDescription = freezed,
    Object? images = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      teacherId: null == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      excerpt: null == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrl: null == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ArticleCategory,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      readTime: null == readTime
          ? _value.readTime
          : readTime // ignore: cast_nullable_to_non_nullable
              as int,
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      seoTitle: freezed == seoTitle
          ? _value.seoTitle
          : seoTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      seoDescription: freezed == seoDescription
          ? _value.seoDescription
          : seoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArticleImplCopyWith<$Res> implements $ArticleCopyWith<$Res> {
  factory _$$ArticleImplCopyWith(
          _$ArticleImpl value, $Res Function(_$ArticleImpl) then) =
      __$$ArticleImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String teacherId,
      String title,
      String content,
      String excerpt,
      String coverImageUrl,
      List<String> tags,
      ArticleCategory category,
      bool isPublished,
      int readTime,
      int views,
      int likes,
      int comments,
      DateTime createdAt,
      DateTime updatedAt,
      DateTime publishedAt,
      String? seoTitle,
      String? seoDescription,
      List<String>? images});
}

/// @nodoc
class __$$ArticleImplCopyWithImpl<$Res>
    extends _$ArticleCopyWithImpl<$Res, _$ArticleImpl>
    implements _$$ArticleImplCopyWith<$Res> {
  __$$ArticleImplCopyWithImpl(
      _$ArticleImpl _value, $Res Function(_$ArticleImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teacherId = null,
    Object? title = null,
    Object? content = null,
    Object? excerpt = null,
    Object? coverImageUrl = null,
    Object? tags = null,
    Object? category = null,
    Object? isPublished = null,
    Object? readTime = null,
    Object? views = null,
    Object? likes = null,
    Object? comments = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? publishedAt = null,
    Object? seoTitle = freezed,
    Object? seoDescription = freezed,
    Object? images = freezed,
  }) {
    return _then(_$ArticleImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      teacherId: null == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      excerpt: null == excerpt
          ? _value.excerpt
          : excerpt // ignore: cast_nullable_to_non_nullable
              as String,
      coverImageUrl: null == coverImageUrl
          ? _value.coverImageUrl
          : coverImageUrl // ignore: cast_nullable_to_non_nullable
              as String,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as ArticleCategory,
      isPublished: null == isPublished
          ? _value.isPublished
          : isPublished // ignore: cast_nullable_to_non_nullable
              as bool,
      readTime: null == readTime
          ? _value.readTime
          : readTime // ignore: cast_nullable_to_non_nullable
              as int,
      views: null == views
          ? _value.views
          : views // ignore: cast_nullable_to_non_nullable
              as int,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as int,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      publishedAt: null == publishedAt
          ? _value.publishedAt
          : publishedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      seoTitle: freezed == seoTitle
          ? _value.seoTitle
          : seoTitle // ignore: cast_nullable_to_non_nullable
              as String?,
      seoDescription: freezed == seoDescription
          ? _value.seoDescription
          : seoDescription // ignore: cast_nullable_to_non_nullable
              as String?,
      images: freezed == images
          ? _value._images
          : images // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleImpl implements _Article {
  const _$ArticleImpl(
      {required this.id,
      required this.teacherId,
      required this.title,
      required this.content,
      required this.excerpt,
      required this.coverImageUrl,
      required final List<String> tags,
      required this.category,
      required this.isPublished,
      required this.readTime,
      required this.views,
      required this.likes,
      required this.comments,
      required this.createdAt,
      required this.updatedAt,
      required this.publishedAt,
      this.seoTitle,
      this.seoDescription,
      final List<String>? images})
      : _tags = tags,
        _images = images;

  factory _$ArticleImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleImplFromJson(json);

  @override
  final String id;
  @override
  final String teacherId;
  @override
  final String title;
  @override
  final String content;
  @override
  final String excerpt;
  @override
  final String coverImageUrl;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final ArticleCategory category;
  @override
  final bool isPublished;
  @override
  final int readTime;
// En minutos
  @override
  final int views;
  @override
  final int likes;
  @override
  final int comments;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final DateTime publishedAt;
  @override
  final String? seoTitle;
  @override
  final String? seoDescription;
  final List<String>? _images;
  @override
  List<String>? get images {
    final value = _images;
    if (value == null) return null;
    if (_images is EqualUnmodifiableListView) return _images;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Article(id: $id, teacherId: $teacherId, title: $title, content: $content, excerpt: $excerpt, coverImageUrl: $coverImageUrl, tags: $tags, category: $category, isPublished: $isPublished, readTime: $readTime, views: $views, likes: $likes, comments: $comments, createdAt: $createdAt, updatedAt: $updatedAt, publishedAt: $publishedAt, seoTitle: $seoTitle, seoDescription: $seoDescription, images: $images)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.excerpt, excerpt) || other.excerpt == excerpt) &&
            (identical(other.coverImageUrl, coverImageUrl) ||
                other.coverImageUrl == coverImageUrl) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.isPublished, isPublished) ||
                other.isPublished == isPublished) &&
            (identical(other.readTime, readTime) ||
                other.readTime == readTime) &&
            (identical(other.views, views) || other.views == views) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.comments, comments) ||
                other.comments == comments) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.publishedAt, publishedAt) ||
                other.publishedAt == publishedAt) &&
            (identical(other.seoTitle, seoTitle) ||
                other.seoTitle == seoTitle) &&
            (identical(other.seoDescription, seoDescription) ||
                other.seoDescription == seoDescription) &&
            const DeepCollectionEquality().equals(other._images, _images));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        teacherId,
        title,
        content,
        excerpt,
        coverImageUrl,
        const DeepCollectionEquality().hash(_tags),
        category,
        isPublished,
        readTime,
        views,
        likes,
        comments,
        createdAt,
        updatedAt,
        publishedAt,
        seoTitle,
        seoDescription,
        const DeepCollectionEquality().hash(_images)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      __$$ArticleImplCopyWithImpl<_$ArticleImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleImplToJson(
      this,
    );
  }
}

abstract class _Article implements Article {
  const factory _Article(
      {required final String id,
      required final String teacherId,
      required final String title,
      required final String content,
      required final String excerpt,
      required final String coverImageUrl,
      required final List<String> tags,
      required final ArticleCategory category,
      required final bool isPublished,
      required final int readTime,
      required final int views,
      required final int likes,
      required final int comments,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      required final DateTime publishedAt,
      final String? seoTitle,
      final String? seoDescription,
      final List<String>? images}) = _$ArticleImpl;

  factory _Article.fromJson(Map<String, dynamic> json) = _$ArticleImpl.fromJson;

  @override
  String get id;
  @override
  String get teacherId;
  @override
  String get title;
  @override
  String get content;
  @override
  String get excerpt;
  @override
  String get coverImageUrl;
  @override
  List<String> get tags;
  @override
  ArticleCategory get category;
  @override
  bool get isPublished;
  @override
  int get readTime;
  @override // En minutos
  int get views;
  @override
  int get likes;
  @override
  int get comments;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  DateTime get publishedAt;
  @override
  String? get seoTitle;
  @override
  String? get seoDescription;
  @override
  List<String>? get images;
  @override
  @JsonKey(ignore: true)
  _$$ArticleImplCopyWith<_$ArticleImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ArticleComment _$ArticleCommentFromJson(Map<String, dynamic> json) {
  return _ArticleComment.fromJson(json);
}

/// @nodoc
mixin _$ArticleComment {
  String get id => throw _privateConstructorUsedError;
  String get articleId => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get userName => throw _privateConstructorUsedError;
  String get userAvatar => throw _privateConstructorUsedError;
  String get content => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get parentId => throw _privateConstructorUsedError;
  int get likes => throw _privateConstructorUsedError;
  bool get isEdited => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ArticleCommentCopyWith<ArticleComment> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ArticleCommentCopyWith<$Res> {
  factory $ArticleCommentCopyWith(
          ArticleComment value, $Res Function(ArticleComment) then) =
      _$ArticleCommentCopyWithImpl<$Res, ArticleComment>;
  @useResult
  $Res call(
      {String id,
      String articleId,
      String userId,
      String userName,
      String userAvatar,
      String content,
      DateTime createdAt,
      DateTime updatedAt,
      String? parentId,
      int likes,
      bool isEdited});
}

/// @nodoc
class _$ArticleCommentCopyWithImpl<$Res, $Val extends ArticleComment>
    implements $ArticleCommentCopyWith<$Res> {
  _$ArticleCommentCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? articleId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? parentId = freezed,
    Object? likes = null,
    Object? isEdited = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      articleId: null == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: null == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ArticleCommentImplCopyWith<$Res>
    implements $ArticleCommentCopyWith<$Res> {
  factory _$$ArticleCommentImplCopyWith(_$ArticleCommentImpl value,
          $Res Function(_$ArticleCommentImpl) then) =
      __$$ArticleCommentImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String articleId,
      String userId,
      String userName,
      String userAvatar,
      String content,
      DateTime createdAt,
      DateTime updatedAt,
      String? parentId,
      int likes,
      bool isEdited});
}

/// @nodoc
class __$$ArticleCommentImplCopyWithImpl<$Res>
    extends _$ArticleCommentCopyWithImpl<$Res, _$ArticleCommentImpl>
    implements _$$ArticleCommentImplCopyWith<$Res> {
  __$$ArticleCommentImplCopyWithImpl(
      _$ArticleCommentImpl _value, $Res Function(_$ArticleCommentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? articleId = null,
    Object? userId = null,
    Object? userName = null,
    Object? userAvatar = null,
    Object? content = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? parentId = freezed,
    Object? likes = null,
    Object? isEdited = null,
  }) {
    return _then(_$ArticleCommentImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      articleId: null == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      userAvatar: null == userAvatar
          ? _value.userAvatar
          : userAvatar // ignore: cast_nullable_to_non_nullable
              as String,
      content: null == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as int,
      isEdited: null == isEdited
          ? _value.isEdited
          : isEdited // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ArticleCommentImpl implements _ArticleComment {
  const _$ArticleCommentImpl(
      {required this.id,
      required this.articleId,
      required this.userId,
      required this.userName,
      required this.userAvatar,
      required this.content,
      required this.createdAt,
      required this.updatedAt,
      this.parentId,
      required this.likes,
      required this.isEdited});

  factory _$ArticleCommentImpl.fromJson(Map<String, dynamic> json) =>
      _$$ArticleCommentImplFromJson(json);

  @override
  final String id;
  @override
  final String articleId;
  @override
  final String userId;
  @override
  final String userName;
  @override
  final String userAvatar;
  @override
  final String content;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? parentId;
  @override
  final int likes;
  @override
  final bool isEdited;

  @override
  String toString() {
    return 'ArticleComment(id: $id, articleId: $articleId, userId: $userId, userName: $userName, userAvatar: $userAvatar, content: $content, createdAt: $createdAt, updatedAt: $updatedAt, parentId: $parentId, likes: $likes, isEdited: $isEdited)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ArticleCommentImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.userAvatar, userAvatar) ||
                other.userAvatar == userAvatar) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.likes, likes) || other.likes == likes) &&
            (identical(other.isEdited, isEdited) ||
                other.isEdited == isEdited));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, articleId, userId, userName,
      userAvatar, content, createdAt, updatedAt, parentId, likes, isEdited);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ArticleCommentImplCopyWith<_$ArticleCommentImpl> get copyWith =>
      __$$ArticleCommentImplCopyWithImpl<_$ArticleCommentImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ArticleCommentImplToJson(
      this,
    );
  }
}

abstract class _ArticleComment implements ArticleComment {
  const factory _ArticleComment(
      {required final String id,
      required final String articleId,
      required final String userId,
      required final String userName,
      required final String userAvatar,
      required final String content,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? parentId,
      required final int likes,
      required final bool isEdited}) = _$ArticleCommentImpl;

  factory _ArticleComment.fromJson(Map<String, dynamic> json) =
      _$ArticleCommentImpl.fromJson;

  @override
  String get id;
  @override
  String get articleId;
  @override
  String get userId;
  @override
  String get userName;
  @override
  String get userAvatar;
  @override
  String get content;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get parentId;
  @override
  int get likes;
  @override
  bool get isEdited;
  @override
  @JsonKey(ignore: true)
  _$$ArticleCommentImplCopyWith<_$ArticleCommentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
