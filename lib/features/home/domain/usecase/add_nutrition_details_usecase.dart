import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:gymawy/core/error/failures.dart';
import 'package:gymawy/core/usecase/use_case.dart';
import 'package:gymawy/features/home/domain/repository/home_base_repository.dart';
import '../entities/add_nutrition_details_entity.dart';

class AddNutritionDetailsUseCase extends UseCase<NutritionDetailsEntity,NutritionDetailsParams>{

  HomeBaseRepository homeBaseRepository;


  AddNutritionDetailsUseCase(this.homeBaseRepository);

  @override
  Future<Either<Failure, NutritionDetailsEntity>> call(NutritionDetailsParams params) {
    return homeBaseRepository.addNutritionDetails(params);
  }
}


class NutritionDetailsParams extends Equatable {
  String day;
  String meal;
  String time;
  int nutritionId;
  int planId;

  NutritionDetailsParams({
    required this.meal,
    required this.time,
    required this.day,
    required this.nutritionId,
    required this.planId,
  });

  @override
  List<Object?> get props => [
    meal,
    time,
    day,
    nutritionId,
    planId,
  ];
}
