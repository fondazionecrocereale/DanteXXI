import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

import '../../domain/entities/reward.dart';
import '../../domain/repositories/reward_repository.dart';

@injectable
class RewardRepositoryImpl implements RewardRepository {
  late SharedPreferences _prefs;

  RewardRepositoryImpl() {
    _initPrefs();
  }

  Future<void> _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

  @override
  Future<List<Reward>> getRewards() async {
    try {
      final rewardsJson = _prefs.getStringList('rewards') ?? [];
      if (rewardsJson.isEmpty) {
        // Crear recompensas iniciales si no existen
        final initialRewards = _getInitialRewards();
        final rewardsJson = initialRewards
            .map((r) => jsonEncode(r.toJson()))
            .toList();
        await _prefs.setStringList('rewards', rewardsJson);
        return initialRewards;
      }
      return rewardsJson
          .map((json) => Reward.fromJson(jsonDecode(json)))
          .toList();
    } catch (e) {
      return _getInitialRewards();
    }
  }

  @override
  Future<Reward> getRewardById(String id) async {
    final rewards = await getRewards();
    return rewards.firstWhere((reward) => reward.id == id);
  }

  @override
  Future<Reward> claimReward(String id) async {
    final rewards = await getRewards();
    final rewardIndex = rewards.indexWhere((reward) => reward.id == id);

    if (rewardIndex == -1) {
      throw Exception('Recompensa no encontrada');
    }

    final reward = rewards[rewardIndex];
    if (!reward.canBeClaimed) {
      throw Exception('La recompensa no puede ser reclamada');
    }

    final claimedReward = reward.copyWith(
      status: RewardStatus.claimed,
      claimedAt: DateTime.now(),
    );

    rewards[rewardIndex] = claimedReward;
    final rewardsJson = rewards.map((r) => jsonEncode(r.toJson())).toList();
    await _prefs.setStringList('rewards', rewardsJson);

    return claimedReward;
  }

  @override
  Future<List<Reward>> getAvailableRewards() async {
    final rewards = await getRewards();
    return rewards.where((reward) => reward.canBeClaimed).toList();
  }

  @override
  Future<List<Reward>> getClaimedRewards() async {
    final rewards = await getRewards();
    return rewards
        .where((reward) => reward.status == RewardStatus.claimed)
        .toList();
  }

  @override
  Stream<List<Reward>> watchRewards() async* {
    // En una implementación real, esto podría usar WebSockets
    while (true) {
      yield await getRewards();
      await Future.delayed(const Duration(seconds: 30));
    }
  }

  List<Reward> _getInitialRewards() {
    return [
      Reward(
        id: '1',
        title: 'Bienvenido a Fiorino',
        description: 'Recompensa por registrarte en la plataforma',
        fiorinoAmount: 100000, // 0.1 FIORINO
        type: RewardType.achievement,
        status: RewardStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(days: 1)),
        expiresAt: DateTime.now().add(const Duration(days: 30)),
      ),
      Reward(
        id: '2',
        title: 'Primer Curso Completado',
        description: 'Completa tu primer curso de italiano',
        fiorinoAmount: 500000, // 0.5 FIORINO
        type: RewardType.courseCompletion,
        status: RewardStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        expiresAt: DateTime.now().add(const Duration(days: 7)),
        courseId: '1',
      ),
      Reward(
        id: '3',
        title: 'Login Diario',
        description: 'Inicia sesión por 3 días consecutivos',
        fiorinoAmount: 50000, // 0.05 FIORINO
        type: RewardType.dailyLogin,
        status: RewardStatus.claimed,
        createdAt: DateTime.now().subtract(const Duration(days: 3)),
        claimedAt: DateTime.now().subtract(const Duration(hours: 1)),
      ),
      Reward(
        id: '4',
        title: 'Racha de 7 días',
        description: 'Estudia italiano por 7 días consecutivos',
        fiorinoAmount: 1000000, // 1 FIORINO
        type: RewardType.streakBonus,
        status: RewardStatus.pending,
        createdAt: DateTime.now().subtract(const Duration(hours: 6)),
        expiresAt: DateTime.now().add(const Duration(days: 14)),
        metadata: {'streak_days': 5},
      ),
    ];
  }
}
