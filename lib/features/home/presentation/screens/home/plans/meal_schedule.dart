import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/resources/meals.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/features/home/presentation/screens/home/plans/add_meal.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/nutrition_basic_data.dart';
import 'package:gymawy/features/home/presentation/widgets/build_meals_item.dart';

class MealScheduleScreen extends StatelessWidget {
  const MealScheduleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Meals> meals = [
      Meals(AppString.breakfast, 2, 230, [
        MealDetails(
          Assets.images.svg.breakfast1,
          AppString.honey,
          '07:00 am',
        ),
        MealDetails(
          Assets.images.svg.breakfast2,
          AppString.coffee,
          '07:30 am',
        )
      ]),
      Meals(AppString.lunch, 2, 500, [
        MealDetails(
          Assets.images.svg.lunch1,
          AppString.chickenSteak,
          '01:00 pm',
        ),
        MealDetails(
          Assets.images.svg.lunch2,
          AppString.milk,
          '01:20 pm',
        )
      ]),
      Meals(AppString.snacks, 2, 140, [
        MealDetails(
          Assets.images.svg.snacks1,
          AppString.orange,
          '04:30 pm',
        ),
        MealDetails(
          Assets.images.svg.snacks2,
          AppString.applePie,
          '04:40 pm',
        )
      ]),
      Meals(AppString.dinner, 2, 120, [
        MealDetails(
          Assets.images.svg.dinner1,
          AppString.salad,
          '07:10 pm',
        ),
        MealDetails(
          Assets.images.svg.dinner2,
          AppString.oatmeal,
          '08:10 pm',
        ),
      ]),
    ];
    return Scaffold(
      floatingActionButton: FloatingActionButton(
          onPressed: ()
          {
            navigateTo(context, const AddMeal());
          },
           backgroundColor: ColorsManager.mainColor,
            child: const Icon(
              Icons.add,
              color: ColorsManager.white,
            ),
      ),
      body: Padding(
        padding: designApp,
        child: Column(
          children: [
            defaultAppBar(title: AppString.mealSchedule, context: context),
            CalendarTimeline(
              initialDate: DateTime(2022, 12, 26),
              firstDate: DateTime(2022, 1, 1),
              lastDate: DateTime(2025, 12, 31),
              onDateSelected: (date) => print(date),
              leftMargin: 20,
              shrink: true,
              monthColor: Colors.grey,
              dayColor: Colors.grey,
              activeDayColor: Colors.white,
              activeBackgroundDayColor: ColorsManager.mainColor,
              dotsColor: Colors.white,
              locale: 'en',
            ),
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(
                  parent: AlwaysScrollableScrollPhysics()
                ),
                itemBuilder: (context, index) => buildMealsItem(meals[index]),
                itemCount: meals.length,
              ),
            )
          ],
        ),
      ),
    );
  }
}



