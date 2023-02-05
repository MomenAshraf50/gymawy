import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';

class ExerciseDetailsModel extends ExerciseDetailsEntity {
  ExerciseDetailsModel({
    required super.exerciseDetailId,
    required super.exerciseModel,
    required super.sets,
    required super.reps,
    required super.rest,
    required super.day,
    required super.exerciseId,
    required super.planId,
  });

  factory ExerciseDetailsModel.fromJson(Map<String,dynamic> json){
      return ExerciseDetailsModel(
          exerciseId: json['EXERCISE_detail_id'],
        day: json['day'],
        exerciseDetailId: json['EXERCISE_detail_id'],
        exerciseModel: ExerciseModel.fromJson(json['exercises']),
        planId: json['exercise_plan'],
        reps: json['reps'],
        rest: json['rest'],
        sets: json['sets'],
      );
  }
}

