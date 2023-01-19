import '../../domain/entities/add_exercise_plan_entity.dart';

class AddExercisePlanModel extends AddExercisePlanEntity {
  AddExercisePlanModel({
    required super.userId,
    required super.exercisePlanName,
    required super.exercisePlanId,
    required super.exercisePlanVisibility,
  });

  factory AddExercisePlanModel.fromJson(Map<String, dynamic> json) {
    return AddExercisePlanModel(
      userId:  json['maker'] ?? 0,
      exercisePlanName:  json['maker'] ?? 'UnKnown',
      exercisePlanId:  json['maker'] ?? 0,
      exercisePlanVisibility:  json['maker'] ?? 'public',
    );
  }
}
