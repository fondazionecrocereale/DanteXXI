// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$WalletEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address) loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function() balanceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? balanceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function()? balanceUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(BalanceUpdated value) balanceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(BalanceUpdated value)? balanceUpdated,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(BalanceUpdated value)? balanceUpdated,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletEventCopyWith<$Res> {
  factory $WalletEventCopyWith(
          WalletEvent value, $Res Function(WalletEvent) then) =
      _$WalletEventCopyWithImpl<$Res, WalletEvent>;
}

/// @nodoc
class _$WalletEventCopyWithImpl<$Res, $Val extends WalletEvent>
    implements $WalletEventCopyWith<$Res> {
  _$WalletEventCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$LoadRequestedImplCopyWith<$Res> {
  factory _$$LoadRequestedImplCopyWith(
          _$LoadRequestedImpl value, $Res Function(_$LoadRequestedImpl) then) =
      __$$LoadRequestedImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String address});
}

/// @nodoc
class __$$LoadRequestedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$LoadRequestedImpl>
    implements _$$LoadRequestedImplCopyWith<$Res> {
  __$$LoadRequestedImplCopyWithImpl(
      _$LoadRequestedImpl _value, $Res Function(_$LoadRequestedImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? address = null,
  }) {
    return _then(_$LoadRequestedImpl(
      null == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$LoadRequestedImpl implements LoadRequested {
  const _$LoadRequestedImpl(this.address);

  @override
  final String address;

  @override
  String toString() {
    return 'WalletEvent.loadRequested(address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$LoadRequestedImpl &&
            (identical(other.address, address) || other.address == address));
  }

  @override
  int get hashCode => Object.hash(runtimeType, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$LoadRequestedImplCopyWith<_$LoadRequestedImpl> get copyWith =>
      __$$LoadRequestedImplCopyWithImpl<_$LoadRequestedImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address) loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function() balanceUpdated,
  }) {
    return loadRequested(address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? balanceUpdated,
  }) {
    return loadRequested?.call(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function()? balanceUpdated,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(address);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(BalanceUpdated value) balanceUpdated,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(BalanceUpdated value)? balanceUpdated,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(BalanceUpdated value)? balanceUpdated,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class LoadRequested implements WalletEvent {
  const factory LoadRequested(final String address) = _$LoadRequestedImpl;

  String get address;
  @JsonKey(ignore: true)
  _$$LoadRequestedImplCopyWith<_$LoadRequestedImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(_$RefreshRequestedImpl value,
          $Res Function(_$RefreshRequestedImpl) then) =
      __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
    implements _$$RefreshRequestedImplCopyWith<$Res> {
  __$$RefreshRequestedImplCopyWithImpl(_$RefreshRequestedImpl _value,
      $Res Function(_$RefreshRequestedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RefreshRequestedImpl implements RefreshRequested {
  const _$RefreshRequestedImpl();

  @override
  String toString() {
    return 'WalletEvent.refreshRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RefreshRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address) loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function() balanceUpdated,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? balanceUpdated,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function()? balanceUpdated,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(BalanceUpdated value) balanceUpdated,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(BalanceUpdated value)? balanceUpdated,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(BalanceUpdated value)? balanceUpdated,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class RefreshRequested implements WalletEvent {
  const factory RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$BalanceUpdatedImplCopyWith<$Res> {
  factory _$$BalanceUpdatedImplCopyWith(_$BalanceUpdatedImpl value,
          $Res Function(_$BalanceUpdatedImpl) then) =
      __$$BalanceUpdatedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$BalanceUpdatedImplCopyWithImpl<$Res>
    extends _$WalletEventCopyWithImpl<$Res, _$BalanceUpdatedImpl>
    implements _$$BalanceUpdatedImplCopyWith<$Res> {
  __$$BalanceUpdatedImplCopyWithImpl(
      _$BalanceUpdatedImpl _value, $Res Function(_$BalanceUpdatedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$BalanceUpdatedImpl implements BalanceUpdated {
  const _$BalanceUpdatedImpl();

  @override
  String toString() {
    return 'WalletEvent.balanceUpdated()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$BalanceUpdatedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address) loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function() balanceUpdated,
  }) {
    return balanceUpdated();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function()? balanceUpdated,
  }) {
    return balanceUpdated?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function()? balanceUpdated,
    required TResult orElse(),
  }) {
    if (balanceUpdated != null) {
      return balanceUpdated();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(BalanceUpdated value) balanceUpdated,
  }) {
    return balanceUpdated(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(BalanceUpdated value)? balanceUpdated,
  }) {
    return balanceUpdated?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(BalanceUpdated value)? balanceUpdated,
    required TResult orElse(),
  }) {
    if (balanceUpdated != null) {
      return balanceUpdated(this);
    }
    return orElse();
  }
}

abstract class BalanceUpdated implements WalletEvent {
  const factory BalanceUpdated() = _$BalanceUpdatedImpl;
}
