// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'transactions_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$TransactionsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address) loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String toAddress, int amount, String? memo)
        sendTransaction,
    required TResult Function(String txHash) transactionSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult? Function(String txHash)? transactionSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult Function(String txHash)? transactionSent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SendTransaction value) sendTransaction,
    required TResult Function(TransactionSent value) transactionSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SendTransaction value)? sendTransaction,
    TResult? Function(TransactionSent value)? transactionSent,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SendTransaction value)? sendTransaction,
    TResult Function(TransactionSent value)? transactionSent,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionsEventCopyWith<$Res> {
  factory $TransactionsEventCopyWith(
          TransactionsEvent value, $Res Function(TransactionsEvent) then) =
      _$TransactionsEventCopyWithImpl<$Res, TransactionsEvent>;
}

/// @nodoc
class _$TransactionsEventCopyWithImpl<$Res, $Val extends TransactionsEvent>
    implements $TransactionsEventCopyWith<$Res> {
  _$TransactionsEventCopyWithImpl(this._value, this._then);

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
    extends _$TransactionsEventCopyWithImpl<$Res, _$LoadRequestedImpl>
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
    return 'TransactionsEvent.loadRequested(address: $address)';
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
    required TResult Function(String toAddress, int amount, String? memo)
        sendTransaction,
    required TResult Function(String txHash) transactionSent,
  }) {
    return loadRequested(address);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult? Function(String txHash)? transactionSent,
  }) {
    return loadRequested?.call(address);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult Function(String txHash)? transactionSent,
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
    required TResult Function(SendTransaction value) sendTransaction,
    required TResult Function(TransactionSent value) transactionSent,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SendTransaction value)? sendTransaction,
    TResult? Function(TransactionSent value)? transactionSent,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SendTransaction value)? sendTransaction,
    TResult Function(TransactionSent value)? transactionSent,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class LoadRequested implements TransactionsEvent {
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
    extends _$TransactionsEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
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
    return 'TransactionsEvent.refreshRequested()';
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
    required TResult Function(String toAddress, int amount, String? memo)
        sendTransaction,
    required TResult Function(String txHash) transactionSent,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult? Function(String txHash)? transactionSent,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult Function(String txHash)? transactionSent,
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
    required TResult Function(SendTransaction value) sendTransaction,
    required TResult Function(TransactionSent value) transactionSent,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SendTransaction value)? sendTransaction,
    TResult? Function(TransactionSent value)? transactionSent,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SendTransaction value)? sendTransaction,
    TResult Function(TransactionSent value)? transactionSent,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class RefreshRequested implements TransactionsEvent {
  const factory RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$SendTransactionImplCopyWith<$Res> {
  factory _$$SendTransactionImplCopyWith(_$SendTransactionImpl value,
          $Res Function(_$SendTransactionImpl) then) =
      __$$SendTransactionImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String toAddress, int amount, String? memo});
}

/// @nodoc
class __$$SendTransactionImplCopyWithImpl<$Res>
    extends _$TransactionsEventCopyWithImpl<$Res, _$SendTransactionImpl>
    implements _$$SendTransactionImplCopyWith<$Res> {
  __$$SendTransactionImplCopyWithImpl(
      _$SendTransactionImpl _value, $Res Function(_$SendTransactionImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? toAddress = null,
    Object? amount = null,
    Object? memo = freezed,
  }) {
    return _then(_$SendTransactionImpl(
      toAddress: null == toAddress
          ? _value.toAddress
          : toAddress // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as int,
      memo: freezed == memo
          ? _value.memo
          : memo // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$SendTransactionImpl implements SendTransaction {
  const _$SendTransactionImpl(
      {required this.toAddress, required this.amount, this.memo});

  @override
  final String toAddress;
  @override
  final int amount;
  @override
  final String? memo;

  @override
  String toString() {
    return 'TransactionsEvent.sendTransaction(toAddress: $toAddress, amount: $amount, memo: $memo)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SendTransactionImpl &&
            (identical(other.toAddress, toAddress) ||
                other.toAddress == toAddress) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.memo, memo) || other.memo == memo));
  }

  @override
  int get hashCode => Object.hash(runtimeType, toAddress, amount, memo);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SendTransactionImplCopyWith<_$SendTransactionImpl> get copyWith =>
      __$$SendTransactionImplCopyWithImpl<_$SendTransactionImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address) loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String toAddress, int amount, String? memo)
        sendTransaction,
    required TResult Function(String txHash) transactionSent,
  }) {
    return sendTransaction(toAddress, amount, memo);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult? Function(String txHash)? transactionSent,
  }) {
    return sendTransaction?.call(toAddress, amount, memo);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult Function(String txHash)? transactionSent,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(toAddress, amount, memo);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SendTransaction value) sendTransaction,
    required TResult Function(TransactionSent value) transactionSent,
  }) {
    return sendTransaction(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SendTransaction value)? sendTransaction,
    TResult? Function(TransactionSent value)? transactionSent,
  }) {
    return sendTransaction?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SendTransaction value)? sendTransaction,
    TResult Function(TransactionSent value)? transactionSent,
    required TResult orElse(),
  }) {
    if (sendTransaction != null) {
      return sendTransaction(this);
    }
    return orElse();
  }
}

