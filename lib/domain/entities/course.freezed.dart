// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'course.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Course _$CourseFromJson(Map<String, dynamic> json) {
  return _Course.fromJson(json);
}

/// @nodoc
mixin _$Course {
  String get id => throw _privateConstructorUsedError;
  String get teacherId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get thumbnailUrl => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  double get price => throw _privateConstructorUsedError; // En Fiorino
  bool get isFree => throw _privateConstructorUsedError;
  CourseLevel get level => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError; // En minutos
  int get totalLessons => throw _privateConstructorUsedError;
  int get completedLessons => throw _privateConstructorUsedError;
  double get rating => throw _privateConstructorUsedError;
  int get totalStudents => throw _privateConstructorUsedError;
  CourseStatus get status => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError;
  DateTime get updatedAt => throw _privateConstructorUsedError;
  String? get previewVideoUrl => throw _privateConstructorUsedError;
  List<String>? get prerequisites => throw _privateConstructorUsedError;
  String? get certificateUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseCopyWith<Course> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseCopyWith<$Res> {
  factory $CourseCopyWith(Course value, $Res Function(Course) then) =
      _$CourseCopyWithImpl<$Res, Course>;
  @useResult
  $Res call(
      {String id,
      String teacherId,
      String title,
      String description,
      String thumbnailUrl,
      String videoUrl,
      double price,
      bool isFree,
      CourseLevel level,
      List<String> tags,
      int duration,
      int totalLessons,
      int completedLessons,
      double rating,
      int totalStudents,
      CourseStatus status,
      DateTime createdAt,
      DateTime updatedAt,
      String? previewVideoUrl,
      List<String>? prerequisites,
      String? certificateUrl});
}

/// @nodoc
class _$CourseCopyWithImpl<$Res, $Val extends Course>
    implements $CourseCopyWith<$Res> {
  _$CourseCopyWithImpl(this._value, this._then);

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
    Object? description = null,
    Object? thumbnailUrl = null,
    Object? videoUrl = null,
    Object? price = null,
    Object? isFree = null,
    Object? level = null,
    Object? tags = null,
    Object? duration = null,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? rating = null,
    Object? totalStudents = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? previewVideoUrl = freezed,
    Object? prerequisites = freezed,
    Object? certificateUrl = freezed,
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as CourseLevel,
      tags: null == tags
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CourseStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      previewVideoUrl: freezed == previewVideoUrl
          ? _value.previewVideoUrl
          : previewVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      prerequisites: freezed == prerequisites
          ? _value.prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      certificateUrl: freezed == certificateUrl
          ? _value.certificateUrl
          : certificateUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseImplCopyWith<$Res> implements $CourseCopyWith<$Res> {
  factory _$$CourseImplCopyWith(
          _$CourseImpl value, $Res Function(_$CourseImpl) then) =
      __$$CourseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String teacherId,
      String title,
      String description,
      String thumbnailUrl,
      String videoUrl,
      double price,
      bool isFree,
      CourseLevel level,
      List<String> tags,
      int duration,
      int totalLessons,
      int completedLessons,
      double rating,
      int totalStudents,
      CourseStatus status,
      DateTime createdAt,
      DateTime updatedAt,
      String? previewVideoUrl,
      List<String>? prerequisites,
      String? certificateUrl});
}

