import 'package:equatable/equatable.dart';

class AddPlanEntity extends Equatable {
  int? exercisePlanId;
  int? nutritionPlanId;
  int? userId;
  String planName;
  String planVisibility;
  String? userName;

  AddPlanEntity({
    this.exercisePlanId,
    this.nutritionPlanId,
    this.userId,
    this.userName,
    required this.planName,
    required this.planVisibility,
  });

  @override
  List<Object?> get props => [
    exercisePlanId,
    userId,
    userName,
    planName,
    planVisibility,

  ];
}
