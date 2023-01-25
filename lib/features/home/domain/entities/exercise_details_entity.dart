import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/data/models/add_exercise_model.dart';

class ExerciseDetailsEntity extends Equatable {
  int exerciseDetailId;
  ExerciseModel exerciseModel;
  int sets;
  int reps;
  double rest;
  String day;
  int exerciseId;
  int planId;

  ExerciseDetailsEntity({
    required this.exerciseDetailId,
    required this.exerciseModel,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.day,
    required this.exerciseId,
    required this.planId,
  });

  @override
  List<Object?> get props => [
        exerciseDetailId,
        exerciseModel,
        sets,
        reps,
        rest,
        day,
        exerciseId,
        planId,
      ];
}

class ExerciseDetailsParams extends Equatable {
  int sets;
  int reps;
  int rest;
  String day;
  int exerciseId;
  int planId;

  ExerciseDetailsParams({
    required this.sets,
    required this.reps,
    required this.rest,
    required this.day,
    required this.exerciseId,
    required this.planId,
  });

  @override
  List<Object?> get props => [
        sets,
        rest,
        reps,
        day,
        exerciseId,
        planId,
      ];
}

class ExerciseModel extends Equatable {
  String exerciseName;
  String exerciseCategory;
  String exercisePic;
  String exerciseVid;
  String exerciseMaker;

  ExerciseModel({
    required this.exerciseName,
    required this.exerciseCategory,
    required this.exercisePic,
    required this.exerciseVid,
    required this.exerciseMaker,
  });

  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      exerciseMaker: json['maker'],
      exerciseName: json['exercise_name'],
      exerciseCategory: json['category'],
      exercisePic: json['exercise_pic'],
      exerciseVid: json['exercise_vid'],
    );
  }

  @override
  List<Object?> get props => [
    exerciseName,
    exerciseCategory,
    exercisePic,
    exerciseVid,
    exerciseMaker,
  ];
}
