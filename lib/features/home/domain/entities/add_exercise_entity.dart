import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

class AddExerciseEntity extends Equatable {
  int exerciseId;
  UserInformation makerInformation;
  String exerciseName;
  String exerciseCategory;
  String exercisePic;
  String exerciseVid;
  String createdAt;
  String exerciseVisibility;

  AddExerciseEntity({
    required this.makerInformation,
    required this.createdAt,
    required this.exerciseId,
    required this.exerciseName,
    required this.exerciseCategory,
    required this.exercisePic,
    required this.exerciseVid,
    required this.exerciseVisibility,
  });

  @override
  List<Object?> get props => [
    makerInformation,
    exerciseId,
    createdAt,
    exerciseName,
    exerciseCategory,
    exercisePic,
    exerciseVid,
    exerciseVisibility,

  ];
}
