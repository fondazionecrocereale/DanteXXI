import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
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
    required String uid,
    required DateTime createdAt,
    // Web3 fields
    String? did, // Decentralized ID
    String? walletAddress, // Blockchain wallet address
    bool? isWeb3Enabled, // Whether user has enabled Web3 features
    required DateTime updatedAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
