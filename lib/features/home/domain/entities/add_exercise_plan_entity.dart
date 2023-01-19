import 'package:equatable/equatable.dart';

class AddExercisePlanEntity extends Equatable {
  int exercisePlanId;
  int? userId;
  String exercisePlanName;
  String exercisePlanVisibility;
  String? userName;

  AddExercisePlanEntity({
    required this.exercisePlanId,
    this.userId,
    this.userName,
    required this.exercisePlanName,
    required this.exercisePlanVisibility,
  });

  @override
  List<Object?> get props => [
    exercisePlanId,
    userId,
    userName,
    exercisePlanName,
    exercisePlanVisibility,

  ];
}
