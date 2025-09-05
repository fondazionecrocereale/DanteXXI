import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:logger/logger.dart';

import '../core/network/dio_client.dart';
import '../data/datasources/auth_datasource.dart';
import '../data/repositories/auth_repository_impl.dart' as data;
import '../domain/repositories/auth_repository.dart';
import '../domain/usecases/auth_usecases.dart';
import '../presentation/blocs/auth/auth_bloc.dart';

// Wallet imports
import '../data/services/blockchain_service.dart';
import '../data/services/mercadopago_service.dart';
import '../data/repositories/wallet_repository_impl.dart';
import '../data/repositories/transaction_repository_impl.dart';
import '../data/repositories/swap_repository_impl.dart';
import '../data/repositories/reward_repository_impl.dart';
import '../domain/repositories/wallet_repository.dart';
import '../domain/repositories/transaction_repository.dart';
import '../domain/repositories/swap_repository.dart';
import '../domain/repositories/reward_repository.dart';
import '../domain/usecases/wallet/get_balance_usecase.dart';
import '../domain/usecases/wallet/refresh_balance_usecase.dart';
import '../domain/usecases/transaction/send_transaction_usecase.dart';
import '../domain/usecases/transaction/get_transactions_usecase.dart';
import '../domain/usecases/swap/create_swap_usecase.dart';
import '../domain/usecases/swap/get_swaps_usecase.dart';
import '../domain/usecases/reward/get_rewards_usecase.dart';
import '../domain/usecases/reward/claim_reward_usecase.dart';
import '../presentation/bloc/wallet/wallet_bloc.dart';
import '../presentation/bloc/transactions/transactions_bloc.dart';
import '../presentation/bloc/swap/swap_bloc.dart';
import '../presentation/bloc/rewards/rewards_bloc.dart';

// Teacher imports
import '../data/repositories/teacher_repository_impl.dart';
import '../domain/repositories/teacher_repository.dart';
import '../domain/usecases/teacher_usecases.dart';
import '../presentation/blocs/teacher/teacher_bloc.dart';

