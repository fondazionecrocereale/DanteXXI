// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'radio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RadioState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RadioStation> stations,
            RadioStation? currentStation, bool isPlaying, double volume)
        loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RadioInitial value) initial,
    required TResult Function(RadioLoading value) loading,
    required TResult Function(RadioLoaded value) loaded,
    required TResult Function(RadioError value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RadioInitial value)? initial,
    TResult? Function(RadioLoading value)? loading,
    TResult? Function(RadioLoaded value)? loaded,
    TResult? Function(RadioError value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RadioInitial value)? initial,
    TResult Function(RadioLoading value)? loading,
    TResult Function(RadioLoaded value)? loaded,
    TResult Function(RadioError value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RadioStateCopyWith<$Res> {
  factory $RadioStateCopyWith(
          RadioState value, $Res Function(RadioState) then) =
      _$RadioStateCopyWithImpl<$Res, RadioState>;
}

/// @nodoc
class _$RadioStateCopyWithImpl<$Res, $Val extends RadioState>
    implements $RadioStateCopyWith<$Res> {
  _$RadioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$RadioInitialImplCopyWith<$Res> {
  factory _$$RadioInitialImplCopyWith(
          _$RadioInitialImpl value, $Res Function(_$RadioInitialImpl) then) =
      __$$RadioInitialImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RadioInitialImplCopyWithImpl<$Res>
    extends _$RadioStateCopyWithImpl<$Res, _$RadioInitialImpl>
    implements _$$RadioInitialImplCopyWith<$Res> {
  __$$RadioInitialImplCopyWithImpl(
      _$RadioInitialImpl _value, $Res Function(_$RadioInitialImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RadioInitialImpl implements RadioInitial {
  const _$RadioInitialImpl();

  @override
  String toString() {
    return 'RadioState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RadioInitialImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RadioStation> stations,
            RadioStation? currentStation, bool isPlaying, double volume)
        loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RadioInitial value) initial,
    required TResult Function(RadioLoading value) loading,
    required TResult Function(RadioLoaded value) loaded,
    required TResult Function(RadioError value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RadioInitial value)? initial,
    TResult? Function(RadioLoading value)? loading,
    TResult? Function(RadioLoaded value)? loaded,
    TResult? Function(RadioError value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RadioInitial value)? initial,
    TResult Function(RadioLoading value)? loading,
    TResult Function(RadioLoaded value)? loaded,
    TResult Function(RadioError value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class RadioInitial implements RadioState {
  const factory RadioInitial() = _$RadioInitialImpl;
}

/// @nodoc
abstract class _$$RadioLoadingImplCopyWith<$Res> {
  factory _$$RadioLoadingImplCopyWith(
          _$RadioLoadingImpl value, $Res Function(_$RadioLoadingImpl) then) =
      __$$RadioLoadingImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RadioLoadingImplCopyWithImpl<$Res>
    extends _$RadioStateCopyWithImpl<$Res, _$RadioLoadingImpl>
    implements _$$RadioLoadingImplCopyWith<$Res> {
  __$$RadioLoadingImplCopyWithImpl(
      _$RadioLoadingImpl _value, $Res Function(_$RadioLoadingImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RadioLoadingImpl implements RadioLoading {
  const _$RadioLoadingImpl();

  @override
  String toString() {
    return 'RadioState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RadioLoadingImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RadioStation> stations,
            RadioStation? currentStation, bool isPlaying, double volume)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RadioInitial value) initial,
    required TResult Function(RadioLoading value) loading,
    required TResult Function(RadioLoaded value) loaded,
    required TResult Function(RadioError value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RadioInitial value)? initial,
    TResult? Function(RadioLoading value)? loading,
    TResult? Function(RadioLoaded value)? loaded,
    TResult? Function(RadioError value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RadioInitial value)? initial,
    TResult Function(RadioLoading value)? loading,
    TResult Function(RadioLoaded value)? loaded,
    TResult Function(RadioError value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class RadioLoading implements RadioState {
  const factory RadioLoading() = _$RadioLoadingImpl;
}

/// @nodoc
abstract class _$$RadioLoadedImplCopyWith<$Res> {
  factory _$$RadioLoadedImplCopyWith(
          _$RadioLoadedImpl value, $Res Function(_$RadioLoadedImpl) then) =
      __$$RadioLoadedImplCopyWithImpl<$Res>;
  @useResult
  $Res call(
      {List<RadioStation> stations,
      RadioStation? currentStation,
      bool isPlaying,
      double volume});

  $RadioStationCopyWith<$Res>? get currentStation;
}

/// @nodoc
class __$$RadioLoadedImplCopyWithImpl<$Res>
    extends _$RadioStateCopyWithImpl<$Res, _$RadioLoadedImpl>
    implements _$$RadioLoadedImplCopyWith<$Res> {
  __$$RadioLoadedImplCopyWithImpl(
      _$RadioLoadedImpl _value, $Res Function(_$RadioLoadedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stations = null,
    Object? currentStation = freezed,
    Object? isPlaying = null,
    Object? volume = null,
  }) {
    return _then(_$RadioLoadedImpl(
      stations: null == stations
          ? _value._stations
          : stations // ignore: cast_nullable_to_non_nullable
              as List<RadioStation>,
      currentStation: freezed == currentStation
          ? _value.currentStation
          : currentStation // ignore: cast_nullable_to_non_nullable
              as RadioStation?,
      isPlaying: null == isPlaying
          ? _value.isPlaying
          : isPlaying // ignore: cast_nullable_to_non_nullable
              as bool,
      volume: null == volume
          ? _value.volume
          : volume // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $RadioStationCopyWith<$Res>? get currentStation {
    if (_value.currentStation == null) {
      return null;
    }

    return $RadioStationCopyWith<$Res>(_value.currentStation!, (value) {
      return _then(_value.copyWith(currentStation: value));
    });
  }
}

/// @nodoc

class _$RadioLoadedImpl implements RadioLoaded {
  const _$RadioLoadedImpl(
      {required final List<RadioStation> stations,
      this.currentStation,
      this.isPlaying = false,
      this.volume = 1.0})
      : _stations = stations;

  final List<RadioStation> _stations;
  @override
  List<RadioStation> get stations {
    if (_stations is EqualUnmodifiableListView) return _stations;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stations);
  }

  @override
  final RadioStation? currentStation;
  @override
  @JsonKey()
  final bool isPlaying;
  @override
  @JsonKey()
  final double volume;

  @override
  String toString() {
    return 'RadioState.loaded(stations: $stations, currentStation: $currentStation, isPlaying: $isPlaying, volume: $volume)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadioLoadedImpl &&
            const DeepCollectionEquality().equals(other._stations, _stations) &&
            (identical(other.currentStation, currentStation) ||
                other.currentStation == currentStation) &&
            (identical(other.isPlaying, isPlaying) ||
                other.isPlaying == isPlaying) &&
            (identical(other.volume, volume) || other.volume == volume));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_stations),
      currentStation,
      isPlaying,
      volume);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RadioLoadedImplCopyWith<_$RadioLoadedImpl> get copyWith =>
      __$$RadioLoadedImplCopyWithImpl<_$RadioLoadedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RadioStation> stations,
            RadioStation? currentStation, bool isPlaying, double volume)
        loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(stations, currentStation, isPlaying, volume);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(stations, currentStation, isPlaying, volume);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(stations, currentStation, isPlaying, volume);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RadioInitial value) initial,
    required TResult Function(RadioLoading value) loading,
    required TResult Function(RadioLoaded value) loaded,
    required TResult Function(RadioError value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RadioInitial value)? initial,
    TResult? Function(RadioLoading value)? loading,
    TResult? Function(RadioLoaded value)? loaded,
    TResult? Function(RadioError value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RadioInitial value)? initial,
    TResult Function(RadioLoading value)? loading,
    TResult Function(RadioLoaded value)? loaded,
    TResult Function(RadioError value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class RadioLoaded implements RadioState {
  const factory RadioLoaded(
      {required final List<RadioStation> stations,
      final RadioStation? currentStation,
      final bool isPlaying,
      final double volume}) = _$RadioLoadedImpl;

  List<RadioStation> get stations;
  RadioStation? get currentStation;
  bool get isPlaying;
  double get volume;
  @JsonKey(ignore: true)
  _$$RadioLoadedImplCopyWith<_$RadioLoadedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RadioErrorImplCopyWith<$Res> {
  factory _$$RadioErrorImplCopyWith(
          _$RadioErrorImpl value, $Res Function(_$RadioErrorImpl) then) =
      __$$RadioErrorImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$RadioErrorImplCopyWithImpl<$Res>
    extends _$RadioStateCopyWithImpl<$Res, _$RadioErrorImpl>
    implements _$$RadioErrorImplCopyWith<$Res> {
  __$$RadioErrorImplCopyWithImpl(
      _$RadioErrorImpl _value, $Res Function(_$RadioErrorImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$RadioErrorImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$RadioErrorImpl implements RadioError {
  const _$RadioErrorImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'RadioState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RadioErrorImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RadioErrorImplCopyWith<_$RadioErrorImpl> get copyWith =>
      __$$RadioErrorImplCopyWithImpl<_$RadioErrorImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(List<RadioStation> stations,
            RadioStation? currentStation, bool isPlaying, double volume)
        loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(List<RadioStation> stations, RadioStation? currentStation,
            bool isPlaying, double volume)?
        loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RadioInitial value) initial,
    required TResult Function(RadioLoading value) loading,
    required TResult Function(RadioLoaded value) loaded,
    required TResult Function(RadioError value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(RadioInitial value)? initial,
    TResult? Function(RadioLoading value)? loading,
    TResult? Function(RadioLoaded value)? loaded,
    TResult? Function(RadioError value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RadioInitial value)? initial,
    TResult Function(RadioLoading value)? loading,
    TResult Function(RadioLoaded value)? loaded,
    TResult Function(RadioError value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class RadioError implements RadioState {
  const factory RadioError(final String message) = _$RadioErrorImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$RadioErrorImplCopyWith<_$RadioErrorImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