/// @nodoc
class __$$CourseImplCopyWithImpl<$Res>
    extends _$CourseCopyWithImpl<$Res, _$CourseImpl>
    implements _$$CourseImplCopyWith<$Res> {
  __$$CourseImplCopyWithImpl(
      _$CourseImpl _value, $Res Function(_$CourseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? teacherId = null,
    Object? title = null,
    Object? description = null,
    Object? thumbnailUrl = null,
    Object? videoUrl = null,
    Object? price = null,
    Object? isFree = null,
    Object? level = null,
    Object? tags = null,
    Object? duration = null,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? rating = null,
    Object? totalStudents = null,
    Object? status = null,
    Object? createdAt = null,
    Object? updatedAt = null,
    Object? previewVideoUrl = freezed,
    Object? prerequisites = freezed,
    Object? certificateUrl = freezed,
  }) {
    return _then(_$CourseImpl(
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
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      thumbnailUrl: null == thumbnailUrl
          ? _value.thumbnailUrl
          : thumbnailUrl // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      price: null == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as double,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      level: null == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as CourseLevel,
      tags: null == tags
          ? _value._tags
          : tags // ignore: cast_nullable_to_non_nullable
              as List<String>,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      rating: null == rating
          ? _value.rating
          : rating // ignore: cast_nullable_to_non_nullable
              as double,
      totalStudents: null == totalStudents
          ? _value.totalStudents
          : totalStudents // ignore: cast_nullable_to_non_nullable
              as int,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as CourseStatus,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      previewVideoUrl: freezed == previewVideoUrl
          ? _value.previewVideoUrl
          : previewVideoUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      prerequisites: freezed == prerequisites
          ? _value._prerequisites
          : prerequisites // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      certificateUrl: freezed == certificateUrl
          ? _value.certificateUrl
          : certificateUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseImpl implements _Course {
  const _$CourseImpl(
      {required this.id,
      required this.teacherId,
      required this.title,
      required this.description,
      required this.thumbnailUrl,
      required this.videoUrl,
      required this.price,
      required this.isFree,
      required this.level,
      required final List<String> tags,
      required this.duration,
      required this.totalLessons,
      required this.completedLessons,
      required this.rating,
      required this.totalStudents,
      required this.status,
      required this.createdAt,
      required this.updatedAt,
      this.previewVideoUrl,
      final List<String>? prerequisites,
      this.certificateUrl})
      : _tags = tags,
        _prerequisites = prerequisites;

  factory _$CourseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseImplFromJson(json);

  @override
  final String id;
  @override
  final String teacherId;
  @override
  final String title;
  @override
  final String description;
  @override
  final String thumbnailUrl;
  @override
  final String videoUrl;
  @override
  final double price;
// En Fiorino
  @override
  final bool isFree;
  @override
  final CourseLevel level;
  final List<String> _tags;
  @override
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  @override
  final int duration;
// En minutos
  @override
  final int totalLessons;
  @override
  final int completedLessons;
  @override
  final double rating;
  @override
  final int totalStudents;
  @override
  final CourseStatus status;
  @override
  final DateTime createdAt;
  @override
  final DateTime updatedAt;
  @override
  final String? previewVideoUrl;
  final List<String>? _prerequisites;
  @override
  List<String>? get prerequisites {
    final value = _prerequisites;
    if (value == null) return null;
    if (_prerequisites is EqualUnmodifiableListView) return _prerequisites;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? certificateUrl;

  @override
  String toString() {
    return 'Course(id: $id, teacherId: $teacherId, title: $title, description: $description, thumbnailUrl: $thumbnailUrl, videoUrl: $videoUrl, price: $price, isFree: $isFree, level: $level, tags: $tags, duration: $duration, totalLessons: $totalLessons, completedLessons: $completedLessons, rating: $rating, totalStudents: $totalStudents, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, previewVideoUrl: $previewVideoUrl, prerequisites: $prerequisites, certificateUrl: $certificateUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.thumbnailUrl, thumbnailUrl) ||
                other.thumbnailUrl == thumbnailUrl) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.level, level) || other.level == level) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.totalLessons, totalLessons) ||
                other.totalLessons == totalLessons) &&
            (identical(other.completedLessons, completedLessons) ||
                other.completedLessons == completedLessons) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.totalStudents, totalStudents) ||
                other.totalStudents == totalStudents) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt) &&
            (identical(other.previewVideoUrl, previewVideoUrl) ||
                other.previewVideoUrl == previewVideoUrl) &&
            const DeepCollectionEquality()
                .equals(other._prerequisites, _prerequisites) &&
            (identical(other.certificateUrl, certificateUrl) ||
                other.certificateUrl == certificateUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        teacherId,
        title,
        description,
        thumbnailUrl,
        videoUrl,
        price,
        isFree,
        level,
        const DeepCollectionEquality().hash(_tags),
        duration,
        totalLessons,
        completedLessons,
        rating,
        totalStudents,
        status,
        createdAt,
        updatedAt,
        previewVideoUrl,
        const DeepCollectionEquality().hash(_prerequisites),
        certificateUrl
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      __$$CourseImplCopyWithImpl<_$CourseImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseImplToJson(
      this,
    );
  }
}

abstract class _Course implements Course {
  const factory _Course(
      {required final String id,
      required final String teacherId,
      required final String title,
      required final String description,
      required final String thumbnailUrl,
      required final String videoUrl,
      required final double price,
      required final bool isFree,
      required final CourseLevel level,
      required final List<String> tags,
      required final int duration,
      required final int totalLessons,
      required final int completedLessons,
      required final double rating,
      required final int totalStudents,
      required final CourseStatus status,
      required final DateTime createdAt,
      required final DateTime updatedAt,
      final String? previewVideoUrl,
      final List<String>? prerequisites,
      final String? certificateUrl}) = _$CourseImpl;

