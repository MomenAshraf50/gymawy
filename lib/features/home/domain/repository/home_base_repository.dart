import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';
import 'package:gymawy/features/home/domain/entities/notifications_entity.dart';
import 'package:gymawy/features/home/domain/entities/search_entity.dart';
import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_details.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/delete_nutrition_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/get_certifications.dart';
import 'package:gymawy/features/home/domain/usecase/get_subscriptions_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/mark_as_read_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/subscription_request_usecase.dart';
import 'package:gymawy/features/home/domain/usecase/update_certificate.dart';
import 'package:gymawy/features/home/domain/usecase/update_coach_social_links.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_picture.dart';
import 'package:gymawy/features/home/domain/usecase/update_profile_usecase.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition.dart';
import '../../../../core/error/failures.dart';
import '../entities/add_exercise_entity.dart';
import '../entities/add_exercise_plan_entity.dart';
import '../entities/add_nutrition_details_entity.dart';
import '../entities/add_nutrition_entity.dart';
import '../entities/certificate_entity.dart';
import '../entities/profile_entity.dart';
import '../usecase/add_nutrition_details_usecase.dart';
import '../usecase/add_plan_usecase.dart';
import '../usecase/delete_exercise_details_usecase.dart';
import '../usecase/delete_exersice_plan_usecase.dart';
import '../usecase/delete_subscriptionRequest_usecase.dart';
import '../usecase/get_exercise_plan_details.dart';
import '../usecase/get_nutrition_details.dart';
import '../usecase/get_nutrition_usecase.dart';
import '../usecase/get_plan_usecase.dart';
import '../usecase/get_exercise_usecase.dart';

abstract class HomeBaseRepository {
  Future<Either<Failure, UpdateEntity>> updateProfile(
      {required UpdateProfileParams params});

  Future<Either<Failure, UpdateEntity>> updateCoachSocialLinks(
      {required UpdateCoachSocialLinksParams params});

  Future<Either<Failure, UpdateEntity>> updateProfilePicture(
      {required UpdateProfilePictureParams params});

  Future<Either<Failure, List<SearchEntity>>> search({
    required String search,
  });

  Future<Either<Failure, ProfileEntity>> profile({
    required String id,
    bool? isCoach,
  });

  Future<Either<Failure, CertificateEntity>> certificate({
    required String id,
    required String certificateName,
    required FilePickerResult certificateFile,
    required String certificateDate,
  });

  Future<Either<Failure, List<CertificateEntity>>> getCertificate(
      GetCertificateParams params);

  Future<Either<Failure, void>> deleteCertificate({
    required String certificateId,
  });

  Future<Either<Failure, CertificateEntity>> updateCertificate(
      UpdateCertificateParams params);

  Future<Either<Failure, AddExerciseEntity>> addExercise({
    required String exerciseName,
    required String exerciseCategory,
    required String exerciseVisibility,
    required File exercisePic,
    required FilePickerResult exerciseVideo,
    required BuildContext context,
  });

  Future<Either<Failure, List<AddExerciseEntity>>> getExercise(
      GetExerciseParams params);

  Future<Either<Failure, AddExerciseEntity>> updateExercise(
      AddExerciseParams params);

  Future<Either<Failure, void>> deleteExercise(DeleteExerciseParams params);

  Future<Either<Failure, AddPlanEntity>> addPlan({
    required bool isNutrition,
    required String exercisePlanName,
    required String exercisePlanVisibility,
  });

  Future<Either<Failure, List<AddPlanEntity>>> getPlan(GetPlanParams params);

  Future<Either<Failure, AddPlanEntity>> updateExercisePlan(
      AddPlanParams params);

  Future<Either<Failure, void>> deleteExercisePlan(DeletePlanParams params);

  Future<Either<Failure, ExerciseDetailsEntity>> addExerciseDetails(
      ExerciseDetailsParams params);

  Future<Either<Failure, List<ExerciseDetailsEntity>>> getExercisePlanDetails(
      GetExercisePlanDetailsParams params);

  Future<Either<Failure, void>> deleteExercisePlanDetails(
      DeleteExercisePlanDetailsParams params);

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
  });

  Future<Either<Failure, List<AddNutritionEntity>>> getNutrition(
      GetNutritionParams params);

  Future<Either<Failure, void>> deleteNutrition(DeleteNutritionParams params);

  Future<Either<Failure, NutritionDetailsEntity>> addNutritionDetails(
      NutritionDetailsParams params);

  Future<Either<Failure, List<NutritionDetailsEntity>>> getNutritionPlanDetails(
      GetNutritionPlanDetailsParams params);

  Future<Either<Failure, SubscriptionRequestEntity>> subscriptionRequest(
      SubscriptionRequestParams params);

  Future<Either<Failure, List<SubscriptionRequestEntity>>> getSubscriptionRequests(GetSubscriptionsRequestsParams params);


  Future<Either<Failure, void>> deleteSubscriptionRequest(DeleteSubscriptionRequestParams params);

  Future<Either<Failure, List<NotificationsEntity>>> getNotifications();

  Future<Either<Failure, void>> markAsRead(MarkAsReadParams params);




}
