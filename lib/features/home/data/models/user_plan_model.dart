import 'package:gymawy/features/home/domain/entities/user_plan_entity.dart';

class UserPlanModel extends UserPlanEntity {
  UserPlanModel({
    required super.userPlanId,
    required super.client,
    required super.exercisePlan,
    required super.nutritionPlan,
  });

  factory UserPlanModel.fromJson(Map<String,dynamic> json){
    return UserPlanModel(
      client: json['client'],
      exercisePlan: json['exercise_plan'],
      nutritionPlan: json['nutrition_plan'],
      userPlanId: json['userPlan_id'],
    );
  }
}
