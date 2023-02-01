import '../../domain/entities/add_nutrition_entity.dart';

class AddNutritionModel extends AddNutritionEntity {
  AddNutritionModel({
    required super.userName,
    required super.userId,
    required super.nutritionName,
    required super.nutritionCategory,
    required super.nutritionPic,
    required super.nutritionCalories,
    required super.nutritionCarb,
    required super.nutritionComponent,
    required super.nutritionFat,
    required super.nutritionHowToPrepare,
    required super.nutritionId,
    required super.nutritionProtein,
    required super.nutritionVisibility,
  });

  factory AddNutritionModel.fromJson(Map<String, dynamic> json) {
    return AddNutritionModel(
      nutritionId: json['nutrition_id'] ?? 0,
      userName:  json['maker_username'] ?? 'UnKnown',
      userId:  json['maker'] ?? 0,
      nutritionName:  json['nutrition_name'] ?? 'UnKnown',
      nutritionCategory:  json['nutrition_category'] ?? 'UnKnown',
      nutritionPic:  json['nutrition_pic'] ?? 'UnKnown',
      nutritionCalories:  json['calories'] ?? 0.0,
      nutritionCarb:  json['carb'] ?? 0.0,
      nutritionFat:  json['fat'] ?? 0.0,
      nutritionProtein:  json['protein'] ?? 0.0,
      nutritionVisibility:  json['visibility'] ?? 'public',
      nutritionComponent: json['component'] ?? {'':''},
      nutritionHowToPrepare: json['how_to_prepare'] ?? 'UnKnown',

    );
  }
}