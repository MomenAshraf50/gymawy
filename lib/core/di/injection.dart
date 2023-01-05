import 'package:get_it/get_it.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/login/data/data_source/login_remote_data_source.dart';
import 'package:gymawy/features/login/data/repository/login_repository.dart';
import 'package:gymawy/features/login/domain/repository/login_base_rebository.dart';
import 'package:gymawy/features/login/domain/usecase/log_in_usecase.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../features/register/data/data_source/register_coach_remote_data_source.dart';
import '../../features/register/data/data_source/register_remote_data_source.dart';
import '../../features/register/data/repository/register_coach_repository.dart';
import '../../features/register/data/repository/register_repository.dart';
import '../../features/register/domain/repository/register_base_rebository.dart';
import '../../features/register/domain/repository/register_coach_base_rebository.dart';
import '../../features/register/domain/usecase/register_coach_usecase.dart';
import '../../features/register/domain/usecase/register_usecase.dart';
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

  sl.registerLazySingleton<LoginCubit>(() => LoginCubit(logInUseCase: sl()));
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(registerUseCase: sl(), registerCoachUseCase: sl()));
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit() );
  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<LogInBaseRepository>(
    () => LoginRepository(sl()),
  );


  // Use cases
  sl.registerLazySingleton(() => LogInUseCase(sl()));



  //Data sources
   sl.registerLazySingleton<LogInBaseRemoteDataSource>(
     () => LogInRemoteDataSource(sl()),
   );

  // Repository
  sl.registerLazySingleton<RegisterBaseRepository>(
        () => RegisterRepository(sl()),
  );


  // Use cases
  sl.registerLazySingleton(() => RegisterUseCase(sl()));



  //Data sources
  sl.registerLazySingleton<RegisterBaseRemoteDataSource>(
        () => RegisterRemoteDataSource(sl()),
  );

  // Repository
  sl.registerLazySingleton<RegisterCoachBaseRepository>(
        () => RegisterCoachRepository(sl()),
  );


  // Use cases
  sl.registerLazySingleton(() => RegisterCoachUseCase(sl()));



  //Data sources
  sl.registerLazySingleton<RegisterCoachBaseRemoteDataSource>(
        () => RegisterCoachRemoteDataSource(sl()),
  );


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
