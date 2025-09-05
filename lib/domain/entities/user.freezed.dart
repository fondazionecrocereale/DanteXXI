// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

User _$UserFromJson(Map<String, dynamic> json) {
  return _User.fromJson(json);
}

/// @nodoc
mixin _$User {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get firstName => throw _privateConstructorUsedError;
  String get lastName => throw _privateConstructorUsedError;
  String? get avatar => throw _privateConstructorUsedError;
  String? get level => throw _privateConstructorUsedError;
  int? get totalXP => throw _privateConstructorUsedError;
  int? get currentStreak => throw _privateConstructorUsedError;
  int? get longestStreak => throw _privateConstructorUsedError;
  int? get lessonsCompleted => throw _privateConstructorUsedError;
  int? get exercisesCompleted => throw _privateConstructorUsedError;
  int? get wordsLearned => throw _privateConstructorUsedError;
  DateTime? get joinDate => throw _privateConstructorUsedError;
  bool? get isPremium => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get credits => throw _privateConstructorUsedError;
  String? get currency => throw _privateConstructorUsedError;
  List<String>? get intereses => throw _privateConstructorUsedError;
  String? get language => throw _privateConstructorUsedError;
  DateTime? get lastSignIn => throw _privateConstructorUsedError;
  String get uid => throw _privateConstructorUsedError;
  DateTime get createdAt => throw _privateConstructorUsedError; // Web3 fields
  String? get did => throw _privateConstructorUsedError; // Decentralized ID
  String? get walletAddress =>
      throw _privateConstructorUsedError; // Blockchain wallet address
  bool? get isWeb3Enabled =>
      throw _privateConstructorUsedError; // Whether user has enabled Web3 features
  DateTime get updatedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserCopyWith<User> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserCopyWith<$Res> {
  factory $UserCopyWith(User value, $Res Function(User) then) =
      _$UserCopyWithImpl<$Res, User>;
  @useResult
  $Res call(
      {String id,
      String email,
      String firstName,
      String lastName,
      String? avatar,
      String? level,
      int? totalXP,
      int? currentStreak,
      int? longestStreak,
      int? lessonsCompleted,
      int? exercisesCompleted,
      int? wordsLearned,
      DateTime? joinDate,
      bool? isPremium,
      String? country,
      String? credits,
      String? currency,
      List<String>? intereses,
      String? language,
      DateTime? lastSignIn,
      String uid,
      DateTime createdAt,
      String? did,
      String? walletAddress,
      bool? isWeb3Enabled,
      DateTime updatedAt});
}

/// @nodoc
class _$UserCopyWithImpl<$Res, $Val extends User>
    implements $UserCopyWith<$Res> {
  _$UserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatar = freezed,
    Object? level = freezed,
    Object? totalXP = freezed,
    Object? currentStreak = freezed,
    Object? longestStreak = freezed,
    Object? lessonsCompleted = freezed,
    Object? exercisesCompleted = freezed,
    Object? wordsLearned = freezed,
    Object? joinDate = freezed,
    Object? isPremium = freezed,
    Object? country = freezed,
    Object? credits = freezed,
    Object? currency = freezed,
    Object? intereses = freezed,
    Object? language = freezed,
    Object? lastSignIn = freezed,
    Object? uid = null,
    Object? createdAt = null,
    Object? did = freezed,
    Object? walletAddress = freezed,
    Object? isWeb3Enabled = freezed,
    Object? updatedAt = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      totalXP: freezed == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStreak: freezed == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int?,
      longestStreak: freezed == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int?,
      lessonsCompleted: freezed == lessonsCompleted
          ? _value.lessonsCompleted
          : lessonsCompleted // ignore: cast_nullable_to_non_nullable
              as int?,
      exercisesCompleted: freezed == exercisesCompleted
          ? _value.exercisesCompleted
          : exercisesCompleted // ignore: cast_nullable_to_non_nullable
              as int?,
      wordsLearned: freezed == wordsLearned
          ? _value.wordsLearned
          : wordsLearned // ignore: cast_nullable_to_non_nullable
              as int?,
      joinDate: freezed == joinDate
          ? _value.joinDate
          : joinDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPremium: freezed == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      credits: freezed == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      intereses: freezed == intereses
          ? _value.intereses
          : intereses // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSignIn: freezed == lastSignIn
          ? _value.lastSignIn
          : lastSignIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      did: freezed == did
          ? _value.did
          : did // ignore: cast_nullable_to_non_nullable
              as String?,
      walletAddress: freezed == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      isWeb3Enabled: freezed == isWeb3Enabled
          ? _value.isWeb3Enabled
          : isWeb3Enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserImplCopyWith<$Res> implements $UserCopyWith<$Res> {
  factory _$$UserImplCopyWith(
          _$UserImpl value, $Res Function(_$UserImpl) then) =
      __$$UserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String firstName,
      String lastName,
      String? avatar,
      String? level,
      int? totalXP,
      int? currentStreak,
      int? longestStreak,
      int? lessonsCompleted,
      int? exercisesCompleted,
      int? wordsLearned,
      DateTime? joinDate,
      bool? isPremium,
      String? country,
      String? credits,
      String? currency,
      List<String>? intereses,
      String? language,
      DateTime? lastSignIn,
      String uid,
      DateTime createdAt,
      String? did,
      String? walletAddress,
      bool? isWeb3Enabled,
      DateTime updatedAt});
}

