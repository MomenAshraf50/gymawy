import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymawy/features/home/data/data_source/home_remote_data_source.dart';
import 'package:gymawy/features/home/domain/entities/add_exercise_entity.dart';
import 'package:gymawy/features/home/domain/entities/body_measurements_entity.dart';
import 'package:gymawy/features/home/domain/entities/coach_subscriptions_entity.dart';
import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';
import 'package:gymawy/features/home/domain/entities/notifications_entity.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/search_entity.dart';
import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';
import 'package:gymawy/features/home/domain/entities/user_plan_entity.dart';
import 'package:gymawy/features/home/domain/usecase/body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/certification_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_user_plan_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_body_measurements_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/notifications_subscription_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_subscription_status_usecase.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_details.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/get_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/mark_as_read_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/subscription_request_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/user_plan_usecase.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/add_exercise_plan_entity.dart';
import '../../domain/entities/add_nutrition_details_entity.dart';
import '../../domain/entities/add_nutrition_entity.dart';
import '../../domain/entities/certificate_entity.dart';
import '../../domain/usecase/add_nutrition_details_usecase.dart';
import '../../domain/usecase/add_plan_usecase.dart';
import '../../domain/usecase/delete_exercise_details_usecase.dart';
import '../../domain/usecase/delete_exersice_plan_usecase.dart';
import '../../domain/usecase/delete_subscriptionRequest_usecase.dart';
import '../../domain/usecase/get_exercise_plan_details.dart';
import '../../domain/usecase/get_nutrition_details.dart';
import '../../domain/usecase/get_nutrition_usecase.dart';
import '../../domain/usecase/get_plan_usecase.dart';

typedef Call = Future<ProfileEntity> Function();
typedef CallSearch = Future<List<SearchEntity>> Function();
typedef CallProfile = Future<ProfileEntity> Function();
typedef CallCertification = Future<CertificateEntity> Function();
typedef CallGetCertification = Future<List<CertificateEntity>> Function();
typedef CallDeleteCertification = Future<void> Function();
typedef CallExercise = Future<AddExerciseEntity> Function();
typedef CallGetExercise = Future<List<AddExerciseEntity>> Function();
typedef CallDeleteExercise = Future<void> Function();
typedef CallAddExercisePlan = Future<AddPlanEntity> Function();
typedef CallGetExercisePlan = Future<List<AddPlanEntity>> Function();
typedef CallDeleteExercisePlan = Future<void> Function();
typedef CallAddExerciseDetails = Future<ExerciseDetailsEntity> Function();
typedef CallGetExerciseDetails = Future<List<ExerciseDetailsEntity>> Function();
typedef CallDeleteExercisePlanDetails = Future<void> Function();
typedef CallAddNutrition = Future<AddNutritionEntity> Function();
typedef CallGetNutrition = Future<List<AddNutritionEntity>> Function();
typedef CallDeleteNutrition = Future<List<AddNutritionEntity>> Function();
typedef CallAddNutritionDetails = Future<NutritionDetailsEntity> Function();
typedef CallGetNutritionDetails = Future<List<NutritionDetailsEntity>> Function();
typedef CallSubscriptionRequest = Future<SubscriptionRequestEntity> Function();
typedef CallGetSubscriptionRequests = Future<List<SubscriptionRequestEntity>> Function();
typedef CallDeleteSubscriptionRequest = Future<void> Function();
typedef CallGetNotifications = Future<List<NotificationsEntity>> Function();
typedef CallMarkAsRead = Future<void> Function();
typedef CallGetCoachSubscriptions = Future<List<CoachSubscriptionsEntity>> Function();
typedef CallUpdateSubscriptionStatus = Future<CoachSubscriptionsEntity> Function();
typedef CallNotificationsSubscriptions = Future<void> Function();
typedef CallBodyMeasurements = Future<BodyMeasurementsEntity> Function();
typedef CallGetBodyMeasurements = Future<List<BodyMeasurementsEntity>> Function();
typedef CallDeleteBodyMeasurements = Future<void> Function();
typedef CallUserPlan = Future<UserPlanEntity> Function();
typedef CallGetUserPlan = Future<List<UserPlanEntity>> Function();
typedef CallDeleteUserPlan = Future<void> Function();





