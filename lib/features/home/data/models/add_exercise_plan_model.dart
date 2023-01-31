import '../../domain/entities/add_exercise_plan_entity.dart';

class AddExercisePlanModel extends AddPlanEntity {
  AddExercisePlanModel({
    required super.userId,
    required super.userName,
    super.exercisePlanId,
    required super.planVisibility,
    super.nutritionPlanId,
    required super.planName
  });

  factory AddExercisePlanModel.fromExerciseJson(Map<String, dynamic> json) {
    return AddExercisePlanModel(
      userId:  json['maker'] ?? 0,
      planName:  json['plan_name'] ?? 'UnKnown',
      exercisePlanId:  json['EXERCISE_PLAN_id'] ?? 0,
      planVisibility:  json['visibility'] ?? 'public',
      userName: json['maker_username'],
    );
  }

  factory AddExercisePlanModel.fromNutritionJson(Map<String, dynamic> json) {
    return AddExercisePlanModel(
      userId:  json['maker'] ?? 0,
      planName:  json['plan_name'] ?? 'UnKnown',
      nutritionPlanId:  json['nutrition_plan_id'] ?? 0,
      planVisibility:  json['visibility'] ?? 'public',
      userName: json['maker_username'],
    );
  }
}
