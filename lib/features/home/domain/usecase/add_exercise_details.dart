import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class AddExerciseDetailsUseCase extends UseCase<ExerciseDetailsEntity,ExerciseDetailsParams>{

  HomeBaseRepository homeBaseRepository;


  AddExerciseDetailsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, ExerciseDetailsEntity>> call(ExerciseDetailsParams params) {
    return homeBaseRepository.addExerciseDetails(params);
  }
}


class ExerciseDetailsParams extends Equatable {
  int? exerciseDetailId;
  bool update;
  int sets;
  int reps;
  double rest;
  String day;
  int? exerciseId;
  int? planId;

  ExerciseDetailsParams({
    this.exerciseDetailId,
    required this.update,
    required this.sets,
    required this.reps,
    required this.rest,
    required this.day,
    this.exerciseId,
    this.planId,
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