import 'package:equatable/equatable.dart';
import 'package:gymawy/features/home/domain/entities/profile_entity.dart';

class AddNutritionEntity extends Equatable {
  int? nutritionId;
  UserInformation userInformation;
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
    required this.userInformation,
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
    userInformation,
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
