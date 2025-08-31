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

  // Blocs
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
      getCurrentUserUseCase: sl<GetCurrentUserUseCase>(),
    ),
  );
}
