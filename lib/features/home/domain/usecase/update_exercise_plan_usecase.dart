import 'package:dartz/dartz.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_exercise_plan_entity.dart';
import 'add_plan_usecase.dart';

class UpdateExercisePlanUseCase extends UseCase<AddPlanEntity,AddPlanParams>{

  HomeBaseRepository homeBaseRepository;


  UpdateExercisePlanUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, AddPlanEntity>> call(AddPlanParams params) {

    return homeBaseRepository.updateExercisePlan(params);
  }
}
