import 'package:get_it/get_it.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/login/presentation/controller/login_states.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/core/network/local/cache_helper.dart';
import '/core/network/remote/dio_helper.dart';
import '/core/network/repository.dart';
import '/core/util/cubit/cubit.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Bloc
  sl.registerLazySingleton(
    () => AppBloc(),
  );

  sl.registerLazySingleton<LoginCubit>(() => LoginCubit());
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit());
  //
  // sl.registerLazySingleton(
  //   () => CurrencyHistoryBloc(
  //     convertUseCase: sl(),
  //   ),
  // );

  // Repository
  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: sl(),
      cacheHelper: sl(),
    ),
  );

  // sl.registerLazySingleton<HomeRepository>(
  //   () => HomeRepoImplementation(
  //     remoteDataSource: sl(),
  //   ),
  // );
  //
  // sl.registerLazySingleton<CurrencyHistoryRepository>(
  //   () => CurrencyHistoryRepoImplementation(
  //     remoteDataSource: sl(),
  //   ),
  // );
  //
  // // Use cases
  // sl.registerLazySingleton(() => CountriesUseCase(sl()));
  //
  // sl.registerLazySingleton(() => ConvertUseCase(sl()));
  //
  // sl.registerLazySingleton(() => CurrencyHistoryUseCase(sl()));
  //
  // // Data sources
  // sl.registerLazySingleton<HomeRemoteDataSource>(
  //   () => HomeRemoteDataSourceImpl(
  //     dioHelper: sl(),
  //   ),
  // );
  //
  // sl.registerLazySingleton<CurrencyHistoryRemoteDataSource>(
  //   () => CurrencyHistoryRemoteDataSourceImpl(
  //     dioHelper: sl(),
  //   ),
  // );

  // Core
  sl.registerLazySingleton<DioHelper>(
    () => DioImpl(),
  );

  sl.registerLazySingleton<CacheHelper>(
    () => CacheImpl(
      sl(),
    ),
  );

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