/// @nodoc
class __$$UserImplCopyWithImpl<$Res>
    extends _$UserCopyWithImpl<$Res, _$UserImpl>
    implements _$$UserImplCopyWith<$Res> {
  __$$UserImplCopyWithImpl(_$UserImpl _value, $Res Function(_$UserImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? firstName = null,
    Object? lastName = null,
    Object? avatar = freezed,
    Object? level = freezed,
    Object? totalXP = freezed,
    Object? currentStreak = freezed,
    Object? longestStreak = freezed,
    Object? lessonsCompleted = freezed,
    Object? exercisesCompleted = freezed,
    Object? wordsLearned = freezed,
    Object? joinDate = freezed,
    Object? isPremium = freezed,
    Object? country = freezed,
    Object? credits = freezed,
    Object? currency = freezed,
    Object? intereses = freezed,
    Object? language = freezed,
    Object? lastSignIn = freezed,
    Object? uid = null,
    Object? createdAt = null,
    Object? did = freezed,
    Object? walletAddress = freezed,
    Object? isWeb3Enabled = freezed,
    Object? updatedAt = null,
  }) {
    return _then(_$UserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      firstName: null == firstName
          ? _value.firstName
          : firstName // ignore: cast_nullable_to_non_nullable
              as String,
      lastName: null == lastName
          ? _value.lastName
          : lastName // ignore: cast_nullable_to_non_nullable
              as String,
      avatar: freezed == avatar
          ? _value.avatar
          : avatar // ignore: cast_nullable_to_non_nullable
              as String?,
      level: freezed == level
          ? _value.level
          : level // ignore: cast_nullable_to_non_nullable
              as String?,
      totalXP: freezed == totalXP
          ? _value.totalXP
          : totalXP // ignore: cast_nullable_to_non_nullable
              as int?,
      currentStreak: freezed == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int?,
      longestStreak: freezed == longestStreak
          ? _value.longestStreak
          : longestStreak // ignore: cast_nullable_to_non_nullable
              as int?,
      lessonsCompleted: freezed == lessonsCompleted
          ? _value.lessonsCompleted
          : lessonsCompleted // ignore: cast_nullable_to_non_nullable
              as int?,
      exercisesCompleted: freezed == exercisesCompleted
          ? _value.exercisesCompleted
          : exercisesCompleted // ignore: cast_nullable_to_non_nullable
              as int?,
      wordsLearned: freezed == wordsLearned
          ? _value.wordsLearned
          : wordsLearned // ignore: cast_nullable_to_non_nullable
              as int?,
      joinDate: freezed == joinDate
          ? _value.joinDate
          : joinDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      isPremium: freezed == isPremium
          ? _value.isPremium
          : isPremium // ignore: cast_nullable_to_non_nullable
              as bool?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      credits: freezed == credits
          ? _value.credits
          : credits // ignore: cast_nullable_to_non_nullable
              as String?,
      currency: freezed == currency
          ? _value.currency
          : currency // ignore: cast_nullable_to_non_nullable
              as String?,
      intereses: freezed == intereses
          ? _value._intereses
          : intereses // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      language: freezed == language
          ? _value.language
          : language // ignore: cast_nullable_to_non_nullable
              as String?,
      lastSignIn: freezed == lastSignIn
          ? _value.lastSignIn
          : lastSignIn // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      uid: null == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      did: freezed == did
          ? _value.did
          : did // ignore: cast_nullable_to_non_nullable
              as String?,
      walletAddress: freezed == walletAddress
          ? _value.walletAddress
          : walletAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      isWeb3Enabled: freezed == isWeb3Enabled
          ? _value.isWeb3Enabled
          : isWeb3Enabled // ignore: cast_nullable_to_non_nullable
              as bool?,
      updatedAt: null == updatedAt
          ? _value.updatedAt
          : updatedAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserImpl implements _User {
  const _$UserImpl(
      {required this.id,
      required this.email,
      required this.firstName,
      required this.lastName,
      this.avatar,
      this.level,
      this.totalXP,
      this.currentStreak,
      this.longestStreak,
      this.lessonsCompleted,
      this.exercisesCompleted,
      this.wordsLearned,
      this.joinDate,
      this.isPremium,
      this.country,
      this.credits,
      this.currency,
      final List<String>? intereses,
      this.language,
      this.lastSignIn,
      required this.uid,
      required this.createdAt,
      this.did,
      this.walletAddress,
      this.isWeb3Enabled,
      required this.updatedAt})
      : _intereses = intereses;

  factory _$UserImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String firstName;
  @override
  final String lastName;
  @override
  final String? avatar;
  @override
  final String? level;
  @override
  final int? totalXP;
  @override
  final int? currentStreak;
  @override
  final int? longestStreak;
  @override
  final int? lessonsCompleted;
  @override
  final int? exercisesCompleted;
  @override
  final int? wordsLearned;
  @override
  final DateTime? joinDate;
  @override
  final bool? isPremium;
  @override
  final String? country;
  @override
  final String? credits;
  @override
  final String? currency;
  final List<String>? _intereses;
  @override
  List<String>? get intereses {
    final value = _intereses;
    if (value == null) return null;
    if (_intereses is EqualUnmodifiableListView) return _intereses;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? language;
  @override
  final DateTime? lastSignIn;
  @override
  final String uid;
  @override
  final DateTime createdAt;
// Web3 fields
  @override
  final String? did;
// Decentralized ID
  @override
  final String? walletAddress;
// Blockchain wallet address
  @override
  final bool? isWeb3Enabled;
// Whether user has enabled Web3 features
  @override
  final DateTime updatedAt;

  @override
  String toString() {
    return 'User(id: $id, email: $email, firstName: $firstName, lastName: $lastName, avatar: $avatar, level: $level, totalXP: $totalXP, currentStreak: $currentStreak, longestStreak: $longestStreak, lessonsCompleted: $lessonsCompleted, exercisesCompleted: $exercisesCompleted, wordsLearned: $wordsLearned, joinDate: $joinDate, isPremium: $isPremium, country: $country, credits: $credits, currency: $currency, intereses: $intereses, language: $language, lastSignIn: $lastSignIn, uid: $uid, createdAt: $createdAt, did: $did, walletAddress: $walletAddress, isWeb3Enabled: $isWeb3Enabled, updatedAt: $updatedAt)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.firstName, firstName) ||
                other.firstName == firstName) &&
            (identical(other.lastName, lastName) ||
                other.lastName == lastName) &&
            (identical(other.avatar, avatar) || other.avatar == avatar) &&
            (identical(other.level, level) || other.level == level) &&
            (identical(other.totalXP, totalXP) || other.totalXP == totalXP) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.longestStreak, longestStreak) ||
                other.longestStreak == longestStreak) &&
            (identical(other.lessonsCompleted, lessonsCompleted) ||
                other.lessonsCompleted == lessonsCompleted) &&
            (identical(other.exercisesCompleted, exercisesCompleted) ||
                other.exercisesCompleted == exercisesCompleted) &&
            (identical(other.wordsLearned, wordsLearned) ||
                other.wordsLearned == wordsLearned) &&
            (identical(other.joinDate, joinDate) ||
                other.joinDate == joinDate) &&
            (identical(other.isPremium, isPremium) ||
                other.isPremium == isPremium) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.credits, credits) || other.credits == credits) &&
            (identical(other.currency, currency) ||
                other.currency == currency) &&
            const DeepCollectionEquality()
                .equals(other._intereses, _intereses) &&
            (identical(other.language, language) ||
                other.language == language) &&
            (identical(other.lastSignIn, lastSignIn) ||
                other.lastSignIn == lastSignIn) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.did, did) || other.did == did) &&
            (identical(other.walletAddress, walletAddress) ||
                other.walletAddress == walletAddress) &&
            (identical(other.isWeb3Enabled, isWeb3Enabled) ||
                other.isWeb3Enabled == isWeb3Enabled) &&
            (identical(other.updatedAt, updatedAt) ||
                other.updatedAt == updatedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        email,
        firstName,
        lastName,
        avatar,
        level,
        totalXP,
        currentStreak,
        longestStreak,
        lessonsCompleted,
        exercisesCompleted,
        wordsLearned,
        joinDate,
        isPremium,
        country,
        credits,
        currency,
        const DeepCollectionEquality().hash(_intereses),
        language,
        lastSignIn,
        uid,
        createdAt,
        did,
        walletAddress,
        isWeb3Enabled,
        updatedAt
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      __$$UserImplCopyWithImpl<_$UserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserImplToJson(
      this,
    );
  }
}

