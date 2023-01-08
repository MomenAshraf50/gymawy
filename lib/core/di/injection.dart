import 'package:get_it/get_it.dart';
import 'package:gymawy/features/home/data/data_source/update_remote_data_source.dart';
import 'package:gymawy/features/home/data/repository/home_update_repository.dart';
import 'package:gymawy/features/home/domain/repository/home_update_base_repository.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/login/data/data_source/login_remote_data_source.dart';
import 'package:gymawy/features/login/data/repository/login_repository.dart';
import 'package:gymawy/features/login/domain/repository/login_base_rebository.dart';
import 'package:gymawy/features/login/domain/usecase/log_in_usecase.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/register/data/data_source/register_remote_data_source.dart';
import '../../features/register/data/repository/register_repository.dart';
import '../../features/register/domain/repository/register_base_rebository.dart';
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
  sl.registerLazySingleton<RegisterCubit>(() => RegisterCubit(
        registerUseCase: sl(),
      ));
  sl.registerLazySingleton<HomeCubit>(() => HomeCubit(
        updateCoachSocialLinks: sl(),
        updateProfilePicture: sl(),
        updateProfile: sl(),
      ));
  sl.registerLazySingleton<Repository>(
    () => RepoImplementation(
      dioHelper: sl(),
      cacheHelper: sl(),
    ),
  );

  // Repository
  sl.registerLazySingleton<LogInBaseRepository>(
    () => LoginRepoImplementation(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<RegisterBaseRepository>(
    () => RegisterRepoImplementation(remoteDataSource: sl()),
  );

  sl.registerLazySingleton<HomeUpdateBaseRepository>(
    () => HomeUpdateRepository(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfilePicture(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  sl.registerLazySingleton(() => UpdateCoachSocialLinks(sl()));

  //Data sources
  sl.registerLazySingleton<LogInBaseRemoteDataSource>(
    () => LogInRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<RegisterBaseRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<UpdateCoachBaseDataSource>(
    () => UpdateCoachDataSourceImpl(dioHelper: sl()),
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
