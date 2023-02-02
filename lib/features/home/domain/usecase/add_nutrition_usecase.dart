import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecase/use_case.dart';
import '../entities/add_nutrition_entity.dart';
import '../repository/home_base_repository.dart';

class AddNutritionUseCase
    implements UseCase<AddNutritionEntity, AddNutritionParams> {
  final HomeBaseRepository repository;

  AddNutritionUseCase(this.repository);

  @override
  Future<Either<Failure, AddNutritionEntity>> call(
      AddNutritionParams params) async {
    return await repository.addNutrition(
      nutritionId: params.nutritionId,
      update: params.update,
      fat: params.fat,
      carb: params.carb,
      protein: params.protein,
      calories: params.calories,
      howToPrepare: params.howToPrepare,
      component: params.component,
      nutritionPic: params.nutritionPic,
      nutritionCategory: params.nutritionCategory,
      nutritionName: params.nutritionName,
      nutritionVisibility: params.nutritionVisibility,
    );
  }
}

class AddNutritionParams extends Equatable {
  final int? nutritionId;
  final bool update;
  final double fat;
  final double carb;
  final double protein;
  final double calories;
  final String? howToPrepare;
  final Map component;
  final File? nutritionPic;
  final String nutritionCategory;
  final String nutritionName;
  final String nutritionVisibility;

  const AddNutritionParams({
    this.nutritionId,
    required this.update,
    required this.fat,
    required this.carb,
    required this.protein,
    required this.calories,
    this.howToPrepare,
    required this.component,
    required this.nutritionPic,
    required this.nutritionCategory,
    required this.nutritionName,
    required this.nutritionVisibility,
  });

  @override
  List<Object> get props => [
        update,
        fat,
        carb,
        protein,
        calories,
        component,
        nutritionCategory,
        nutritionName,
        nutritionVisibility,
      ];
}
