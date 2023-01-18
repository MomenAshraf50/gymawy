import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/entities/add_exercise_entity.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_usecase.dart';

class UpdateExerciseUseCase extends UseCase<AddExerciseEntity,AddExerciseParams>{

  HomeBaseRepository homeBaseRepository;


  UpdateExerciseUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, AddExerciseEntity>> call(AddExerciseParams params) {

    return homeBaseRepository.updateExercise(params);
  }
}