final GetIt sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton<Logger>(() => Logger());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl<Logger>()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

  // Hive
  await Hive.initFlutter();
  sl.registerLazySingleton<HiveInterface>(() => Hive);

  // Data sources
  sl.registerLazySingleton<AuthDataSource>(
    () => AuthDataSourceImpl(sl<DioClient>()),
  );

  // Repositories
  sl.registerLazySingleton<AuthRepository>(
    () => data.AuthRepositoryImpl(sl<AuthDataSource>()),
  );

  // Use cases
  sl.registerLazySingleton<LoginUseCase>(
    () => LoginUseCaseImpl(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<RegisterUseCase>(
    () => RegisterUseCaseImpl(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<LogoutUseCase>(
    () => LogoutUseCaseImpl(sl<AuthRepository>()),
  );
  sl.registerLazySingleton<GetCurrentUserUseCase>(
    () => GetCurrentUserUseCaseImpl(sl<AuthRepository>()),
  );

  // Wallet services
  sl.registerLazySingleton<BlockchainService>(() => BlockchainService());
  sl.registerLazySingleton<MercadoPagoService>(() => MercadoPagoService());

  // Wallet repositories
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(sl<BlockchainService>()),
  );
  sl.registerLazySingleton<TransactionRepository>(
    () => TransactionRepositoryImpl(sl<BlockchainService>()),
  );
  sl.registerLazySingleton<SwapRepository>(
    () => SwapRepositoryImpl(sl<BlockchainService>(), sl<MercadoPagoService>()),
  );
  sl.registerLazySingleton<RewardRepository>(() => RewardRepositoryImpl());

  // Teacher repositories
  sl.registerLazySingleton<TeacherRepository>(() => TeacherRepositoryImpl());

  // Wallet use cases
  sl.registerLazySingleton<GetBalanceUsecase>(
    () => GetBalanceUsecase(sl<WalletRepository>()),
  );
  sl.registerLazySingleton<RefreshBalanceUsecase>(
    () => RefreshBalanceUsecase(sl<WalletRepository>()),
  );
  sl.registerLazySingleton<SendTransactionUsecase>(
    () => SendTransactionUsecase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton<GetTransactionsUsecase>(
    () => GetTransactionsUsecase(sl<TransactionRepository>()),
  );
  sl.registerLazySingleton<CreateSwapUsecase>(
    () => CreateSwapUsecase(sl<SwapRepository>()),
  );
  sl.registerLazySingleton<GetSwapsUsecase>(
    () => GetSwapsUsecase(sl<SwapRepository>()),
  );
  sl.registerLazySingleton<GetRewardsUsecase>(
    () => GetRewardsUsecase(sl<RewardRepository>()),
  );
  sl.registerLazySingleton<ClaimRewardUsecase>(
    () => ClaimRewardUsecase(sl<RewardRepository>()),
  );

  // Teacher use cases
  sl.registerLazySingleton<GetTeachersUseCase>(
    () => GetTeachersUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetTeacherByIdUseCase>(
    () => GetTeacherByIdUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetFeaturedTeachersUseCase>(
    () => GetFeaturedTeachersUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<SearchTeachersUseCase>(
    () => SearchTeachersUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetTeacherCoursesUseCase>(
    () => GetTeacherCoursesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetFeaturedCoursesUseCase>(
    () => GetFeaturedCoursesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetFreeCoursesUseCase>(
    () => GetFreeCoursesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetPaidCoursesUseCase>(
    () => GetPaidCoursesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetCourseByIdUseCase>(
    () => GetCourseByIdUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<SearchCoursesUseCase>(
    () => SearchCoursesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetTeacherArticlesUseCase>(
    () => GetTeacherArticlesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetFeaturedArticlesUseCase>(
    () => GetFeaturedArticlesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetLatestArticlesUseCase>(
    () => GetLatestArticlesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetArticleByIdUseCase>(
    () => GetArticleByIdUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<SearchArticlesUseCase>(
    () => SearchArticlesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<PurchaseCourseUseCase>(
    () => PurchaseCourseUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<GetUserPurchasesUseCase>(
    () => GetUserPurchasesUseCase(sl<TeacherRepository>()),
  );
  sl.registerLazySingleton<IsCoursePurchasedUseCase>(
    () => IsCoursePurchasedUseCase(sl<TeacherRepository>()),
  );

  // Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );

  // Wallet BLoCs
  sl.registerFactory<WalletBloc>(
    () => WalletBloc(sl<GetBalanceUsecase>(), sl<RefreshBalanceUsecase>()),
  );
  sl.registerFactory<TransactionsBloc>(
    () => TransactionsBloc(
      sl<GetTransactionsUsecase>(),
      sl<SendTransactionUsecase>(),
    ),
  );
  sl.registerFactory<SwapBloc>(
    () => SwapBloc(sl<GetSwapsUsecase>(), sl<CreateSwapUsecase>()),
  );
  sl.registerFactory<RewardsBloc>(
    () => RewardsBloc(sl<GetRewardsUsecase>(), sl<ClaimRewardUsecase>()),
  );
  sl.registerFactory<TeacherBloc>(
    () => TeacherBloc(
      getTeachersUseCase: sl<GetTeachersUseCase>(),
      getTeacherByIdUseCase: sl<GetTeacherByIdUseCase>(),
      getFeaturedTeachersUseCase: sl<GetFeaturedTeachersUseCase>(),
      searchTeachersUseCase: sl<SearchTeachersUseCase>(),
      getTeacherCoursesUseCase: sl<GetTeacherCoursesUseCase>(),
      getFeaturedCoursesUseCase: sl<GetFeaturedCoursesUseCase>(),
      getFreeCoursesUseCase: sl<GetFreeCoursesUseCase>(),
      getPaidCoursesUseCase: sl<GetPaidCoursesUseCase>(),
      getCourseByIdUseCase: sl<GetCourseByIdUseCase>(),
      searchCoursesUseCase: sl<SearchCoursesUseCase>(),
      getTeacherArticlesUseCase: sl<GetTeacherArticlesUseCase>(),
      getFeaturedArticlesUseCase: sl<GetFeaturedArticlesUseCase>(),
      getLatestArticlesUseCase: sl<GetLatestArticlesUseCase>(),
      getArticleByIdUseCase: sl<GetArticleByIdUseCase>(),
      searchArticlesUseCase: sl<SearchArticlesUseCase>(),
      purchaseCourseUseCase: sl<PurchaseCourseUseCase>(),
      getUserPurchasesUseCase: sl<GetUserPurchasesUseCase>(),
      isCoursePurchasedUseCase: sl<IsCoursePurchasedUseCase>(),
    ),
  );
}
