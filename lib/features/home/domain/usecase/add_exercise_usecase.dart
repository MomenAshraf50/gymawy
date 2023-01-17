import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:file_picker/file_picker.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/add_exercise_entity.dart';
import '../repository/home_base_repository.dart';

class AddExerciseUseCase implements UseCase<AddExerciseEntity, AddExerciseParams> {
  final HomeBaseRepository repository;

  AddExerciseUseCase(this.repository);

  @override
  Future<Either<Failure, AddExerciseEntity>> call(
      AddExerciseParams params) async {
    return await repository.addExercise(
      exerciseName: params.exerciseName,
      exerciseCategory: params.exerciseCategory,
      exerciseVisibility: params.exerciseVisibility,
      exercisePic: params.exercisePic,
      exerciseVideo: params.exerciseVideo,

    );
  }
}

class AddExerciseParams extends Equatable {
  final String exerciseName;
  final String exerciseCategory;
  final String exerciseVisibility;
  final File exercisePic;
  final FilePickerResult exerciseVideo;


  const AddExerciseParams({
    required this.exerciseName,
    required this.exerciseCategory,
    required this.exerciseVisibility,
    required this.exercisePic,
    required this.exerciseVideo,
    context
  });

  @override
  List<Object> get props => [
    exerciseName,
    exerciseCategory,
    exerciseVisibility,
    exercisePic,
    exerciseVideo,
  ];
}
