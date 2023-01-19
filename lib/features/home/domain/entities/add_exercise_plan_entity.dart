import 'package:equatable/equatable.dart';

class AddExercisePlanEntity extends Equatable {
  int exercisePlanId;
  int userId;
  String exercisePlanName;
  String exercisePlanVisibility;

  AddExercisePlanEntity({
    required this.exercisePlanId,
    required this.userId,
    required this.exercisePlanName,
    required this.exercisePlanVisibility,
  });

  @override
  List<Object?> get props => [
    exercisePlanId,
    userId,
    exercisePlanName,
    exercisePlanVisibility,

  ];
}
