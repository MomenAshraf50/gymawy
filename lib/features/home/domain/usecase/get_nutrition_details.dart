import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_nutrition_details_entity.dart';

class GetNutritionPlanDetailsUseCase extends UseCase<List<NutritionDetailsEntity>,GetNutritionPlanDetailsParams>{

  HomeBaseRepository homeBaseRepository;


  GetNutritionPlanDetailsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<NutritionDetailsEntity>>> call(GetNutritionPlanDetailsParams params) async{
    return await homeBaseRepository.getNutritionPlanDetails(params);
  }
}

class GetNutritionPlanDetailsParams extends Equatable{

  int nutritionPlanId;

  GetNutritionPlanDetailsParams(this.nutritionPlanId);

  @override
  List<Object?> get props => [
    nutritionPlanId
  ];
}