import 'package:freezed_annotation/freezed_annotation.dart';

part 'editable_profile.freezed.dart';
part 'editable_profile.g.dart';

@freezed
class EditableProfile with _$EditableProfile {
  const factory EditableProfile({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? avatar,
    String? level,
    String? country,
    String? language,
    List<String>? interests,
    String? bio,
    DateTime? birthDate,
    String? phoneNumber,
    String? timezone,
    bool? emailNotifications,
    bool? pushNotifications,
    String? learningGoal,
    int? dailyGoalMinutes,
  }) = _EditableProfile;

  factory EditableProfile.fromJson(Map<String, dynamic> json) =>
      _$EditableProfileFromJson(json);
}

@freezed
class ProfileUpdateRequest with _$ProfileUpdateRequest {
  const factory ProfileUpdateRequest({
    String? firstName,
    String? lastName,
    String? avatar,
    String? level,
    String? country,
    String? language,
    List<String>? interests,
    String? bio,
    DateTime? birthDate,
    String? phoneNumber,
    String? timezone,
    bool? emailNotifications,
    bool? pushNotifications,
    String? learningGoal,
    int? dailyGoalMinutes,
  }) = _ProfileUpdateRequest;

  factory ProfileUpdateRequest.fromJson(Map<String, dynamic> json) =>
      _$ProfileUpdateRequestFromJson(json);
}
