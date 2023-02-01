import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition.dart';
import '../../../../../../core/util/resources/appString.dart';
import '../../../../../../core/util/resources/constants_manager.dart';

class AddMeal extends StatelessWidget {
  const AddMeal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    List<String> mealsName=
    [
      AppString.breakfast,
      AppString.lunch,
      AppString.snacks,
      AppString.dinner,
    ];

    return Scaffold(
      body: Padding(
        padding: designApp,
        child: Column(
          children: [
            defaultAppBar(
                title: AppString.addMeal,
                context: context
            ),
            verticalSpace(5.h),
            SvgPicture.asset(Assets.images.svg.meal),
            Expanded(
              child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: mealsName.length,
                  itemBuilder: (context, index)
                      {
                        return Container(
                          margin: EdgeInsets.all(20.rSp),
                          child: myButton(
                              text: mealsName[index],
                              onPressed: ()
                              {
                                // navigateTo(
                                //     context, AddMealDetails(
                                //     mealType: mealsName[index]
                                // )
                                // );
                              },
                          ),
                        );
                      }

              ),
            )
          ],
        ),
      ),
    );
  }
}