  factory _Course.fromJson(Map<String, dynamic> json) = _$CourseImpl.fromJson;

  @override
  String get id;
  @override
  String get teacherId;
  @override
  String get title;
  @override
  String get description;
  @override
  String get thumbnailUrl;
  @override
  String get videoUrl;
  @override
  double get price;
  @override // En Fiorino
  bool get isFree;
  @override
  CourseLevel get level;
  @override
  List<String> get tags;
  @override
  int get duration;
  @override // En minutos
  int get totalLessons;
  @override
  int get completedLessons;
  @override
  double get rating;
  @override
  int get totalStudents;
  @override
  CourseStatus get status;
  @override
  DateTime get createdAt;
  @override
  DateTime get updatedAt;
  @override
  String? get previewVideoUrl;
  @override
  List<String>? get prerequisites;
  @override
  String? get certificateUrl;
  @override
  @JsonKey(ignore: true)
  _$$CourseImplCopyWith<_$CourseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CourseLesson _$CourseLessonFromJson(Map<String, dynamic> json) {
  return _CourseLesson.fromJson(json);
}

/// @nodoc
mixin _$CourseLesson {
  String get id => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get videoUrl => throw _privateConstructorUsedError;
  int get duration => throw _privateConstructorUsedError; // En minutos
  int get order => throw _privateConstructorUsedError;
  bool get isFree => throw _privateConstructorUsedError;
  bool get isCompleted => throw _privateConstructorUsedError;
  String? get transcript => throw _privateConstructorUsedError;
  List<String>? get resources => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CourseLessonCopyWith<CourseLesson> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CourseLessonCopyWith<$Res> {
  factory $CourseLessonCopyWith(
          CourseLesson value, $Res Function(CourseLesson) then) =
      _$CourseLessonCopyWithImpl<$Res, CourseLesson>;
  @useResult
  $Res call(
      {String id,
      String courseId,
      String title,
      String description,
      String videoUrl,
      int duration,
      int order,
      bool isFree,
      bool isCompleted,
      String? transcript,
      List<String>? resources});
}

/// @nodoc
class _$CourseLessonCopyWithImpl<$Res, $Val extends CourseLesson>
    implements $CourseLessonCopyWith<$Res> {
  _$CourseLessonCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? title = null,
    Object? description = null,
    Object? videoUrl = null,
    Object? duration = null,
    Object? order = null,
    Object? isFree = null,
    Object? isCompleted = null,
    Object? transcript = freezed,
    Object? resources = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      transcript: freezed == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value.resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CourseLessonImplCopyWith<$Res>
    implements $CourseLessonCopyWith<$Res> {
  factory _$$CourseLessonImplCopyWith(
          _$CourseLessonImpl value, $Res Function(_$CourseLessonImpl) then) =
      __$$CourseLessonImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String courseId,
      String title,
      String description,
      String videoUrl,
      int duration,
      int order,
      bool isFree,
      bool isCompleted,
      String? transcript,
      List<String>? resources});
}

/// @nodoc
class __$$CourseLessonImplCopyWithImpl<$Res>
    extends _$CourseLessonCopyWithImpl<$Res, _$CourseLessonImpl>
    implements _$$CourseLessonImplCopyWith<$Res> {
  __$$CourseLessonImplCopyWithImpl(
      _$CourseLessonImpl _value, $Res Function(_$CourseLessonImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? courseId = null,
    Object? title = null,
    Object? description = null,
    Object? videoUrl = null,
    Object? duration = null,
    Object? order = null,
    Object? isFree = null,
    Object? isCompleted = null,
    Object? transcript = freezed,
    Object? resources = freezed,
  }) {
    return _then(_$CourseLessonImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      videoUrl: null == videoUrl
          ? _value.videoUrl
          : videoUrl // ignore: cast_nullable_to_non_nullable
              as String,
      duration: null == duration
          ? _value.duration
          : duration // ignore: cast_nullable_to_non_nullable
              as int,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as int,
      isFree: null == isFree
          ? _value.isFree
          : isFree // ignore: cast_nullable_to_non_nullable
              as bool,
      isCompleted: null == isCompleted
          ? _value.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      transcript: freezed == transcript
          ? _value.transcript
          : transcript // ignore: cast_nullable_to_non_nullable
              as String?,
      resources: freezed == resources
          ? _value._resources
          : resources // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CourseLessonImpl implements _CourseLesson {
  const _$CourseLessonImpl(
      {required this.id,
      required this.courseId,
      required this.title,
      required this.description,
      required this.videoUrl,
      required this.duration,
      required this.order,
      required this.isFree,
      required this.isCompleted,
      this.transcript,
      final List<String>? resources})
      : _resources = resources;

  factory _$CourseLessonImpl.fromJson(Map<String, dynamic> json) =>
      _$$CourseLessonImplFromJson(json);

  @override
  final String id;
  @override
  final String courseId;
  @override
  final String title;
  @override
  final String description;
  @override
  final String videoUrl;
  @override
  final int duration;
// En minutos
  @override
  final int order;
  @override
  final bool isFree;
  @override
  final bool isCompleted;
  @override
  final String? transcript;
  final List<String>? _resources;
  @override
  List<String>? get resources {
    final value = _resources;
    if (value == null) return null;
    if (_resources is EqualUnmodifiableListView) return _resources;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'CourseLesson(id: $id, courseId: $courseId, title: $title, description: $description, videoUrl: $videoUrl, duration: $duration, order: $order, isFree: $isFree, isCompleted: $isCompleted, transcript: $transcript, resources: $resources)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CourseLessonImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.videoUrl, videoUrl) ||
                other.videoUrl == videoUrl) &&
            (identical(other.duration, duration) ||
                other.duration == duration) &&
            (identical(other.order, order) || other.order == order) &&
            (identical(other.isFree, isFree) || other.isFree == isFree) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.transcript, transcript) ||
                other.transcript == transcript) &&
            const DeepCollectionEquality()
                .equals(other._resources, _resources));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      courseId,
      title,
      description,
      videoUrl,
      duration,
      order,
      isFree,
      isCompleted,
      transcript,
      const DeepCollectionEquality().hash(_resources));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CourseLessonImplCopyWith<_$CourseLessonImpl> get copyWith =>
      __$$CourseLessonImplCopyWithImpl<_$CourseLessonImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CourseLessonImplToJson(
      this,
    );
  }
}

