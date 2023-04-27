import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

import '../../domain/entities/add_exercise_entity.dart';

class AddExerciseModel extends AddExerciseEntity {
  AddExerciseModel({
    required super.makerInformation,
    required super.createdAt,
    required super.exerciseName,
    required super.exerciseId,
    required super.exerciseCategory,
    required super.exerciseVisibility,
    required super.exercisePic,
    required super.exerciseVid,
  });

  factory AddExerciseModel.fromJson(Map<String, dynamic> json) {
    return AddExerciseModel(
      makerInformation:  UserInformation.fromJson(json['maker']),
      createdAt:  json['created_at'],
      exerciseName:  json['exercise_name'] ?? 'UnKnown',
      exerciseId:  json['EXERCICE_id'] ?? 0,
      exerciseCategory:  json['category'] ?? 'UnKnown',
      exerciseVisibility:  json['visibility'] ?? 'UnKnown',
      exercisePic: json['exercise_pic'] ?? 'UnKnown',
      exerciseVid:  json['exercise_vid'] ?? 'UnKnown',
    );
  }
}
