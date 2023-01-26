import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class DeleteExercisePlanDetailsUseCase extends UseCase<void,DeleteExercisePlanDetailsParams> {

  HomeBaseRepository homeBaseRepository;


  DeleteExercisePlanDetailsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteExercisePlanDetailsParams params) {
    return homeBaseRepository.deleteExercisePlanDetails(params);
  }
}

class DeleteExercisePlanDetailsParams extends Equatable{

  int exercisePlanDetailsId;


  DeleteExercisePlanDetailsParams(this.exercisePlanDetailsId);

  @override
  List<Object?> get props => [exercisePlanDetailsId];
}
