import 'package:freezed_annotation/freezed_annotation.dart';

part 'rewards_event.freezed.dart';

@freezed
class RewardsEvent with _$RewardsEvent {
  const factory RewardsEvent.loadRequested() = LoadRequested;
  const factory RewardsEvent.refreshRequested() = RefreshRequested;
  const factory RewardsEvent.claimReward(String rewardId) = ClaimReward;
  const factory RewardsEvent.rewardClaimed() = RewardClaimed;
}
