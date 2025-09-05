// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'rewards_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

/// @nodoc
mixin _$RewardsEvent {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String rewardId) claimReward,
    required TResult Function() rewardClaimed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String rewardId)? claimReward,
    TResult? Function()? rewardClaimed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String rewardId)? claimReward,
    TResult Function()? rewardClaimed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(ClaimReward value) claimReward,
    required TResult Function(RewardClaimed value) rewardClaimed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(ClaimReward value)? claimReward,
    TResult? Function(RewardClaimed value)? rewardClaimed,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(ClaimReward value)? claimReward,
    TResult Function(RewardClaimed value)? rewardClaimed,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RewardsEventCopyWith<$Res> {
  factory $RewardsEventCopyWith(
          RewardsEvent value, $Res Function(RewardsEvent) then) =
      _$RewardsEventCopyWithImpl<$Res, RewardsEvent>;
}

/// @nodoc
class _$RewardsEventCopyWithImpl<$Res, $Val extends RewardsEvent>
    implements $RewardsEventCopyWith<$Res> {
  _$RewardsEventCopyWithImpl(this._value, this._then);

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
}

/// @nodoc
class __$$LoadRequestedImplCopyWithImpl<$Res>
    extends _$RewardsEventCopyWithImpl<$Res, _$LoadRequestedImpl>
    implements _$$LoadRequestedImplCopyWith<$Res> {
  __$$LoadRequestedImplCopyWithImpl(
      _$LoadRequestedImpl _value, $Res Function(_$LoadRequestedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$LoadRequestedImpl implements LoadRequested {
  const _$LoadRequestedImpl();

  @override
  String toString() {
    return 'RewardsEvent.loadRequested()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$LoadRequestedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String rewardId) claimReward,
    required TResult Function() rewardClaimed,
  }) {
    return loadRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String rewardId)? claimReward,
    TResult? Function()? rewardClaimed,
  }) {
    return loadRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String rewardId)? claimReward,
    TResult Function()? rewardClaimed,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(ClaimReward value) claimReward,
    required TResult Function(RewardClaimed value) rewardClaimed,
  }) {
    return loadRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(ClaimReward value)? claimReward,
    TResult? Function(RewardClaimed value)? rewardClaimed,
  }) {
    return loadRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(ClaimReward value)? claimReward,
    TResult Function(RewardClaimed value)? rewardClaimed,
    required TResult orElse(),
  }) {
    if (loadRequested != null) {
      return loadRequested(this);
    }
    return orElse();
  }
}

abstract class LoadRequested implements RewardsEvent {
  const factory LoadRequested() = _$LoadRequestedImpl;
}

/// @nodoc
abstract class _$$RefreshRequestedImplCopyWith<$Res> {
  factory _$$RefreshRequestedImplCopyWith(_$RefreshRequestedImpl value,
          $Res Function(_$RefreshRequestedImpl) then) =
      __$$RefreshRequestedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RefreshRequestedImplCopyWithImpl<$Res>
    extends _$RewardsEventCopyWithImpl<$Res, _$RefreshRequestedImpl>
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
    return 'RewardsEvent.refreshRequested()';
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
    required TResult Function() loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String rewardId) claimReward,
    required TResult Function() rewardClaimed,
  }) {
    return refreshRequested();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String rewardId)? claimReward,
    TResult? Function()? rewardClaimed,
  }) {
    return refreshRequested?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String rewardId)? claimReward,
    TResult Function()? rewardClaimed,
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
    required TResult Function(ClaimReward value) claimReward,
    required TResult Function(RewardClaimed value) rewardClaimed,
  }) {
    return refreshRequested(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(ClaimReward value)? claimReward,
    TResult? Function(RewardClaimed value)? rewardClaimed,
  }) {
    return refreshRequested?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(ClaimReward value)? claimReward,
    TResult Function(RewardClaimed value)? rewardClaimed,
    required TResult orElse(),
  }) {
    if (refreshRequested != null) {
      return refreshRequested(this);
    }
    return orElse();
  }
}

abstract class RefreshRequested implements RewardsEvent {
  const factory RefreshRequested() = _$RefreshRequestedImpl;
}

/// @nodoc
abstract class _$$ClaimRewardImplCopyWith<$Res> {
  factory _$$ClaimRewardImplCopyWith(
          _$ClaimRewardImpl value, $Res Function(_$ClaimRewardImpl) then) =
      __$$ClaimRewardImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String rewardId});
}

