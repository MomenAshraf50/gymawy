import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/add_exercise_plan_entity.dart';
import '../repository/home_base_repository.dart';

class AddExercisePlanUseCase implements UseCase<AddExercisePlanEntity, AddExercisePlanParams> {
  final HomeBaseRepository repository;

  AddExercisePlanUseCase(this.repository);

  @override
  Future<Either<Failure, AddExercisePlanEntity>> call(
      AddExercisePlanParams params) async {
    return await repository.addExercisePlan(
        exercisePlanName: params.exercisePlanName,
        exercisePlanVisibility: params.exercisePlanVisibility,
    );
  }
}

class AddExercisePlanParams extends Equatable {
  final String exercisePlanVisibility;
  final String exercisePlanName;



  const AddExercisePlanParams({
    required this.exercisePlanName,
    required this.exercisePlanVisibility,
  });

  @override
  List<Object> get props => [
    exercisePlanName,
    exercisePlanVisibility,
  ];
}
