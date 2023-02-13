import 'package:gymawy/features/home/domain/entities/add_nutrition_entity.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/subscription_request_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';

import '../../domain/entities/add_exercise_entity.dart';
import '../../domain/entities/add_exercise_plan_entity.dart';
import '../../domain/entities/add_nutrition_details_entity.dart';
import '../../domain/entities/certificate_entity.dart';
import '../../domain/entities/exercise_details_entity.dart';
import '../../domain/entities/search_entity.dart';

abstract class HomeStates{}

class HomeInitialState extends HomeStates{}
class ChangeFirstChoiceRadioButtonState extends HomeStates{}
class ChangeSecondChoiceRadioButtonState extends HomeStates{}
class ChangeVisibilityPlanState extends HomeStates{}
class ChangeCompletedState extends HomeStates{}
class HomeChangeNavBottomScreensState extends HomeStates{}
class HomeExerciseImagePickedSuccessState extends HomeStates{}
class HomePlansImageSelectedState extends HomeStates{}
class HomeExerciseImagePickedErrorState extends HomeStates{}
class HomeExerciseExampleVideoPlayerInitialized extends HomeStates{}
class ExerciseExamplePauseAndPlayVideoState extends HomeStates{}
class GetTextHeightState extends HomeStates{}
class ChangeCurrentStepState extends HomeStates{}
class SignOutState extends HomeStates{}
class UpdateLoadingState extends HomeStates{}
class UpdateSuccessState extends HomeStates{
  UpdateEntity entity;

  UpdateSuccessState(this.entity);
}
class UpdateErrorState extends HomeStates{
  final String failure;

  UpdateErrorState(this.failure);
}

class SearchLoadingState extends HomeStates{}
class SearchSuccessState extends HomeStates{
  List<SearchEntity> searchList;
  SearchSuccessState(this.searchList);
}
class SearchErrorState extends HomeStates{
  final String failure;

  SearchErrorState(this.failure);
}

class ProfileLoadingState extends HomeStates{}
class ProfileSuccessState extends HomeStates{
  ProfileEntity entity;
  ProfileSuccessState(this.entity);
}
class ProfileErrorState extends HomeStates{
  final String failure;

  ProfileErrorState(this.failure);
}

class PickCertificationPdf extends HomeStates{}

class CertificationLoadingState extends HomeStates{}
class CertificationSuccessState extends HomeStates{
  CertificateEntity entity;
  CertificationSuccessState(this.entity);
}
class CertificationErrorState extends HomeStates{
  final String failure;

  CertificationErrorState(this.failure);
}

class GetCertificateLoadingState extends HomeStates{}
class GetCertificateSuccessState extends HomeStates{
  final List<CertificateEntity> certificateList;

  GetCertificateSuccessState(this.certificateList);
}
class GetCertificateErrorState extends HomeStates{
  final String failure;

  GetCertificateErrorState(this.failure);
}

class ConvertCertificateToImgState extends HomeStates{}

class DeleteCertificateLoadingState extends HomeStates{}
class DeleteCertificateSuccessState extends HomeStates{}
class DeleteCertificateErrorState extends HomeStates{
  final String failure;

  DeleteCertificateErrorState(this.failure);
}

class UpdateCertificateLoadingState extends HomeStates{}
class UpdateCertificateSuccessState extends HomeStates{
  final CertificateEntity certificateEntity;

  UpdateCertificateSuccessState(this.certificateEntity);
}
class UpdateCertificateErrorState extends HomeStates{
  final String failure;

  UpdateCertificateErrorState(this.failure);
}

class PickExerciseVideoState extends HomeStates{}
class ExerciseItemsState extends HomeStates{}
class ChangeVisibilityExerciseState extends HomeStates{}

class AddExerciseLoadingState extends HomeStates{}
class AddExerciseSuccessState extends HomeStates{
  final AddExerciseEntity addExerciseEntity;
  AddExerciseSuccessState(this.addExerciseEntity);
}
class AddExerciseErrorState extends HomeStates{
  final String failure;
  AddExerciseErrorState(this.failure);
}

class ChangeProgressValueState extends HomeStates{
  final int? countProgress;
  final int? totalProgress;
  ChangeProgressValueState(this.countProgress, this.totalProgress);
}


class GetExerciseLoadingState extends HomeStates{}
class GetExerciseSuccessState extends HomeStates{
  final List<AddExerciseEntity> exerciseList;

  GetExerciseSuccessState(this.exerciseList);
}
class GetExerciseErrorState extends HomeStates{
  final String failure;

  GetExerciseErrorState(this.failure);
}

class UpdateExerciseLoadingState extends HomeStates{}
class UpdateExerciseSuccessState extends HomeStates{
  final AddExerciseEntity exerciseEntity;

  UpdateExerciseSuccessState(this.exerciseEntity);
}
class UpdateExerciseErrorState extends HomeStates{
  final String failure;

  UpdateExerciseErrorState(this.failure);
}

class DeleteExerciseLoadingState extends HomeStates{}
class DeleteExerciseSuccessState extends HomeStates{}
class DeleteExerciseErrorState extends HomeStates{
  final String failure;

