import '../../domain/entities/add_exercise_entity.dart';

class AddExerciseModel extends AddExerciseEntity {
  AddExerciseModel({
    required super.userName,
    required super.userId,
    required super.exerciseName,
    required super.exerciseId,
    required super.exerciseCategory,
    required super.exerciseVisibility,
    required super.exercisePic,
    required super.exerciseVid,
  });

  factory AddExerciseModel.fromJson(Map<String, dynamic> json) {
    return AddExerciseModel(
      userName:  json['maker_username'] ?? 'UnKnown',
      userId:  json['maker'] ?? 0,
      exerciseName:  json['exercise_name'] ?? 'UnKnown',
      exerciseId:  json['EXERCICE_id'] ?? 0,
      exerciseCategory:  json['category'] ?? 'UnKnown',
      exerciseVisibility:  json['visibility'] ?? 'UnKnown',
      exercisePic: json['exercise_pic'] ?? 'UnKnown',
      exerciseVid:  json['exercise_vid'] ?? 'UnKnown',
    );
  }
}
