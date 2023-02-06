import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_exercise_plan_entity.dart';
import '../entities/exercise_details_entity.dart';

class GetExercisePlanDetailsUseCase extends UseCase<List<ExerciseDetailsEntity>,GetExercisePlanDetailsParams>{

  HomeBaseRepository homeBaseRepository;


  GetExercisePlanDetailsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<ExerciseDetailsEntity>>> call(GetExercisePlanDetailsParams params) async{
    return await homeBaseRepository.getExercisePlanDetails(params);
  }
}

class GetExercisePlanDetailsParams extends Equatable{

  int exercisePlanId;

  GetExercisePlanDetailsParams(this.exercisePlanId);

  @override
  List<Object?> get props => [
  ];
}