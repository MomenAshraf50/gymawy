import 'package:equatable/equatable.dart';
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
      nutritionModel: NutritionModel.fromJson(json['nutritions']),
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

class NutritionModel extends Equatable {
  String nutritionName;
  String nutritionCategory;
  String nutritionPic;
  String nutritionVisibility;
  String nutritionMaker;

  NutritionModel({
    required this.nutritionName,
    required this.nutritionMaker,
    required this.nutritionPic,
    required this.nutritionCategory,
    required this.nutritionVisibility,
  });

  factory NutritionModel.fromJson(Map<String, dynamic> json) {
    return NutritionModel(
      nutritionCategory: json['category'],
      nutritionPic: json['nutrition_pic'],
      nutritionName: json['nutrition_name'],
      nutritionMaker: json['maker'],
      nutritionVisibility: json['visibility'],
    );
  }

  @override
  List<Object?> get props => [
    nutritionCategory,
    nutritionPic,
    nutritionName,
    nutritionMaker,
    nutritionVisibility,
  ];
}
