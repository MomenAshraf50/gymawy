import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/meals.dart';
import 'package:gymawy/core/util/widgets/myText.dart';

Widget buildMealsDetailsItem(MealDetails mealDetails) => Column(
  children: [
    Row(
      children: [
        SvgPicture.asset(
          mealDetails.mealImage,
          height: 6.h,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            myText(
              title: mealDetails.mealLabel,
              style: Style.extraSmall,
            ),
            myText(
              title: mealDetails.mealTime,
              style: Style.extraSmall,
              fontSize: 10.rSp,
            ),
          ],
        ),
        const Spacer(),
        Icon(Icons.arrow_forward_ios,color: Colors.grey.withOpacity(0.4),)
      ],
    ),
  ],
);
