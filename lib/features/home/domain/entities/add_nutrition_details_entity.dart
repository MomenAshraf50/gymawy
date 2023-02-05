import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/data/models/add_exercise_model.dart';

import '../../data/models/add_nutrition_details_model.dart';

class NutritionDetailsEntity extends Equatable {
  int nutritionDetailId;
  NutritionModel nutritionModel;
  String meal;
  String mealTime;
  String day;
  int nutritionId;
  int planId;

  NutritionDetailsEntity({
    required this.nutritionDetailId,
    required this.nutritionModel,
    required this.mealTime,
    required this.meal,
    required this.day,
    required this.nutritionId,
    required this.planId,
  });

  @override
  List<Object?> get props => [
  nutritionDetailId,
  nutritionModel,
  mealTime,
  meal,
  day,
  nutritionId,
  planId,
  ];
}