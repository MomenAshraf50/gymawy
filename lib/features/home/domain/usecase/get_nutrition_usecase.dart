import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_nutrition_entity.dart';

class GetNutritionUseCase extends UseCase<List<AddNutritionEntity>,GetNutritionParams>{

  HomeBaseRepository homeBaseRepository;


  GetNutritionUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, List<AddNutritionEntity>>> call(GetNutritionParams params) async{
    return await homeBaseRepository.getNutrition(params);
  }
}

class GetNutritionParams extends Equatable{
  final String? searchNutrition;

  const GetNutritionParams({
    this.searchNutrition
  });

  @override
  List<Object?> get props => [
    searchNutrition
  ];
}