/// @nodoc
class __$$ClaimRewardImplCopyWithImpl<$Res>
    extends _$RewardsEventCopyWithImpl<$Res, _$ClaimRewardImpl>
    implements _$$ClaimRewardImplCopyWith<$Res> {
  __$$ClaimRewardImplCopyWithImpl(
      _$ClaimRewardImpl _value, $Res Function(_$ClaimRewardImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? rewardId = null,
  }) {
    return _then(_$ClaimRewardImpl(
      null == rewardId
          ? _value.rewardId
          : rewardId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$ClaimRewardImpl implements ClaimReward {
  const _$ClaimRewardImpl(this.rewardId);

  @override
  final String rewardId;

  @override
  String toString() {
    return 'RewardsEvent.claimReward(rewardId: $rewardId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ClaimRewardImpl &&
            (identical(other.rewardId, rewardId) ||
                other.rewardId == rewardId));
  }

  @override
  int get hashCode => Object.hash(runtimeType, rewardId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ClaimRewardImplCopyWith<_$ClaimRewardImpl> get copyWith =>
      __$$ClaimRewardImplCopyWithImpl<_$ClaimRewardImpl>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String rewardId) claimReward,
    required TResult Function() rewardClaimed,
  }) {
    return claimReward(rewardId);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String rewardId)? claimReward,
    TResult? Function()? rewardClaimed,
  }) {
    return claimReward?.call(rewardId);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String rewardId)? claimReward,
    TResult Function()? rewardClaimed,
    required TResult orElse(),
  }) {
    if (claimReward != null) {
      return claimReward(rewardId);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(ClaimReward value) claimReward,
    required TResult Function(RewardClaimed value) rewardClaimed,
  }) {
    return claimReward(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(ClaimReward value)? claimReward,
    TResult? Function(RewardClaimed value)? rewardClaimed,
  }) {
    return claimReward?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(ClaimReward value)? claimReward,
    TResult Function(RewardClaimed value)? rewardClaimed,
    required TResult orElse(),
  }) {
    if (claimReward != null) {
      return claimReward(this);
    }
    return orElse();
  }
}

abstract class ClaimReward implements RewardsEvent {
  const factory ClaimReward(final String rewardId) = _$ClaimRewardImpl;

  String get rewardId;
  @JsonKey(ignore: true)
  _$$ClaimRewardImplCopyWith<_$ClaimRewardImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$RewardClaimedImplCopyWith<$Res> {
  factory _$$RewardClaimedImplCopyWith(
          _$RewardClaimedImpl value, $Res Function(_$RewardClaimedImpl) then) =
      __$$RewardClaimedImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$RewardClaimedImplCopyWithImpl<$Res>
    extends _$RewardsEventCopyWithImpl<$Res, _$RewardClaimedImpl>
    implements _$$RewardClaimedImplCopyWith<$Res> {
  __$$RewardClaimedImplCopyWithImpl(
      _$RewardClaimedImpl _value, $Res Function(_$RewardClaimedImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$RewardClaimedImpl implements RewardClaimed {
  const _$RewardClaimedImpl();

  @override
  String toString() {
    return 'RewardsEvent.rewardClaimed()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$RewardClaimedImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() loadRequested,
    required TResult Function() refreshRequested,
    required TResult Function(String rewardId) claimReward,
    required TResult Function() rewardClaimed,
  }) {
    return rewardClaimed();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? loadRequested,
    TResult? Function()? refreshRequested,
    TResult? Function(String rewardId)? claimReward,
    TResult? Function()? rewardClaimed,
  }) {
    return rewardClaimed?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? loadRequested,
    TResult Function()? refreshRequested,
    TResult Function(String rewardId)? claimReward,
    TResult Function()? rewardClaimed,
    required TResult orElse(),
  }) {
    if (rewardClaimed != null) {
      return rewardClaimed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(LoadRequested value) loadRequested,
    required TResult Function(RefreshRequested value) refreshRequested,
    required TResult Function(ClaimReward value) claimReward,
    required TResult Function(RewardClaimed value) rewardClaimed,
  }) {
    return rewardClaimed(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(LoadRequested value)? loadRequested,
    TResult? Function(RefreshRequested value)? refreshRequested,
    TResult? Function(ClaimReward value)? claimReward,
    TResult? Function(RewardClaimed value)? rewardClaimed,
  }) {
    return rewardClaimed?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(LoadRequested value)? loadRequested,
    TResult Function(RefreshRequested value)? refreshRequested,
    TResult Function(ClaimReward value)? claimReward,
    TResult Function(RewardClaimed value)? rewardClaimed,
    required TResult orElse(),
  }) {
    if (rewardClaimed != null) {
      return rewardClaimed(this);
    }
    return orElse();
  }
}

abstract class RewardClaimed implements RewardsEvent {
  const factory RewardClaimed() = _$RewardClaimedImpl;
}