class HomeRepository extends HomeBaseRepository {
  final HomeBaseDataSource remoteDataSource;

  HomeRepository({
    required this.remoteDataSource,
  });

  Future<Either<Failure, ProfileEntity>> fetchData(
    Call mainMethod,
  ) async {
    try {
      final coachData = await mainMethod();
      return Right(coachData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfile(
      {required UpdateProfileParams params}) async {
    return await fetchData(() {
      return remoteDataSource.updateProfile(params: params);
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateProfilePicture(
      {required UpdateProfilePictureParams params}) async {
    return await fetchData(() {
      return remoteDataSource.updateProfilePicture(params: params);
    });
  }

  @override
  Future<Either<Failure, ProfileEntity>> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params}) async {
    return await fetchData(() {
      return remoteDataSource.updateCoachSocialLinks(params: params);
    });
  }

  Future<Either<Failure, List<SearchEntity>>> fetchSearch(
    CallSearch mainMethod,
  ) async {
    try {
      final searchData = await mainMethod();
      return Right(searchData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<SearchEntity>>> search({
    required String search,
  }) async {
    return await fetchSearch(() {
      return remoteDataSource.search(search: search);
    });
  }

  Future<Either<Failure, ProfileEntity>> fetchProfile(
    CallProfile mainMethod,
  ) async {
    try {
      final profileData = await mainMethod();
      return Right(profileData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ProfileEntity>> profile({
    required int id,
    bool? isCoach,
  }) async {
    return await fetchProfile(() {
      return remoteDataSource.profile(
          id: id,
          isCoach: isCoach,
      );
    });
  }

  Future<Either<Failure, CertificateEntity>> fetchCertificate(
    CallCertification mainMethod,
  ) async {
    try {
      final certificateData = await mainMethod();
      return Right(certificateData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, CertificateEntity>> certificate({
    required CertificateParams params
  }) async {
    return await fetchCertificate(() {
      return remoteDataSource.certificate(
        params: params
      );
    });
  }

  Future<Either<Failure, List<CertificateEntity>>> fetchGetCertificate(
    CallGetCertification mainMethod,
  ) async {
    try {
      final certificateData = await mainMethod();
      return Right(certificateData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<CertificateEntity>>> getCertificate(
      GetCertificateParams params) async {
    return await fetchGetCertificate(() {
      return remoteDataSource.getCertificate(params);
    });
  }

  Future<Either<Failure, void>> fetchDeleteCertificate(
    CallDeleteCertification mainMethod,
  ) async {
    try {
      final deleteCertificateData = await mainMethod();
      return Right(deleteCertificateData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteCertificate({
    required int certificateId,
  }) async {
    return await fetchDeleteCertificate(() {
      return remoteDataSource.deleteCertificate(certificateId: certificateId);
    });
  }

  @override
  Future<Either<Failure, CertificateEntity>> updateCertificate(
      UpdateCertificateParams params) {
    return fetchCertificate(() {
      return remoteDataSource.updateCertificate(params);
    });
  }

  Future<Either<Failure, AddExerciseEntity>> fetchExercise(
    CallExercise mainMethod,
  ) async {
    try {
      final addExerciseData = await mainMethod();
      return Right(addExerciseData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddExerciseEntity>> addExercise({
    required String exerciseName,
    required String exerciseCategory,
    required String exerciseVisibility,
    required File exercisePic,
    required FilePickerResult exerciseVideo,
    required BuildContext context,
  }) async {
    return await fetchExercise(() {
      return remoteDataSource.addExercise(
        exerciseName: exerciseName,
        exerciseCategory: exerciseCategory,
        exerciseVisibility: exerciseVisibility,
        exercisePic: exercisePic,
        exerciseVideo: exerciseVideo,
        context: context,
      );
    });
  }

  Future<Either<Failure, List<AddExerciseEntity>>> fetchGetExercise(
    CallGetExercise mainMethod,
  ) async {
    try {
      final exerciseData = await mainMethod();
      return Right(exerciseData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<AddExerciseEntity>>> getExercise(
      GetExerciseParams params) async {
    return await fetchGetExercise(() {
      return remoteDataSource.getExercise(params);
    });
  }

  @override
  Future<Either<Failure, AddExerciseEntity>> updateExercise(
      AddExerciseParams params) async {
    return await fetchExercise(() {
      return remoteDataSource.updateExercise(params);
    });
  }

  Future<Either<Failure, void>> fetchDeleteExercise(
    CallDeleteCertification mainMethod,
  ) async {
    try {
      final deleteExercise = await mainMethod();
      return Right(deleteExercise);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExercise(
      DeleteExerciseParams params) async {
    return await fetchDeleteExercise(() {
      return remoteDataSource.deleteExercise(params);
    });
  }

  Future<Either<Failure, AddPlanEntity>> fetchPlan(
    CallAddExercisePlan mainMethod,
  ) async {
    try {
      final addExercisePlanData = await mainMethod();
      return Right(addExercisePlanData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddPlanEntity>> addPlan({
    required bool isNutrition,
    required String exercisePlanName,
    required String exercisePlanVisibility,
  }) async {
    return await fetchPlan(() {
      return remoteDataSource.addPlan(
        isNutrition: isNutrition,
        planName: exercisePlanName,
        planVisibility: exercisePlanVisibility,
      );
    });
  }

  Future<Either<Failure, List<AddPlanEntity>>> fetchGetPlan(
    CallGetExercisePlan mainMethod,
  ) async {
    try {
      final planData = await mainMethod();
      return Right(planData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<AddPlanEntity>>> getPlan(
      GetPlanParams params) async {
    return await fetchGetPlan(() {
      return remoteDataSource.getPlan(params);
    });
  }

  @override
  Future<Either<Failure, AddPlanEntity>> updateExercisePlan(
      AddPlanParams params) async {
    return await fetchPlan(() {
      return remoteDataSource.updatePlan(params);
    });
  }

  Future<Either<Failure, void>> fetchDeleteExercisePlan(
    CallDeleteExercisePlan mainMethod,
  ) async {
    try {
      final deleteExercisePlan = await mainMethod();
      return Right(deleteExercisePlan);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExercisePlan(
      DeletePlanParams params) async {
    return await fetchDeleteExercisePlan(() {
      return remoteDataSource.deletePlan(params);
    });
  }

  Future<Either<Failure, ExerciseDetailsEntity>> fetchAddExerciseDetails(
    CallAddExerciseDetails mainMethod,
  ) async {
    try {
      final exerciseDetails = await mainMethod();
      return Right(exerciseDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, ExerciseDetailsEntity>> addExerciseDetails(
      ExerciseDetailsParams params) async {
    return await fetchAddExerciseDetails(() {
      return remoteDataSource.addExerciseDetails(params);
    });
  }

  Future<Either<Failure, List<ExerciseDetailsEntity>>> fetchGetExerciseDetails(
    CallGetExerciseDetails mainMethod,
  ) async {
    try {
      final exerciseDetails = await mainMethod();
      return Right(exerciseDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<ExerciseDetailsEntity>>> getExercisePlanDetails(
      GetExercisePlanDetailsParams params) async {
    return await fetchGetExerciseDetails(() {
      return remoteDataSource.getExerciseDetails(params);
    });
  }

  Future<Either<Failure, void>> fetchDeleteExercisePlanDetails(
    CallDeleteExercisePlanDetails mainMethod,
  ) async {
    try {
      final deleteExercisePlan = await mainMethod();
      return Right(deleteExercisePlan);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteExercisePlanDetails(
      DeleteExercisePlanDetailsParams params) async {
    return await fetchDeleteExercisePlanDetails(() {
      return remoteDataSource.deleteExercisePlanDetails(params);
    });
  }

  Future<Either<Failure, AddNutritionEntity>> fetchAddNutrition(
    CallAddNutrition mainMethod,
  ) async {
    try {
      final addNutritionData = await mainMethod();
      return Right(addNutritionData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, AddNutritionEntity>> addNutrition({
    int? nutritionId,
    required bool update,
    required double fat,
    required double carb,
    required double protein,
    required double calories,
    required String? howToPrepare,
    required Map component,
    File? nutritionPic,
    required String nutritionCategory,
    required String nutritionName,
    required String nutritionVisibility,
  }) async {
    return await fetchAddNutrition(() {
      return remoteDataSource.addNutrition(
        nutritionId: nutritionId,
        update: update,
        fat: fat,
        carb: carb,
        protein: protein,
        calories: calories,
        howToPrepare: howToPrepare,
        component: component,
        nutritionPic: nutritionPic,
        nutritionCategory: nutritionCategory,
        nutritionName: nutritionName,
        nutritionVisibility: nutritionVisibility,
      );
    });
  }

  Future<Either<Failure, List<AddNutritionEntity>>> fetchGetNutrition(
    CallGetNutrition mainMethod,
  ) async {
    try {
      final getNutritionData = await mainMethod();
      return Right(getNutritionData);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<AddNutritionEntity>>> getNutrition(
      GetNutritionParams params) async {
    return await fetchGetNutrition(() {
      return remoteDataSource.getNutrition(params);
    });
  }

  Future<Either<Failure, void>> fetchDeleteNutrition(
    CallDeleteExercisePlan mainMethod,
  ) async {
    try {
      final deleteNutrition = await mainMethod();
      return Right(deleteNutrition);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNutrition(
      DeleteNutritionParams params) async {
    return await fetchDeleteNutrition(() {
      return remoteDataSource.deleteNutrition(params);
    });
  }


  Future<Either<Failure, NutritionDetailsEntity>> fetchAddNutritionDetails(
      CallAddNutritionDetails mainMethod,
      ) async {
    try {
      final nutritionDetails = await mainMethod();
      return Right(nutritionDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, NutritionDetailsEntity>> addNutritionDetails(
      NutritionDetailsParams params) async {
    return await fetchAddNutritionDetails(() {
      return remoteDataSource.addNutritionDetails(params);
    });
  }

  Future<Either<Failure, List<NutritionDetailsEntity>>> fetchGetNutritionDetails(
      CallGetNutritionDetails mainMethod,
      ) async {
    try {
      final nutritionDetails = await mainMethod();
      return Right(nutritionDetails);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<NutritionDetailsEntity>>> getNutritionPlanDetails(
      GetNutritionPlanDetailsParams params) async {
    return await fetchGetNutritionDetails(() {
      return remoteDataSource.getNutritionDetails(params);
    });
  }

  Future<Either<Failure, SubscriptionRequestEntity>> fetchSubscriptionRequest(
      CallSubscriptionRequest mainMethod,
      ) async {
    try {
      final subscriptionRequest = await mainMethod();
      return Right(subscriptionRequest);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, SubscriptionRequestEntity>> subscriptionRequest(SubscriptionRequestParams params)async {
    return await fetchSubscriptionRequest((){
      return remoteDataSource.subscriptionRequest(params);
    });
  }

  Future<Either<Failure, List<SubscriptionRequestEntity>>> fetchGetSubscriptionRequests(
      CallGetSubscriptionRequests mainMethod,
      ) async {
    try {
      final subscriptionRequests = await mainMethod();
      return Right(subscriptionRequests);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<SubscriptionRequestEntity>>> getSubscriptionRequests(GetSubscriptionsRequestsParams params) async{
    return await fetchGetSubscriptionRequests((){
      return remoteDataSource.getSubscriptionRequests(params);
    });
  }



  Future<Either<Failure, void>> fetchDeleteSubscriptionRequest(
      CallDeleteSubscriptionRequest mainMethod,
      ) async {
    try {
      final deleteSubscriptionRequest = await mainMethod();
      return Right(deleteSubscriptionRequest);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteSubscriptionRequest(
      DeleteSubscriptionRequestParams params) async {
    return await fetchDeleteSubscriptionRequest(() {
      return remoteDataSource.deleteSubscriptionRequest(params);
    });
  }

  Future<Either<Failure, List<NotificationsEntity>>> fetchGetNotifications(
      CallGetNotifications mainMethod,
      ) async {
    try {
      final notificationsEntity = await mainMethod();
      return Right(notificationsEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }
  @override
  Future<Either<Failure, List<NotificationsEntity>>> getNotifications() async{
    return await fetchGetNotifications((){
      return remoteDataSource.getNotifications();
    });
  }


  Future<Either<Failure, void>> fetchMarkAsRead(
      CallMarkAsRead mainMethod,
      ) async {
    try {
      final markAsRead = await mainMethod();
      return Right(markAsRead);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> markAsRead(MarkAsReadParams params) {
    return fetchMarkAsRead((){
      return remoteDataSource.markAsRead(params);
    });
  }

  Future<Either<Failure, List<CoachSubscriptionsEntity>>> fetchGetCoachSubscriptions(
      CallGetCoachSubscriptions mainMethod,
      ) async {
    try {
      final coachSubscriptionsEntity = await mainMethod();
      return Right(coachSubscriptionsEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<CoachSubscriptionsEntity>>> getCoachSubscriptions() async{
    return await fetchGetCoachSubscriptions((){
      return remoteDataSource.getCoachSubscriptions();
    });
  }

  Future<Either<Failure, CoachSubscriptionsEntity>> fetchUpdateSubscriptionStatus(
      CallUpdateSubscriptionStatus mainMethod,
      ) async {
    try {
      final subscriptionEntity = await mainMethod();
      return Right(subscriptionEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, CoachSubscriptionsEntity>> updateSubscriptionStatus(UpdateSubscriptionStatusParams params) async{
    return await fetchUpdateSubscriptionStatus((){
      return  remoteDataSource.updateSubscriptionStatus(params);
    });
  }

  Future<Either<Failure, void>> fetchNotificationsSubscriptions(
      CallNotificationsSubscriptions mainMethod,
      ) async {
    try {
      final notificationsSubscription = await mainMethod();
      return Right(notificationsSubscription);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> notificationSubscription(NotificationsSubscriptionParams params) async{
    return await fetchNotificationsSubscriptions(() {
      return remoteDataSource.notificationsSubscription(params);
    });
  }

  Future<Either<Failure, BodyMeasurementsEntity>> fetchBodyMeasurements(
      CallBodyMeasurements mainMethod,
      ) async {
    try {
      final bodyMeasurementsEntity = await mainMethod();
      return Right(bodyMeasurementsEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, BodyMeasurementsEntity>> bodyMeasurements(BodyMeasurementsParams params) async{
    return await fetchBodyMeasurements((){
      return remoteDataSource.bodyMeasurements(params);
    });
  }


  Future<Either<Failure, List<BodyMeasurementsEntity>>> fetchGetBodyMeasurements(
      CallGetBodyMeasurements mainMethod,
      ) async {
    try {
      final bodyMeasurementsEntity = await mainMethod();
      return Right(bodyMeasurementsEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<BodyMeasurementsEntity>>> getBodyMeasurements(GetBodyMeasurementsParams params) async{
    return await fetchGetBodyMeasurements((){
      return remoteDataSource.getBodyMeasurements(params);
    });
  }

  Future<Either<Failure, void>> fetchDeleteBodyMeasurements(
      CallDeleteBodyMeasurements mainMethod,
      ) async {
    try {
      final deleteBodyMeasurements = await mainMethod();
      return Right(deleteBodyMeasurements);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBodyMeasurements() async{
    return await fetchDeleteBodyMeasurements((){
      return remoteDataSource.deleteBodyMeasurements();
    });
  }

  Future<Either<Failure, UserPlanEntity>> fetchUserPlan(
      CallUserPlan mainMethod,
      ) async {
    try {
      final userPlanEntity = await mainMethod();
      return Right(userPlanEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, UserPlanEntity>> userPlan(UserPlanParams params) async{
    return await fetchUserPlan((){
      return remoteDataSource.userPlan(params);
    });
  }


  Future<Either<Failure, List<UserPlanEntity>>> fetchGetUserPlan(
      CallGetUserPlan mainMethod,
      ) async {
    try {
      final userPlanEntity = await mainMethod();
      return Right(userPlanEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, List<UserPlanEntity>>> getUserPlan() async {
    return await fetchGetUserPlan((){
      return remoteDataSource.getUserPlan();
    });
  }


  Future<Either<Failure, void>> fetchDeleteUserPlan(
      CallDeleteUserPlan mainMethod,
      ) async {
    try {
      final userPlanEntity = await mainMethod();
      return Right(userPlanEntity);
    } on ServerException catch (e) {
      return Left(ServerFailure(
        message: e.message,
      ));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUserPlan(DeleteUserPlanParams params) async{
    return await fetchDeleteUserPlan((){
      return remoteDataSource.deleteUserPlan(params);
    });
  }





}
