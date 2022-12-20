import 'package:equatable/equatable.dart';

class Meals extends Equatable{

  String mealName;
  int mealNumber;
  int mealCal;

  List<MealDetails> mealDetails;


  Meals(this.mealName, this.mealNumber, this.mealCal,this.mealDetails,);

  @override
  List<Object?> get props => [mealName,mealCal,mealNumber,mealDetails,];
}

class MealDetails extends Equatable {

  String mealImage;
  String mealLabel;
  String mealTime;


  MealDetails(this.mealImage, this.mealLabel, this.mealTime);

  @override
  List<Object?> get props => [mealImage,mealLabel,mealImage];
}