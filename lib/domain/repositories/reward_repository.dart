import '../entities/reward.dart';

abstract class RewardRepository {
  Future<List<Reward>> getRewards();
  Future<Reward> getRewardById(String id);
  Future<Reward> claimReward(String id);
  Future<List<Reward>> getAvailableRewards();
  Future<List<Reward>> getClaimedRewards();
  Stream<List<Reward>> watchRewards();
}
