import 'package:gymawy/features/home/data/models/add_exercise_model.dart';
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
          exerciseId: json['exercise'],
        day: json['day'],
        exerciseDetailId: json['id'],
        exerciseModel: AddExerciseModel.fromJson(json['exercise_info']),
        planId: json['exercise_plan'],
        reps: json['reps'],
        rest: json['rest'],
        sets: json['sets'],
      );
  }
}

