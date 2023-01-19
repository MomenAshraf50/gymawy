import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class DeleteExercisePlanUseCase extends UseCase<void,DeleteExercisePlanParams> {

  HomeBaseRepository homeBaseRepository;


  DeleteExercisePlanUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteExercisePlanParams params) {
    return homeBaseRepository.deleteExercisePlan(params);
  }
}

class DeleteExercisePlanParams extends Equatable{

  int exercisePlanId;


  DeleteExercisePlanParams(this.exercisePlanId);

  @override
  List<Object?> get props => [exercisePlanId];
}
