import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/data/models/add_nutrition_model.dart';
import '../../domain/entities/add_nutrition_details_entity.dart';

class NutritionDetailsModel extends NutritionDetailsEntity {
  NutritionDetailsModel({
    required super.meal,
    required super.day,
    required super.nutritionId,
    required super.mealTime,
    required super.nutritionModel,
    required super.nutritionDetailId,
    required super.planId,
  });

  factory NutritionDetailsModel.fromJson(Map<String,dynamic> json){
    return NutritionDetailsModel(
      nutritionDetailId: json['nutrition_detail_id'],
      day: json['day'],
      nutritionId: json['nutrition'],
      nutritionModel: AddNutritionModel.fromJson(json['nutritions']),
      planId: json['nutrition_plan'],
      mealTime: json['meal_time'],
      meal: json['meal'],
    );
  }

  @override
  List<Object?> get props => [
    nutritionDetailId,
    day,
    nutritionModel,
    planId,
    mealTime,
    meal,
  ];

}

