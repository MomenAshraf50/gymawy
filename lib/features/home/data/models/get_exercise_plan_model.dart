import '../../domain/entities/add_exercise_plan_entity.dart';

class GetExercisePlanModel extends AddExercisePlanEntity {
  GetExercisePlanModel({
    required super.userName,
    required super.exercisePlanName,
    required super.exercisePlanId,
    required super.exercisePlanVisibility,
  });

  factory GetExercisePlanModel.fromJson(Map<String, dynamic> json) {
    return GetExercisePlanModel(
      userName:  json['maker_id'] ?? 'UnKnown',
      exercisePlanName:  json['plan_name'] ?? 'UnKnown',
      exercisePlanId:  json['EXERCISE_PLAN_id'] ?? 0,
      exercisePlanVisibility:  json['visibility'] ?? 'public',
    );
  }
}