abstract class _CourseLesson implements CourseLesson {
  const factory _CourseLesson(
      {required final String id,
      required final String courseId,
      required final String title,
      required final String description,
      required final String videoUrl,
      required final int duration,
      required final int order,
      required final bool isFree,
      required final bool isCompleted,
      final String? transcript,
      final List<String>? resources}) = _$CourseLessonImpl;

  factory _CourseLesson.fromJson(Map<String, dynamic> json) =
      _$CourseLessonImpl.fromJson;

  @override
  String get id;
  @override
  String get courseId;
  @override
  String get title;
  @override
  String get description;
  @override
  String get videoUrl;
  @override
  int get duration;
  @override // En minutos
  int get order;
  @override
  bool get isFree;
  @override
  bool get isCompleted;
  @override
  String? get transcript;
  @override
  List<String>? get resources;
  @override
  @JsonKey(ignore: true)
  _$$CourseLessonImplCopyWith<_$CourseLessonImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

CoursePurchase _$CoursePurchaseFromJson(Map<String, dynamic> json) {
  return _CoursePurchase.fromJson(json);
}

/// @nodoc
mixin _$CoursePurchase {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get courseId => throw _privateConstructorUsedError;
  String get teacherId => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError; // En Fiorino
  PurchaseStatus get status => throw _privateConstructorUsedError;
  DateTime get purchaseDate => throw _privateConstructorUsedError;
  DateTime get accessExpiry => throw _privateConstructorUsedError;
  String? get transactionHash => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CoursePurchaseCopyWith<CoursePurchase> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CoursePurchaseCopyWith<$Res> {
  factory $CoursePurchaseCopyWith(
          CoursePurchase value, $Res Function(CoursePurchase) then) =
      _$CoursePurchaseCopyWithImpl<$Res, CoursePurchase>;
  @useResult
  $Res call(
      {String id,
      String userId,
      String courseId,
      String teacherId,
      double amount,
      PurchaseStatus status,
      DateTime purchaseDate,
      DateTime accessExpiry,
      String? transactionHash});
}

/// @nodoc
class _$CoursePurchaseCopyWithImpl<$Res, $Val extends CoursePurchase>
    implements $CoursePurchaseCopyWith<$Res> {
  _$CoursePurchaseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? courseId = null,
    Object? teacherId = null,
    Object? amount = null,
    Object? status = null,
    Object? purchaseDate = null,
    Object? accessExpiry = null,
    Object? transactionHash = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      teacherId: null == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accessExpiry: null == accessExpiry
          ? _value.accessExpiry
          : accessExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionHash: freezed == transactionHash
          ? _value.transactionHash
          : transactionHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CoursePurchaseImplCopyWith<$Res>
    implements $CoursePurchaseCopyWith<$Res> {
  factory _$$CoursePurchaseImplCopyWith(_$CoursePurchaseImpl value,
          $Res Function(_$CoursePurchaseImpl) then) =
      __$$CoursePurchaseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String userId,
      String courseId,
      String teacherId,
      double amount,
      PurchaseStatus status,
      DateTime purchaseDate,
      DateTime accessExpiry,
      String? transactionHash});
}

/// @nodoc
class __$$CoursePurchaseImplCopyWithImpl<$Res>
    extends _$CoursePurchaseCopyWithImpl<$Res, _$CoursePurchaseImpl>
    implements _$$CoursePurchaseImplCopyWith<$Res> {
  __$$CoursePurchaseImplCopyWithImpl(
      _$CoursePurchaseImpl _value, $Res Function(_$CoursePurchaseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? courseId = null,
    Object? teacherId = null,
    Object? amount = null,
    Object? status = null,
    Object? purchaseDate = null,
    Object? accessExpiry = null,
    Object? transactionHash = freezed,
  }) {
    return _then(_$CoursePurchaseImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _value.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      teacherId: null == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as PurchaseStatus,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      accessExpiry: null == accessExpiry
          ? _value.accessExpiry
          : accessExpiry // ignore: cast_nullable_to_non_nullable
              as DateTime,
      transactionHash: freezed == transactionHash
          ? _value.transactionHash
          : transactionHash // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CoursePurchaseImpl implements _CoursePurchase {
  const _$CoursePurchaseImpl(
      {required this.id,
      required this.userId,
      required this.courseId,
      required this.teacherId,
      required this.amount,
      required this.status,
      required this.purchaseDate,
      required this.accessExpiry,
      this.transactionHash});

  factory _$CoursePurchaseImpl.fromJson(Map<String, dynamic> json) =>
      _$$CoursePurchaseImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String courseId;
  @override
  final String teacherId;
  @override
  final double amount;
// En Fiorino
  @override
  final PurchaseStatus status;
  @override
  final DateTime purchaseDate;
  @override
  final DateTime accessExpiry;
  @override
  final String? transactionHash;

  @override
  String toString() {
    return 'CoursePurchase(id: $id, userId: $userId, courseId: $courseId, teacherId: $teacherId, amount: $amount, status: $status, purchaseDate: $purchaseDate, accessExpiry: $accessExpiry, transactionHash: $transactionHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CoursePurchaseImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate) &&
            (identical(other.accessExpiry, accessExpiry) ||
                other.accessExpiry == accessExpiry) &&
            (identical(other.transactionHash, transactionHash) ||
                other.transactionHash == transactionHash));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, userId, courseId, teacherId,
      amount, status, purchaseDate, accessExpiry, transactionHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CoursePurchaseImplCopyWith<_$CoursePurchaseImpl> get copyWith =>
      __$$CoursePurchaseImplCopyWithImpl<_$CoursePurchaseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CoursePurchaseImplToJson(
      this,
    );
  }
}

abstract class _CoursePurchase implements CoursePurchase {
  const factory _CoursePurchase(
      {required final String id,
      required final String userId,
      required final String courseId,
      required final String teacherId,
      required final double amount,
      required final PurchaseStatus status,
      required final DateTime purchaseDate,
      required final DateTime accessExpiry,
      final String? transactionHash}) = _$CoursePurchaseImpl;

  factory _CoursePurchase.fromJson(Map<String, dynamic> json) =
      _$CoursePurchaseImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get courseId;
  @override
  String get teacherId;
  @override
  double get amount;
  @override // En Fiorino
  PurchaseStatus get status;
  @override
  DateTime get purchaseDate;
  @override
  DateTime get accessExpiry;
  @override
  String? get transactionHash;
  @override
  @JsonKey(ignore: true)
  _$$CoursePurchaseImplCopyWith<_$CoursePurchaseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