abstract class _User implements User {
  const factory _User(
      {required final String id,
      required final String email,
      required final String firstName,
      required final String lastName,
      final String? avatar,
      final String? level,
      final int? totalXP,
      final int? currentStreak,
      final int? longestStreak,
      final int? lessonsCompleted,
      final int? exercisesCompleted,
      final int? wordsLearned,
      final DateTime? joinDate,
      final bool? isPremium,
      final String? country,
      final String? credits,
      final String? currency,
      final List<String>? intereses,
      final String? language,
      final DateTime? lastSignIn,
      required final String uid,
      required final DateTime createdAt,
      final String? did,
      final String? walletAddress,
      final bool? isWeb3Enabled,
      required final DateTime updatedAt}) = _$UserImpl;

  factory _User.fromJson(Map<String, dynamic> json) = _$UserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get firstName;
  @override
  String get lastName;
  @override
  String? get avatar;
  @override
  String? get level;
  @override
  int? get totalXP;
  @override
  int? get currentStreak;
  @override
  int? get longestStreak;
  @override
  int? get lessonsCompleted;
  @override
  int? get exercisesCompleted;
  @override
  int? get wordsLearned;
  @override
  DateTime? get joinDate;
  @override
  bool? get isPremium;
  @override
  String? get country;
  @override
  String? get credits;
  @override
  String? get currency;
  @override
  List<String>? get intereses;
  @override
  String? get language;
  @override
  DateTime? get lastSignIn;
  @override
  String get uid;
  @override
  DateTime get createdAt;
  @override // Web3 fields
  String? get did;
  @override // Decentralized ID
  String? get walletAddress;
  @override // Blockchain wallet address
  bool? get isWeb3Enabled;
  @override // Whether user has enabled Web3 features
  DateTime get updatedAt;
  @override
  @JsonKey(ignore: true)
  _$$UserImplCopyWith<_$UserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
