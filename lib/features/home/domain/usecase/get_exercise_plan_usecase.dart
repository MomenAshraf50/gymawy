import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_exercise_plan_entity.dart';

class GetExercisePlanUseCase extends UseCase<List<AddExercisePlanEntity>,GetExercisePlanParams>{

  HomeBaseRepository homeBaseRepository;


  GetExercisePlanUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<AddExercisePlanEntity>>> call(GetExercisePlanParams params) async{
    return await homeBaseRepository.getExercisePlan(params);
  }
}

class GetExercisePlanParams extends Equatable{
  final String? searchPlan;

  const GetExercisePlanParams({this.searchPlan});

  @override
  List<Object?> get props => [
    searchPlan
  ];
}