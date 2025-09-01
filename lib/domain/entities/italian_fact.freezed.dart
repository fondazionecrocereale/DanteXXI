// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'italian_fact.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItalianFact _$ItalianFactFromJson(Map<String, dynamic> json) {
  return _ItalianFact.fromJson(json);
}

/// @nodoc
mixin _$ItalianFact {
  String get topic => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItalianFactCopyWith<ItalianFact> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItalianFactCopyWith<$Res> {
  factory $ItalianFactCopyWith(
          ItalianFact value, $Res Function(ItalianFact) then) =
      _$ItalianFactCopyWithImpl<$Res, ItalianFact>;
  @useResult
  $Res call(
      {String topic,
      String description,
      String date,
      String message,
      String? url});
}

/// @nodoc
class _$ItalianFactCopyWithImpl<$Res, $Val extends ItalianFact>
    implements $ItalianFactCopyWith<$Res> {
  _$ItalianFactCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? description = null,
    Object? date = null,
    Object? message = null,
    Object? url = freezed,
  }) {
    return _then(_value.copyWith(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItalianFactImplCopyWith<$Res>
    implements $ItalianFactCopyWith<$Res> {
  factory _$$ItalianFactImplCopyWith(
          _$ItalianFactImpl value, $Res Function(_$ItalianFactImpl) then) =
      __$$ItalianFactImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String topic,
      String description,
      String date,
      String message,
      String? url});
}

/// @nodoc
class __$$ItalianFactImplCopyWithImpl<$Res>
    extends _$ItalianFactCopyWithImpl<$Res, _$ItalianFactImpl>
    implements _$$ItalianFactImplCopyWith<$Res> {
  __$$ItalianFactImplCopyWithImpl(
      _$ItalianFactImpl _value, $Res Function(_$ItalianFactImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? topic = null,
    Object? description = null,
    Object? date = null,
    Object? message = null,
    Object? url = freezed,
  }) {
    return _then(_$ItalianFactImpl(
      topic: null == topic
          ? _value.topic
          : topic // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItalianFactImpl implements _ItalianFact {
  const _$ItalianFactImpl(
      {required this.topic,
      required this.description,
      required this.date,
      required this.message,
      this.url});

  factory _$ItalianFactImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItalianFactImplFromJson(json);

  @override
  final String topic;
  @override
  final String description;
  @override
  final String date;
  @override
  final String message;
  @override
  final String? url;

  @override
  String toString() {
    return 'ItalianFact(topic: $topic, description: $description, date: $date, message: $message, url: $url)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItalianFactImpl &&
            (identical(other.topic, topic) || other.topic == topic) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.url, url) || other.url == url));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, topic, description, date, message, url);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItalianFactImplCopyWith<_$ItalianFactImpl> get copyWith =>
      __$$ItalianFactImplCopyWithImpl<_$ItalianFactImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItalianFactImplToJson(
      this,
    );
  }
}

abstract class _ItalianFact implements ItalianFact {
  const factory _ItalianFact(
      {required final String topic,
      required final String description,
      required final String date,
      required final String message,
      final String? url}) = _$ItalianFactImpl;

  factory _ItalianFact.fromJson(Map<String, dynamic> json) =
      _$ItalianFactImpl.fromJson;

  @override
  String get topic;
  @override
  String get description;
  @override
  String get date;
  @override
  String get message;
  @override
  String? get url;
  @override
  @JsonKey(ignore: true)
  _$$ItalianFactImplCopyWith<_$ItalianFactImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItalianFacts _$ItalianFactsFromJson(Map<String, dynamic> json) {
  return _ItalianFacts.fromJson(json);
}

/// @nodoc
mixin _$ItalianFacts {
  List<ItalianFact> get facts => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItalianFactsCopyWith<ItalianFacts> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItalianFactsCopyWith<$Res> {
  factory $ItalianFactsCopyWith(
          ItalianFacts value, $Res Function(ItalianFacts) then) =
      _$ItalianFactsCopyWithImpl<$Res, ItalianFacts>;
  @useResult
  $Res call({List<ItalianFact> facts});
}

/// @nodoc
class _$ItalianFactsCopyWithImpl<$Res, $Val extends ItalianFacts>
    implements $ItalianFactsCopyWith<$Res> {
  _$ItalianFactsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facts = null,
  }) {
    return _then(_value.copyWith(
      facts: null == facts
          ? _value.facts
          : facts // ignore: cast_nullable_to_non_nullable
              as List<ItalianFact>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItalianFactsImplCopyWith<$Res>
    implements $ItalianFactsCopyWith<$Res> {
  factory _$$ItalianFactsImplCopyWith(
          _$ItalianFactsImpl value, $Res Function(_$ItalianFactsImpl) then) =
      __$$ItalianFactsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ItalianFact> facts});
}

/// @nodoc
class __$$ItalianFactsImplCopyWithImpl<$Res>
    extends _$ItalianFactsCopyWithImpl<$Res, _$ItalianFactsImpl>
    implements _$$ItalianFactsImplCopyWith<$Res> {
  __$$ItalianFactsImplCopyWithImpl(
      _$ItalianFactsImpl _value, $Res Function(_$ItalianFactsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? facts = null,
  }) {
    return _then(_$ItalianFactsImpl(
      facts: null == facts
          ? _value._facts
          : facts // ignore: cast_nullable_to_non_nullable
              as List<ItalianFact>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItalianFactsImpl implements _ItalianFacts {
  const _$ItalianFactsImpl({required final List<ItalianFact> facts})
      : _facts = facts;

  factory _$ItalianFactsImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItalianFactsImplFromJson(json);

  final List<ItalianFact> _facts;
  @override
  List<ItalianFact> get facts {
    if (_facts is EqualUnmodifiableListView) return _facts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_facts);
  }

  @override
  String toString() {
    return 'ItalianFacts(facts: $facts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItalianFactsImpl &&
            const DeepCollectionEquality().equals(other._facts, _facts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_facts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItalianFactsImplCopyWith<_$ItalianFactsImpl> get copyWith =>
      __$$ItalianFactsImplCopyWithImpl<_$ItalianFactsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItalianFactsImplToJson(
      this,
    );
  }
}

abstract class _ItalianFacts implements ItalianFacts {
  const factory _ItalianFacts({required final List<ItalianFact> facts}) =
      _$ItalianFactsImpl;

  factory _ItalianFacts.fromJson(Map<String, dynamic> json) =
      _$ItalianFactsImpl.fromJson;

  @override
  List<ItalianFact> get facts;
  @override
  @JsonKey(ignore: true)
  _$$ItalianFactsImplCopyWith<_$ItalianFactsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
