import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';

class DeleteNutritionUseCase extends UseCase<void,DeleteNutritionParams>{

  HomeBaseRepository homeBaseRepository;


  DeleteNutritionUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, void>> call(DeleteNutritionParams params) {
    return homeBaseRepository.deleteNutrition(params);
  }
}

class DeleteNutritionParams extends Equatable{

  int nutritionId;


  DeleteNutritionParams(this.nutritionId);

  @override
  List<Object?> get props => [
    nutritionId
  ];

}