import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/meals.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/nutrition_basic_data.dart';
import 'package:gymawy/features/home/presentation/widgets/build_meals_details_item.dart';

Widget buildMealsItem(Meals meals) => Card(
  child: Padding(
    padding: EdgeInsets.all(10.rSp),
    child: Column(
      children: [
        Row(
          children: [
            DefaultText(
              title: meals.mealName,
              style: Style.small,
            ),
            const Spacer(),
            DefaultText(
              title: '${meals.mealNumber} meals',
              style: Style.extraSmall,
            ),
            horizontalSpace(0.5.w),
            DefaultText(
              title: '${meals.mealCal} Cal',
              style: Style.extraSmall,
            )
          ],
        ),
        ListView.builder(
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              //navigateTo(context, NutritionBasicData(nutritionEntity: meals,));
            },
            child: buildMealsDetailsItem(
              meals.mealDetails[index],
            ),
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: meals.mealDetails.length,
        )
      ],
    ),
  ),
);