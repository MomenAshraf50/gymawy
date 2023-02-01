import 'package:equatable/equatable.dart';

class AddNutritionEntity extends Equatable {
  int? nutritionId;
  int? userId;
  String? userName;
  String? nutritionName;
  String? nutritionCategory;
  String? nutritionPic;
  String? nutritionVisibility;
  double? nutritionFat;
  double? nutritionCarb;
  double? nutritionProtein;
  double? nutritionCalories;
  Map? nutritionComponent;
  String? nutritionHowToPrepare;

  AddNutritionEntity({
    this.nutritionId,
    this.userName,
    this.userId,
    this.nutritionName,
    this.nutritionCategory,
    this.nutritionPic,
    this.nutritionVisibility,
    this.nutritionFat,
    this.nutritionCarb,
    this.nutritionProtein,
    this.nutritionCalories,
    this.nutritionComponent,
    this.nutritionHowToPrepare,
  });

  @override
  List<Object?> get props => [
    nutritionId,
    userName,
    userId,
    nutritionName,
    nutritionCategory,
    nutritionPic,
    nutritionVisibility,
    nutritionFat,
    nutritionCarb,
    nutritionProtein,
    nutritionCalories,
    nutritionComponent,
    nutritionHowToPrepare,
  ];
}
