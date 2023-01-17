import 'package:equatable/equatable.dart';

class AddExerciseEntity extends Equatable {
  String userName;
  int exerciseId;
  int userId;
  String exerciseName;
  String exerciseCategory;
  String exercisePic;
  String exerciseVid;
  String exerciseVisibility;

  AddExerciseEntity({
    required this.userName,
    required this.exerciseId,
    required this.userId,
    required this.exerciseName,
    required this.exerciseCategory,
    required this.exercisePic,
    required this.exerciseVid,
    required this.exerciseVisibility,
  });

  @override
  List<Object?> get props => [
    userName,
    exerciseId,
    userId,
    exerciseName,
    exerciseCategory,
    exercisePic,
    exerciseVid,
    exerciseVisibility,

  ];
}
