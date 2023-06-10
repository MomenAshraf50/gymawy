import 'package:get_it/get_it.dart';
import 'package:gymawy/features/home/data/data_source/home_remote_data_source.dart';
import 'package:gymawy/features/home/data/repository/home_repository.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_details.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/add_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_user_plan_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/get_coach_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_notifications_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_user-plan_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/mark_as_read_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/notifications_subscription_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/search_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/subscription_request_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_subscription_status_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/user_plan_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/login/data/data_source/login_remote_data_source.dart';
import 'package:gymawy/features/login/data/repository/login_repository.dart';
import 'package:gymawy/features/login/domain/repository/login_base_rebository.dart';
import 'package:gymawy/features/login/domain/usecase/log_in_usecase.dart';
import 'package:gymawy/features/login/presentation/controller/login_cubit.dart';
import 'package:gymawy/features/register/presentation/controller/register_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/home/domain/usecase/add_nutrition_details_usecase.dart';
import '../../features/home/domain/usecase/add_plan_usecase.dart';
import '../../features/home/domain/usecase/certification_usecase.dart';
import '../../features/home/domain/usecase/delete_certification_usecase.dart';
import '../../features/home/domain/usecase/delete_exercise_details_usecase.dart';
import '../../features/home/domain/usecase/delete_exersice_plan_usecase.dart';
import '../../features/home/domain/usecase/delete_subscriptionRequest_usecase.dart';
import '../../features/home/domain/usecase/get_exercise_plan_details.dart';
import '../../features/home/domain/usecase/get_nutrition_details.dart';
import '../../features/home/domain/usecase/get_plan_usecase.dart';
import '../../features/home/domain/usecase/get_exercise_usecase.dart';
import '../../features/home/domain/usecase/profile_training_usecase.dart';
import '../../features/home/domain/usecase/update_exercise_plan_usecase.dart';
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
        searchUseCase: sl(),
        profileUseCase: sl(),
        profileTrainerUseCase: sl(),
        certificateUseCase: sl(),
        getCertificateUseCase: sl(),
        deleteCertificateUseCase: sl(),
        updateCertificateUseCase: sl(),
        addExerciseUseCase: sl(),
        getExerciseUseCase: sl(),
        updateExerciseUseCase: sl(),
        deleteExerciseUseCase: sl(),
        addExercisePlanUseCase: sl(),
        getExercisePlanUseCase: sl(),
        updateExercisePlanUseCase: sl(),
        deleteExercisePlanUseCase: sl(),
        addExerciseDetailsUseCase: sl(),
        getExercisePlanDetailsUseCase: sl(),
        deleteExercisePlanDetailsUseCase: sl(),
        addNutritionUseCase: sl(),
        getNutritionUseCase: sl(),
        deleteNutritionUseCase: sl(),
        addNutritionDetailsUseCase: sl(),
        getNutritionPlanDetailsUseCase: sl(),
        subscriptionRequestUseCase: sl(),
        getSubscriptionUseCase: sl(),
        deleteSubscriptionRequestUseCase: sl(),
        getNotificationsUseCase: sl(),
        markAsReadUseCase: sl(),
        getCoachSubscriptionsUseCase: sl(),
        updateSubscriptionStatusUseCase: sl(),
        notificationsSubscriptionUseCase: sl(),
        bodyMeasurementsUseCase: sl(),
        deleteBodyMeasurementsUseCase: sl(),
        getBodyMeasurementsUseCase: sl(),
        deleteUserPlanUseCase: sl(),
        getUserPlanUseCase: sl(),
        userPlanUseCase: sl(),
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

  sl.registerLazySingleton<HomeBaseRepository>(
    () => HomeRepository(remoteDataSource: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl()));
  sl.registerLazySingleton(() => RegisterUseCase(sl()));
  sl.registerLazySingleton(() => UpdateProfilePicture(sl()));
  sl.registerLazySingleton(() => UpdateProfile(sl()));
  sl.registerLazySingleton(() => UpdateCoachSocialLinks(sl()));
  sl.registerLazySingleton(() => SearchUseCase(sl()));
  sl.registerLazySingleton(() => ProfileUseCase(sl()));
  sl.registerLazySingleton(() => ProfileTrainerUseCase(sl()));
  sl.registerLazySingleton(() => CertificateUseCase(sl()));
  sl.registerLazySingleton(() => GetCertificateUseCase(sl()));
  sl.registerLazySingleton(() => DeleteCertificateUseCase(sl()));
  sl.registerLazySingleton(() => UpdateCertificateUseCase(sl()));
  sl.registerLazySingleton(() => AddExerciseUseCase(sl()));
  sl.registerLazySingleton(() => GetExerciseUseCase(sl()));
  sl.registerLazySingleton(() => UpdateExerciseUseCase(sl()));
  sl.registerLazySingleton(() => DeleteExerciseUseCase(sl()));
  sl.registerLazySingleton(() => AddExercisePlanUseCase(sl()));
  sl.registerLazySingleton(() => GetPlanUseCase(sl()));
  sl.registerLazySingleton(() => UpdateExercisePlanUseCase(sl()));
  sl.registerLazySingleton(() => DeleteExercisePlanUseCase(sl()));
  sl.registerLazySingleton(() => AddExerciseDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetExercisePlanDetailsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteExercisePlanDetailsUseCase(sl()));
  sl.registerLazySingleton(() => AddNutritionUseCase(sl()));
  sl.registerLazySingleton(() => GetNutritionUseCase(sl()));
  sl.registerLazySingleton(() => DeleteNutritionUseCase(sl()));
  sl.registerLazySingleton(() => AddNutritionDetailsUseCase(sl()));
  sl.registerLazySingleton(() => GetNutritionPlanDetailsUseCase(sl()));
  sl.registerLazySingleton(() => SubscriptionRequestUseCase(sl()));
  sl.registerLazySingleton(() => GetSubscriptionUseCase(sl()));
  sl.registerLazySingleton(() => DeleteSubscriptionRequestUseCase(sl()));
  sl.registerLazySingleton(() => GetNotificationsUseCase(sl()));
  sl.registerLazySingleton(() => MarkAsReadUseCase(sl()));
  sl.registerLazySingleton(() => GetCoachSubscriptionsUseCase(sl()));
  sl.registerLazySingleton(() => UpdateSubscriptionStatusUseCase(sl()));
  sl.registerLazySingleton(() => NotificationsSubscriptionUseCase(sl()));
  sl.registerLazySingleton(() => GetBodyMeasurementsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteBodyMeasurementsUseCase(sl()));
  sl.registerLazySingleton(() => BodyMeasurementsUseCase(sl()));
  sl.registerLazySingleton(() => DeleteUserPlanUseCase(sl()));
  sl.registerLazySingleton(() => GetUserPlanUseCase(sl()));
  sl.registerLazySingleton(() => UserPlanUseCase(sl()));

  //Data sources
  sl.registerLazySingleton<LogInBaseRemoteDataSource>(
    () => LogInRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<RegisterBaseRemoteDataSource>(
    () => RegisterRemoteDataSourceImpl(dioHelper: sl()),
  );

  sl.registerLazySingleton<HomeBaseDataSource>(
    () => HomeDataSourceImpl(dioHelper: sl()),
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
