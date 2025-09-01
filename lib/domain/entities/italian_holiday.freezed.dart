// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'italian_holiday.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

ItalianHoliday _$ItalianHolidayFromJson(Map<String, dynamic> json) {
  return _ItalianHoliday.fromJson(json);
}

/// @nodoc
mixin _$ItalianHoliday {
  String get name => throw _privateConstructorUsedError;
  String get date => throw _privateConstructorUsedError;
  String get message => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItalianHolidayCopyWith<ItalianHoliday> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItalianHolidayCopyWith<$Res> {
  factory $ItalianHolidayCopyWith(
          ItalianHoliday value, $Res Function(ItalianHoliday) then) =
      _$ItalianHolidayCopyWithImpl<$Res, ItalianHoliday>;
  @useResult
  $Res call({String name, String date, String message});
}

/// @nodoc
class _$ItalianHolidayCopyWithImpl<$Res, $Val extends ItalianHoliday>
    implements $ItalianHolidayCopyWith<$Res> {
  _$ItalianHolidayCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? message = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItalianHolidayImplCopyWith<$Res>
    implements $ItalianHolidayCopyWith<$Res> {
  factory _$$ItalianHolidayImplCopyWith(_$ItalianHolidayImpl value,
          $Res Function(_$ItalianHolidayImpl) then) =
      __$$ItalianHolidayImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String name, String date, String message});
}

/// @nodoc
class __$$ItalianHolidayImplCopyWithImpl<$Res>
    extends _$ItalianHolidayCopyWithImpl<$Res, _$ItalianHolidayImpl>
    implements _$$ItalianHolidayImplCopyWith<$Res> {
  __$$ItalianHolidayImplCopyWithImpl(
      _$ItalianHolidayImpl _value, $Res Function(_$ItalianHolidayImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? date = null,
    Object? message = null,
  }) {
    return _then(_$ItalianHolidayImpl(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as String,
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItalianHolidayImpl implements _ItalianHoliday {
  const _$ItalianHolidayImpl(
      {required this.name, required this.date, required this.message});

  factory _$ItalianHolidayImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItalianHolidayImplFromJson(json);

  @override
  final String name;
  @override
  final String date;
  @override
  final String message;

  @override
  String toString() {
    return 'ItalianHoliday(name: $name, date: $date, message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItalianHolidayImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.message, message) || other.message == message));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, date, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItalianHolidayImplCopyWith<_$ItalianHolidayImpl> get copyWith =>
      __$$ItalianHolidayImplCopyWithImpl<_$ItalianHolidayImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItalianHolidayImplToJson(
      this,
    );
  }
}

abstract class _ItalianHoliday implements ItalianHoliday {
  const factory _ItalianHoliday(
      {required final String name,
      required final String date,
      required final String message}) = _$ItalianHolidayImpl;

  factory _ItalianHoliday.fromJson(Map<String, dynamic> json) =
      _$ItalianHolidayImpl.fromJson;

  @override
  String get name;
  @override
  String get date;
  @override
  String get message;
  @override
  @JsonKey(ignore: true)
  _$$ItalianHolidayImplCopyWith<_$ItalianHolidayImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

ItalianHolidays _$ItalianHolidaysFromJson(Map<String, dynamic> json) {
  return _ItalianHolidays.fromJson(json);
}

/// @nodoc
mixin _$ItalianHolidays {
  List<ItalianHoliday> get holidays => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItalianHolidaysCopyWith<ItalianHolidays> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItalianHolidaysCopyWith<$Res> {
  factory $ItalianHolidaysCopyWith(
          ItalianHolidays value, $Res Function(ItalianHolidays) then) =
      _$ItalianHolidaysCopyWithImpl<$Res, ItalianHolidays>;
  @useResult
  $Res call({List<ItalianHoliday> holidays});
}

/// @nodoc
class _$ItalianHolidaysCopyWithImpl<$Res, $Val extends ItalianHolidays>
    implements $ItalianHolidaysCopyWith<$Res> {
  _$ItalianHolidaysCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? holidays = null,
  }) {
    return _then(_value.copyWith(
      holidays: null == holidays
          ? _value.holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<ItalianHoliday>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ItalianHolidaysImplCopyWith<$Res>
    implements $ItalianHolidaysCopyWith<$Res> {
  factory _$$ItalianHolidaysImplCopyWith(_$ItalianHolidaysImpl value,
          $Res Function(_$ItalianHolidaysImpl) then) =
      __$$ItalianHolidaysImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<ItalianHoliday> holidays});
}

/// @nodoc
class __$$ItalianHolidaysImplCopyWithImpl<$Res>
    extends _$ItalianHolidaysCopyWithImpl<$Res, _$ItalianHolidaysImpl>
    implements _$$ItalianHolidaysImplCopyWith<$Res> {
  __$$ItalianHolidaysImplCopyWithImpl(
      _$ItalianHolidaysImpl _value, $Res Function(_$ItalianHolidaysImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? holidays = null,
  }) {
    return _then(_$ItalianHolidaysImpl(
      holidays: null == holidays
          ? _value._holidays
          : holidays // ignore: cast_nullable_to_non_nullable
              as List<ItalianHoliday>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ItalianHolidaysImpl implements _ItalianHolidays {
  const _$ItalianHolidaysImpl({required final List<ItalianHoliday> holidays})
      : _holidays = holidays;

  factory _$ItalianHolidaysImpl.fromJson(Map<String, dynamic> json) =>
      _$$ItalianHolidaysImplFromJson(json);

  final List<ItalianHoliday> _holidays;
  @override
  List<ItalianHoliday> get holidays {
    if (_holidays is EqualUnmodifiableListView) return _holidays;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_holidays);
  }

  @override
  String toString() {
    return 'ItalianHolidays(holidays: $holidays)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ItalianHolidaysImpl &&
            const DeepCollectionEquality().equals(other._holidays, _holidays));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_holidays));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ItalianHolidaysImplCopyWith<_$ItalianHolidaysImpl> get copyWith =>
      __$$ItalianHolidaysImplCopyWithImpl<_$ItalianHolidaysImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ItalianHolidaysImplToJson(
      this,
    );
  }
}

abstract class _ItalianHolidays implements ItalianHolidays {
  const factory _ItalianHolidays(
      {required final List<ItalianHoliday> holidays}) = _$ItalianHolidaysImpl;

  factory _ItalianHolidays.fromJson(Map<String, dynamic> json) =
      _$ItalianHolidaysImpl.fromJson;

  @override
  List<ItalianHoliday> get holidays;
  @override
  @JsonKey(ignore: true)
  _$$ItalianHolidaysImplCopyWith<_$ItalianHolidaysImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
