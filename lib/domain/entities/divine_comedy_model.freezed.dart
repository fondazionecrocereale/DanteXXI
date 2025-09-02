// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'divine_comedy_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

DivineComedyModel _$DivineComedyModelFromJson(Map<String, dynamic> json) {
  return _DivineComedyModel.fromJson(json);
}

/// @nodoc
mixin _$DivineComedyModel {
  String get title => throw _privateConstructorUsedError;
  List<String> get cefrRange => throw _privateConstructorUsedError;
  ColorModel get baseColor => throw _privateConstructorUsedError;
  ColorModel get textColor => throw _privateConstructorUsedError;
  ColorModel get cardColor => throw _privateConstructorUsedError;
  String get backgroundImage => throw _privateConstructorUsedError;
  List<Lesson> get lessons => throw _privateConstructorUsedError;
  int get totalLessons => throw _privateConstructorUsedError;
  int get completedLessons => throw _privateConstructorUsedError;
  double get progressPercentage => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DivineComedyModelCopyWith<DivineComedyModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DivineComedyModelCopyWith<$Res> {
  factory $DivineComedyModelCopyWith(
          DivineComedyModel value, $Res Function(DivineComedyModel) then) =
      _$DivineComedyModelCopyWithImpl<$Res, DivineComedyModel>;
  @useResult
  $Res call(
      {String title,
      List<String> cefrRange,
      ColorModel baseColor,
      ColorModel textColor,
      ColorModel cardColor,
      String backgroundImage,
      List<Lesson> lessons,
      int totalLessons,
      int completedLessons,
      double progressPercentage});

  $ColorModelCopyWith<$Res> get baseColor;
  $ColorModelCopyWith<$Res> get textColor;
  $ColorModelCopyWith<$Res> get cardColor;
}

/// @nodoc
class _$DivineComedyModelCopyWithImpl<$Res, $Val extends DivineComedyModel>
    implements $DivineComedyModelCopyWith<$Res> {
  _$DivineComedyModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? cefrRange = null,
    Object? baseColor = null,
    Object? textColor = null,
    Object? cardColor = null,
    Object? backgroundImage = null,
    Object? lessons = null,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? progressPercentage = null,
  }) {
    return _then(_value.copyWith(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      cefrRange: null == cefrRange
          ? _value.cefrRange
          : cefrRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      baseColor: null == baseColor
          ? _value.baseColor
          : baseColor // ignore: cast_nullable_to_non_nullable
              as ColorModel,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as ColorModel,
      cardColor: null == cardColor
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as ColorModel,
      backgroundImage: null == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String,
      lessons: null == lessons
          ? _value.lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<Lesson>,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ColorModelCopyWith<$Res> get baseColor {
    return $ColorModelCopyWith<$Res>(_value.baseColor, (value) {
      return _then(_value.copyWith(baseColor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ColorModelCopyWith<$Res> get textColor {
    return $ColorModelCopyWith<$Res>(_value.textColor, (value) {
      return _then(_value.copyWith(textColor: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ColorModelCopyWith<$Res> get cardColor {
    return $ColorModelCopyWith<$Res>(_value.cardColor, (value) {
      return _then(_value.copyWith(cardColor: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$DivineComedyModelImplCopyWith<$Res>
    implements $DivineComedyModelCopyWith<$Res> {
  factory _$$DivineComedyModelImplCopyWith(_$DivineComedyModelImpl value,
          $Res Function(_$DivineComedyModelImpl) then) =
      __$$DivineComedyModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String title,
      List<String> cefrRange,
      ColorModel baseColor,
      ColorModel textColor,
      ColorModel cardColor,
      String backgroundImage,
      List<Lesson> lessons,
      int totalLessons,
      int completedLessons,
      double progressPercentage});

  @override
  $ColorModelCopyWith<$Res> get baseColor;
  @override
  $ColorModelCopyWith<$Res> get textColor;
  @override
  $ColorModelCopyWith<$Res> get cardColor;
}

/// @nodoc
class __$$DivineComedyModelImplCopyWithImpl<$Res>
    extends _$DivineComedyModelCopyWithImpl<$Res, _$DivineComedyModelImpl>
    implements _$$DivineComedyModelImplCopyWith<$Res> {
  __$$DivineComedyModelImplCopyWithImpl(_$DivineComedyModelImpl _value,
      $Res Function(_$DivineComedyModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? title = null,
    Object? cefrRange = null,
    Object? baseColor = null,
    Object? textColor = null,
    Object? cardColor = null,
    Object? backgroundImage = null,
    Object? lessons = null,
    Object? totalLessons = null,
    Object? completedLessons = null,
    Object? progressPercentage = null,
  }) {
    return _then(_$DivineComedyModelImpl(
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      cefrRange: null == cefrRange
          ? _value._cefrRange
          : cefrRange // ignore: cast_nullable_to_non_nullable
              as List<String>,
      baseColor: null == baseColor
          ? _value.baseColor
          : baseColor // ignore: cast_nullable_to_non_nullable
              as ColorModel,
      textColor: null == textColor
          ? _value.textColor
          : textColor // ignore: cast_nullable_to_non_nullable
              as ColorModel,
      cardColor: null == cardColor
          ? _value.cardColor
          : cardColor // ignore: cast_nullable_to_non_nullable
              as ColorModel,
      backgroundImage: null == backgroundImage
          ? _value.backgroundImage
          : backgroundImage // ignore: cast_nullable_to_non_nullable
              as String,
      lessons: null == lessons
          ? _value._lessons
          : lessons // ignore: cast_nullable_to_non_nullable
              as List<Lesson>,
      totalLessons: null == totalLessons
          ? _value.totalLessons
          : totalLessons // ignore: cast_nullable_to_non_nullable
              as int,
      completedLessons: null == completedLessons
          ? _value.completedLessons
          : completedLessons // ignore: cast_nullable_to_non_nullable
              as int,
      progressPercentage: null == progressPercentage
          ? _value.progressPercentage
          : progressPercentage // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$DivineComedyModelImpl implements _DivineComedyModel {
  const _$DivineComedyModelImpl(
      {required this.title,
      required final List<String> cefrRange,
      required this.baseColor,
      required this.textColor,
      required this.cardColor,
      required this.backgroundImage,
      required final List<Lesson> lessons,
      this.totalLessons = 0,
      this.completedLessons = 0,
      this.progressPercentage = 0})
      : _cefrRange = cefrRange,
        _lessons = lessons;

  factory _$DivineComedyModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DivineComedyModelImplFromJson(json);

  @override
  final String title;
  final List<String> _cefrRange;
  @override
  List<String> get cefrRange {
    if (_cefrRange is EqualUnmodifiableListView) return _cefrRange;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_cefrRange);
  }

  @override
  final ColorModel baseColor;
  @override
  final ColorModel textColor;
  @override
  final ColorModel cardColor;
  @override
  final String backgroundImage;
  final List<Lesson> _lessons;
  @override
  List<Lesson> get lessons {
    if (_lessons is EqualUnmodifiableListView) return _lessons;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_lessons);
  }

  @override
  @JsonKey()
  final int totalLessons;
  @override
  @JsonKey()
  final int completedLessons;
  @override
  @JsonKey()
  final double progressPercentage;

  @override
  String toString() {
    return 'DivineComedyModel(title: $title, cefrRange: $cefrRange, baseColor: $baseColor, textColor: $textColor, cardColor: $cardColor, backgroundImage: $backgroundImage, lessons: $lessons, totalLessons: $totalLessons, completedLessons: $completedLessons, progressPercentage: $progressPercentage)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DivineComedyModelImpl &&
            (identical(other.title, title) || other.title == title) &&
            const DeepCollectionEquality()
                .equals(other._cefrRange, _cefrRange) &&
            (identical(other.baseColor, baseColor) ||
                other.baseColor == baseColor) &&
            (identical(other.textColor, textColor) ||
                other.textColor == textColor) &&
            (identical(other.cardColor, cardColor) ||
                other.cardColor == cardColor) &&
            (identical(other.backgroundImage, backgroundImage) ||
                other.backgroundImage == backgroundImage) &&
            const DeepCollectionEquality().equals(other._lessons, _lessons) &&
            (identical(other.totalLessons, totalLessons) ||
                other.totalLessons == totalLessons) &&
            (identical(other.completedLessons, completedLessons) ||
                other.completedLessons == completedLessons) &&
            (identical(other.progressPercentage, progressPercentage) ||
                other.progressPercentage == progressPercentage));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      title,
      const DeepCollectionEquality().hash(_cefrRange),
      baseColor,
      textColor,
      cardColor,
      backgroundImage,
      const DeepCollectionEquality().hash(_lessons),
      totalLessons,
      completedLessons,
      progressPercentage);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$DivineComedyModelImplCopyWith<_$DivineComedyModelImpl> get copyWith =>
      __$$DivineComedyModelImplCopyWithImpl<_$DivineComedyModelImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DivineComedyModelImplToJson(
      this,
    );
  }
}

abstract class _DivineComedyModel implements DivineComedyModel {
  const factory _DivineComedyModel(
      {required final String title,
      required final List<String> cefrRange,
      required final ColorModel baseColor,
      required final ColorModel textColor,
      required final ColorModel cardColor,
      required final String backgroundImage,
      required final List<Lesson> lessons,
      final int totalLessons,
      final int completedLessons,
      final double progressPercentage}) = _$DivineComedyModelImpl;

  factory _DivineComedyModel.fromJson(Map<String, dynamic> json) =
      _$DivineComedyModelImpl.fromJson;

  @override
  String get title;
  @override
  List<String> get cefrRange;
  @override
  ColorModel get baseColor;
  @override
  ColorModel get textColor;
  @override
  ColorModel get cardColor;
  @override
  String get backgroundImage;
  @override
  List<Lesson> get lessons;
  @override
  int get totalLessons;
  @override
  int get completedLessons;
  @override
  double get progressPercentage;
  @override
  @JsonKey(ignore: true)
  _$$DivineComedyModelImplCopyWith<_$DivineComedyModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ColorModel _$ColorModelFromJson(Map<String, dynamic> json) {
  return _ColorModel.fromJson(json);
}

/// @nodoc
mixin _$ColorModel {
  int get red => throw _privateConstructorUsedError;
  int get green => throw _privateConstructorUsedError;
  int get blue => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ColorModelCopyWith<ColorModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ColorModelCopyWith<$Res> {
  factory $ColorModelCopyWith(
          ColorModel value, $Res Function(ColorModel) then) =
      _$ColorModelCopyWithImpl<$Res, ColorModel>;
  @useResult
  $Res call({int red, int green, int blue});
}

/// @nodoc
class _$ColorModelCopyWithImpl<$Res, $Val extends ColorModel>
    implements $ColorModelCopyWith<$Res> {
  _$ColorModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
  }) {
    return _then(_value.copyWith(
      red: null == red
          ? _value.red
          : red // ignore: cast_nullable_to_non_nullable
              as int,
      green: null == green
          ? _value.green
          : green // ignore: cast_nullable_to_non_nullable
              as int,
      blue: null == blue
          ? _value.blue
          : blue // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ColorModelImplCopyWith<$Res>
    implements $ColorModelCopyWith<$Res> {
  factory _$$ColorModelImplCopyWith(
          _$ColorModelImpl value, $Res Function(_$ColorModelImpl) then) =
      __$$ColorModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int red, int green, int blue});
}

/// @nodoc
class __$$ColorModelImplCopyWithImpl<$Res>
    extends _$ColorModelCopyWithImpl<$Res, _$ColorModelImpl>
    implements _$$ColorModelImplCopyWith<$Res> {
  __$$ColorModelImplCopyWithImpl(
      _$ColorModelImpl _value, $Res Function(_$ColorModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? red = null,
    Object? green = null,
    Object? blue = null,
  }) {
    return _then(_$ColorModelImpl(
      red: null == red
          ? _value.red
          : red // ignore: cast_nullable_to_non_nullable
              as int,
      green: null == green
          ? _value.green
          : green // ignore: cast_nullable_to_non_nullable
              as int,
      blue: null == blue
          ? _value.blue
          : blue // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ColorModelImpl implements _ColorModel {
  const _$ColorModelImpl(
      {required this.red, required this.green, required this.blue});

  factory _$ColorModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ColorModelImplFromJson(json);

  @override
  final int red;
  @override
  final int green;
  @override
  final int blue;

  @override
  String toString() {
    return 'ColorModel(red: $red, green: $green, blue: $blue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ColorModelImpl &&
            (identical(other.red, red) || other.red == red) &&
            (identical(other.green, green) || other.green == green) &&
            (identical(other.blue, blue) || other.blue == blue));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, red, green, blue);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ColorModelImplCopyWith<_$ColorModelImpl> get copyWith =>
      __$$ColorModelImplCopyWithImpl<_$ColorModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ColorModelImplToJson(
      this,
    );
  }
}

abstract class _ColorModel implements ColorModel {
  const factory _ColorModel(
      {required final int red,
      required final int green,
      required final int blue}) = _$ColorModelImpl;

  factory _ColorModel.fromJson(Map<String, dynamic> json) =
      _$ColorModelImpl.fromJson;

  @override
  int get red;
  @override
  int get green;
  @override
  int get blue;
  @override
  @JsonKey(ignore: true)
  _$$ColorModelImplCopyWith<_$ColorModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
