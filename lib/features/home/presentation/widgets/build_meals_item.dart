import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/meals.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/nutrition_basic_data.dart';
import 'package:gymawy/features/home/presentation/widgets/build_meals_details_item.dart';

Widget buildMealsItem(Meals meals) => Card(
  child: Padding(
    padding: EdgeInsets.all(10.rSp),
    child: Column(
      children: [
        Row(
          children: [
            myText(
              title: meals.mealName,
              style: Style.small,
            ),
            const Spacer(),
            myText(
              title: '${meals.mealNumber} meals',
              style: Style.extraSmall,
            ),
            horizontalSpace(0.5.w),
            myText(
              title: '${meals.mealCal} Cal',
              style: Style.extraSmall,
            )
          ],
        ),
        ListView.builder(
          itemBuilder: (context, index) => InkWell(
            onTap: (){
              navigateTo(context, NutritionBasicData());
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