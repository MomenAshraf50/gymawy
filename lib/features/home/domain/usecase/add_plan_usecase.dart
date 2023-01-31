import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/add_exercise_plan_entity.dart';
import '../repository/home_base_repository.dart';

class AddExercisePlanUseCase implements UseCase<AddPlanEntity, AddPlanParams> {
  final HomeBaseRepository repository;

  AddExercisePlanUseCase(this.repository);

  @override
  Future<Either<Failure, AddPlanEntity>> call(
      AddPlanParams params) async {
    return await repository.addPlan(
      isNutrition: params.isNutrition,
        exercisePlanName: params.planName,
        exercisePlanVisibility: params.planVisibility,

    );
  }
}

class AddPlanParams extends Equatable {
  final bool isNutrition;
  final String planVisibility;
  final String planName;
  final int? exercisePlanId;



  const AddPlanParams({
    required this.isNutrition,
    required this.planName,
    required this.planVisibility,
    this.exercisePlanId
  });

  @override
  List<Object> get props => [
    planName,
    planVisibility,
  ];
}
