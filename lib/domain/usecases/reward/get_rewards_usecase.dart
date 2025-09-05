import 'package:injectable/injectable.dart';

import '../../entities/reward.dart';
import '../../repositories/reward_repository.dart';

@injectable
class GetRewardsUsecase {
  final RewardRepository _rewardRepository;

  GetRewardsUsecase(this._rewardRepository);

  Future<List<Reward>> call() async {
    return await _rewardRepository.getRewards();
  }
}
