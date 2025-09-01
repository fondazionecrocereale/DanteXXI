// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radio_station.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RadioStation _$RadioStationFromJson(Map<String, dynamic> json) {
  return _RadioStation.fromJson(json);
}

/// @nodoc
mixin _$RadioStation {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get streamUrl => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get category => throw _privateConstructorUsedError;
  String get logo => throw _privateConstructorUsedError;
  bool get isPlaying => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RadioStationCopyWith<RadioStation> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadioStationCopyWith<$Res> {
  factory $RadioStationCopyWith(
          RadioStation value, $Res Function(RadioStation) then) =
      _$RadioStationCopyWithImpl<$Res, RadioStation>;
  @useResult
  $Res call(
      {int id,
      String name,
      String streamUrl,
      String description,
      String category,
      String logo,
      bool isPlaying});
}

/// @nodoc
class _$RadioStationCopyWithImpl<$Res, $Val extends RadioStation>
    implements $RadioStationCopyWith<$Res> {
  _$RadioStationCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? streamUrl = null,
    Object? description = null,
    Object? category = null,
    Object? logo = null,
    Object? isPlaying = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      streamUrl: null == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RadioStationImplCopyWith<$Res>
    implements $RadioStationCopyWith<$Res> {
  factory _$$RadioStationImplCopyWith(
          _$RadioStationImpl value, $Res Function(_$RadioStationImpl) then) =
      __$$RadioStationImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String name,
      String streamUrl,
      String description,
      String category,
      String logo,
      bool isPlaying});
}

/// @nodoc
class __$$RadioStationImplCopyWithImpl<$Res>
    extends _$RadioStationCopyWithImpl<$Res, _$RadioStationImpl>
    implements _$$RadioStationImplCopyWith<$Res> {
  __$$RadioStationImplCopyWithImpl(
      _$RadioStationImpl _value, $Res Function(_$RadioStationImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? streamUrl = null,
    Object? description = null,
    Object? category = null,
    Object? logo = null,
    Object? isPlaying = null,
  }) {
    return _then(_$RadioStationImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      streamUrl: null == streamUrl
          ? _value.streamUrl
          : streamUrl // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      logo: null == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RadioStationImpl implements _RadioStation {
  const _$RadioStationImpl(
      {required this.id,
      required this.name,
      required this.streamUrl,
      required this.description,
      required this.category,
      required this.logo,
      this.isPlaying = false});

  factory _$RadioStationImpl.fromJson(Map<String, dynamic> json) =>
      _$$RadioStationImplFromJson(json);

  @override
  final int id;
  @override
  final String name;
  @override
  final String streamUrl;
  @override
  final String description;
  @override
  final String category;
  @override
  final String logo;
  @override
  @JsonKey()
  final bool isPlaying;

  @override
  String toString() {
    return 'RadioStation(id: $id, name: $name, streamUrl: $streamUrl, description: $description, category: $category, logo: $logo, isPlaying: $isPlaying)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadioStationImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.streamUrl, streamUrl) ||
                other.streamUrl == streamUrl) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, streamUrl, description, category, logo, isPlaying);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RadioStationImplCopyWith<_$RadioStationImpl> get copyWith =>
      __$$RadioStationImplCopyWithImpl<_$RadioStationImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RadioStationImplToJson(
      this,
    );
  }
}

abstract class _RadioStation implements RadioStation {
  const factory _RadioStation(
      {required final int id,
      required final String name,
      required final String streamUrl,
      required final String description,
      required final String category,
      required final String logo,
      final bool isPlaying}) = _$RadioStationImpl;

  factory _RadioStation.fromJson(Map<String, dynamic> json) =
      _$RadioStationImpl.fromJson;

  @override
  int get id;
  @override
  String get name;
  @override
  String get streamUrl;
  @override
  String get description;
  @override
  String get category;
  @override
  String get logo;
  @override
  bool get isPlaying;
  @override
  @JsonKey(ignore: true)
  _$$RadioStationImplCopyWith<_$RadioStationImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
