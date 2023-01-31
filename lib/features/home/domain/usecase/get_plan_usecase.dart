import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_exercise_plan_entity.dart';

class GetPlanUseCase extends UseCase<List<AddPlanEntity>,GetPlanParams>{

  HomeBaseRepository homeBaseRepository;


  GetPlanUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<AddPlanEntity>>> call(GetPlanParams params) async{
    return await homeBaseRepository.getPlan(params);
  }
}

class GetPlanParams extends Equatable{
  final bool isNutrition;
  final String? searchPlan;

  const GetPlanParams({this.searchPlan, required this.isNutrition});

  @override
  List<Object?> get props => [
    searchPlan,
    isNutrition
  ];
}