import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';

import '../../domain/entities/add_exercise_entity.dart';
import '../../domain/entities/add_exercise_plan_entity.dart';
import '../../domain/entities/certificate_entity.dart';
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
  final AddExercisePlanEntity addExercisePlanEntity;
  AddExercisePlanSuccessState(this.addExercisePlanEntity);
}
class AddExercisePlanErrorState extends HomeStates{
  final String failure;
  AddExercisePlanErrorState(this.failure);
}

class GetExercisePlanLoadingState extends HomeStates{}
class GetExercisePlanSuccessState extends HomeStates{
  final List<AddExercisePlanEntity> exercisePlanList;

  GetExercisePlanSuccessState(this.exercisePlanList);
}
class GetExercisePlanErrorState extends HomeStates{
  final String failure;

  GetExercisePlanErrorState(this.failure);
}
