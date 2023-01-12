import 'package:gymawy/features/home/domain/entities/profile_entity.dart';
import 'package:gymawy/features/home/domain/entities/update_entity.dart';

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
class UpdateCoachLoadingState extends HomeStates{}
class UpdateCoachSuccessState extends HomeStates{
  UpdateEntity entity;

  UpdateCoachSuccessState(this.entity);
}
class UpdateCoachErrorState extends HomeStates{
  final String failure;

  UpdateCoachErrorState(this.failure);
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

