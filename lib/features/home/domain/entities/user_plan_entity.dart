import 'package:equatable/equatable.dart';

class UserPlanEntity extends Equatable {
  int userPlanId;
  int client;
  int exercisePlan;
  int nutritionPlan;

  UserPlanEntity({
    required this.userPlanId,
    required this.client,
    required this.exercisePlan,
    required this.nutritionPlan,
  });

  @override
  List<Object?> get props => [
        userPlanId,
        client,
        exercisePlan,
        nutritionPlan,
      ];
}
