import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class DeleteExerciseUseCase extends UseCase<void,DeleteExerciseParams> {

  HomeBaseRepository homeBaseRepository;


  DeleteExerciseUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteExerciseParams params) {
    return homeBaseRepository.deleteExercise(params);
  }
}

class DeleteExerciseParams extends Equatable{

  int exerciseId;


  DeleteExerciseParams(this.exerciseId);

  @override
  List<Object?> get props => [exerciseId];
}