  DeleteExerciseErrorState(this.failure);
}

class ChangeDropDownSelectedValueState extends HomeStates {}


class AddExercisePlanLoadingState extends HomeStates{}
class AddExercisePlanSuccessState extends HomeStates{
  final AddPlanEntity addExercisePlanEntity;
  AddExercisePlanSuccessState(this.addExercisePlanEntity);
}
class AddExercisePlanErrorState extends HomeStates{
  final String failure;
  AddExercisePlanErrorState(this.failure);
}

class GetExercisePlanLoadingState extends HomeStates{}
class GetExercisePlanSuccessState extends HomeStates{
  final List<AddPlanEntity> exercisePlanList;

  GetExercisePlanSuccessState(this.exercisePlanList);
}
class GetExercisePlanErrorState extends HomeStates{
  final String failure;

  GetExercisePlanErrorState(this.failure);
}

class UpdateExercisePlanLoadingState extends HomeStates{}
class UpdateExercisePlanSuccessState extends HomeStates{
  final AddPlanEntity updateExercisePlan;

  UpdateExercisePlanSuccessState(this.updateExercisePlan);
}
class UpdateExercisePlanErrorState extends HomeStates{
  final String failure;

  UpdateExercisePlanErrorState(this.failure);
}

class DeleteExercisePlanLoadingState extends HomeStates{}
class DeleteExercisePlanSuccessState extends HomeStates{}
class DeleteExercisePlanErrorState extends HomeStates{
  final String failure;

  DeleteExercisePlanErrorState(this.failure);
}

class AddExerciseDetailsLoadingState extends HomeStates{}
class AddExerciseDetailsSuccessState extends HomeStates{}
class AddExerciseDetailsErrorState extends HomeStates{
  final String failure;

  AddExerciseDetailsErrorState(this.failure);
}

class GetExerciseDetailsLoadingState extends HomeStates{}
class GetExerciseDetailsSuccessState extends HomeStates{
  final List<ExerciseDetailsEntity> exercisePlanDetailList;

  GetExerciseDetailsSuccessState(this.exercisePlanDetailList);
}
class GetExerciseDetailsErrorState extends HomeStates{
  final String failure;

  GetExerciseDetailsErrorState(this.failure);
}


class DeleteExercisePlanDetailsLoadingState extends HomeStates{}
class DeleteExercisePlanDetailsSuccessState extends HomeStates{}
class DeleteExercisePlanDetailsErrorState extends HomeStates{
  final String failure;

  DeleteExercisePlanDetailsErrorState(this.failure);
}


class AddNutritionLoadingState extends HomeStates{}
class AddNutritionSuccessState extends HomeStates{
  final AddNutritionEntity addNutritionEntity;
  AddNutritionSuccessState(this.addNutritionEntity);
}
class AddNutritionErrorState extends HomeStates{
  final String failure;
  AddNutritionErrorState(this.failure);
}

class ComponentsStates extends HomeStates{}

class GetNutritionLoadingState extends HomeStates{}
class GetNutritionSuccessState extends HomeStates{
  final List<AddNutritionEntity> getNutrition;

  GetNutritionSuccessState(this.getNutrition);
}
class GetNutritionErrorState extends HomeStates{
  final String failure;

  GetNutritionErrorState(this.failure);
}

class DeleteNutritionLoadingState extends HomeStates{}
class DeleteNutritionSuccessState extends HomeStates{}
class DeleteNutritionErrorState extends HomeStates{
  final String failure;

  DeleteNutritionErrorState(this.failure);
}

class AddNutritionDetailsLoadingState extends HomeStates{}
class AddNutritionDetailsSuccessState extends HomeStates{}
class AddNutritionDetailsErrorState extends HomeStates{
  final String failure;

  AddNutritionDetailsErrorState(this.failure);
}

class GetNutritionDetailsLoadingState extends HomeStates{}
class GetNutritionDetailsSuccessState extends HomeStates{
  final List<NutritionDetailsEntity> nutritionPlanDetailList;

  GetNutritionDetailsSuccessState(this.nutritionPlanDetailList);
}
class GetNutritionDetailsErrorState extends HomeStates{
  final String failure;

  GetNutritionDetailsErrorState(this.failure);
}

class SubscriptionRequestLoadingState extends HomeStates{}
class SubscriptionRequestSuccessState extends HomeStates{
  final SubscriptionRequestEntity subscriptionRequestEntity;

  SubscriptionRequestSuccessState(this.subscriptionRequestEntity);
}
class SubscriptionRequestErrorState extends HomeStates{
  final String failure;

  SubscriptionRequestErrorState(this.failure);
}

class GetSubscriptionRequestLoadingState extends HomeStates{}
class GetSubscriptionRequestSuccessState extends HomeStates{
  final List<SubscriptionRequestEntity> subscriptionRequestEntity;

  GetSubscriptionRequestSuccessState(this.subscriptionRequestEntity);
}
class GetSubscriptionRequestErrorState extends HomeStates{
  final String failure;

  GetSubscriptionRequestErrorState(this.failure);
}

