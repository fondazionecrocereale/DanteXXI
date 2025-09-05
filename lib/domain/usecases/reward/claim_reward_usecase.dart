import 'package:injectable/injectable.dart';

import '../../entities/reward.dart';
import '../../repositories/reward_repository.dart';

@injectable
class ClaimRewardUsecase {
  final RewardRepository _rewardRepository;

  ClaimRewardUsecase(this._rewardRepository);

  Future<Reward> call(String rewardId) async {
    return await _rewardRepository.claimReward(rewardId);
  }
}
