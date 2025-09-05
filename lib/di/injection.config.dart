// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dantexxi/data/repositories/reward_repository_impl.dart'
    as _i985;
import 'package:dantexxi/data/repositories/swap_repository_impl.dart' as _i592;
import 'package:dantexxi/data/repositories/transaction_repository_impl.dart'
    as _i1;
import 'package:dantexxi/data/repositories/wallet_repository_impl.dart'
    as _i792;
import 'package:dantexxi/data/services/blockchain_service.dart' as _i132;
import 'package:dantexxi/data/services/mercadopago_service.dart' as _i132;
import 'package:dantexxi/domain/repositories/reward_repository.dart' as _i692;
import 'package:dantexxi/domain/repositories/swap_repository.dart' as _i977;
import 'package:dantexxi/domain/repositories/transaction_repository.dart'
    as _i697;
import 'package:dantexxi/domain/repositories/wallet_repository.dart' as _i96;
import 'package:dantexxi/domain/usecases/reward/claim_reward_usecase.dart'
    as _i1019;
import 'package:dantexxi/domain/usecases/reward/get_rewards_usecase.dart'
    as _i336;
import 'package:dantexxi/domain/usecases/swap/create_swap_usecase.dart'
    as _i532;
import 'package:dantexxi/domain/usecases/swap/get_swaps_usecase.dart' as _i899;
import 'package:dantexxi/domain/usecases/transaction/get_transactions_usecase.dart'
    as _i430;
import 'package:dantexxi/domain/usecases/transaction/send_transaction_usecase.dart'
    as _i217;
import 'package:dantexxi/domain/usecases/wallet/get_balance_usecase.dart'
    as _i165;
import 'package:dantexxi/domain/usecases/wallet/refresh_balance_usecase.dart'
    as _i115;
import 'package:dantexxi/presentation/bloc/rewards/rewards_bloc.dart' as _i256;
import 'package:dantexxi/presentation/bloc/swap/swap_bloc.dart' as _i1035;
import 'package:dantexxi/presentation/bloc/transactions/transactions_bloc.dart'
    as _i219;
import 'package:dantexxi/presentation/bloc/wallet/wallet_bloc.dart' as _i364;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i985.RewardRepositoryImpl>(() => _i985.RewardRepositoryImpl());
    gh.factory<_i132.BlockchainService>(() => _i132.BlockchainService());
    gh.factory<_i132.MercadoPagoService>(() => _i132.MercadoPagoService());
    gh.factory<_i430.GetTransactionsUsecase>(
        () => _i430.GetTransactionsUsecase(gh<_i697.TransactionRepository>()));
    gh.factory<_i217.SendTransactionUsecase>(
        () => _i217.SendTransactionUsecase(gh<_i697.TransactionRepository>()));
    gh.factory<_i165.GetBalanceUsecase>(
        () => _i165.GetBalanceUsecase(gh<_i96.WalletRepository>()));
    gh.factory<_i115.RefreshBalanceUsecase>(
        () => _i115.RefreshBalanceUsecase(gh<_i96.WalletRepository>()));
    gh.factory<_i219.TransactionsBloc>(() => _i219.TransactionsBloc(
          gh<_i430.GetTransactionsUsecase>(),
          gh<_i217.SendTransactionUsecase>(),
        ));
    gh.factory<_i1.TransactionRepositoryImpl>(
        () => _i1.TransactionRepositoryImpl(gh<_i132.BlockchainService>()));
    gh.factory<_i792.WalletRepositoryImpl>(
        () => _i792.WalletRepositoryImpl(gh<_i132.BlockchainService>()));
    gh.factory<_i532.CreateSwapUsecase>(
        () => _i532.CreateSwapUsecase(gh<_i977.SwapRepository>()));
    gh.factory<_i899.GetSwapsUsecase>(
        () => _i899.GetSwapsUsecase(gh<_i977.SwapRepository>()));
    gh.factory<_i1019.ClaimRewardUsecase>(
        () => _i1019.ClaimRewardUsecase(gh<_i692.RewardRepository>()));
    gh.factory<_i336.GetRewardsUsecase>(
        () => _i336.GetRewardsUsecase(gh<_i692.RewardRepository>()));
    gh.factory<_i592.SwapRepositoryImpl>(() => _i592.SwapRepositoryImpl(
          gh<_i132.BlockchainService>(),
          gh<_i132.MercadoPagoService>(),
        ));
    gh.factory<_i1035.SwapBloc>(() => _i1035.SwapBloc(
          gh<_i899.GetSwapsUsecase>(),
          gh<_i532.CreateSwapUsecase>(),
        ));
    gh.factory<_i364.WalletBloc>(() => _i364.WalletBloc(
          gh<_i165.GetBalanceUsecase>(),
          gh<_i115.RefreshBalanceUsecase>(),
        ));
    gh.factory<_i256.RewardsBloc>(() => _i256.RewardsBloc(
          gh<_i336.GetRewardsUsecase>(),
          gh<_i1019.ClaimRewardUsecase>(),
        ));
    return this;
  }
}