abstract class SendTransaction implements TransactionsEvent {
  const factory SendTransaction(
      {required final String toAddress,
      required final int amount,
      final String? memo}) = _$SendTransactionImpl;

  String get toAddress;
  int get amount;
  String? get memo;
  @JsonKey(ignore: true)
  _$$SendTransactionImplCopyWith<_$SendTransactionImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$TransactionSentImplCopyWith<$Res> {
  factory _$$TransactionSentImplCopyWith(_$TransactionSentImpl value,
          $Res Function(_$TransactionSentImpl) then) =
      __$$TransactionSentImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String txHash});
}

/// @nodoc
class __$$TransactionSentImplCopyWithImpl<$Res>
    extends _$TransactionsEventCopyWithImpl<$Res, _$TransactionSentImpl>
    implements _$$TransactionSentImplCopyWith<$Res> {
  __$$TransactionSentImplCopyWithImpl(
      _$TransactionSentImpl _value, $Res Function(_$TransactionSentImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? txHash = null,
  }) {
    return _then(_$TransactionSentImpl(
      null == txHash
          ? _value.txHash
          : txHash // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$TransactionSentImpl implements TransactionSent {
  const _$TransactionSentImpl(this.txHash);

  @override
  final String txHash;

  @override
  String toString() {
    return 'TransactionsEvent.transactionSent(txHash: $txHash)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TransactionSentImpl &&
            (identical(other.txHash, txHash) || other.txHash == txHash));
  }

  @override
  int get hashCode => Object.hash(runtimeType, txHash);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TransactionSentImplCopyWith<_$TransactionSentImpl> get copyWith =>
      __$$TransactionSentImplCopyWithImpl<_$TransactionSentImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(String address) loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String toAddress, int amount, String? memo)
        sendTransaction,
    required TResult Function(String txHash) transactionSent,
  }) {
    return transactionSent(txHash);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function(String address)? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult? Function(String txHash)? transactionSent,
  }) {
    return transactionSent?.call(txHash);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(String address)? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String toAddress, int amount, String? memo)?
        sendTransaction,
    TResult Function(String txHash)? transactionSent,
    required TResult orElse(),
  }) {
    if (transactionSent != null) {
      return transactionSent(txHash);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(SendTransaction value) sendTransaction,
    required TResult Function(TransactionSent value) transactionSent,
  }) {
    return transactionSent(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(SendTransaction value)? sendTransaction,
    TResult? Function(TransactionSent value)? transactionSent,
  }) {
    return transactionSent?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(SendTransaction value)? sendTransaction,
    TResult Function(TransactionSent value)? transactionSent,
    required TResult orElse(),
  }) {
    if (transactionSent != null) {
      return transactionSent(this);
    }
    return orElse();
  }
}

abstract class TransactionSent implements TransactionsEvent {
  const factory TransactionSent(final String txHash) = _$TransactionSentImpl;

  String get txHash;
  @JsonKey(ignore: true)
  _$$TransactionSentImplCopyWith<_$TransactionSentImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
