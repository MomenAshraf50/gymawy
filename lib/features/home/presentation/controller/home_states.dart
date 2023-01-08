import 'package:gymawy/features/home/domain/entities/update_coach_profile_entity.dart';

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