import 'package:dartz/dartz.dart';
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