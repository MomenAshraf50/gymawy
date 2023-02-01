import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition.dart';

import '../../../../../../core/util/resources/appString.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/widgets/default_action_button.dart';
import '../../../widgets/build_exercise_item.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: designApp,
        child: Column(
              children: [
                defaultAppBar(
                  title: AppString.nutrition,
                  context: context,
                  actions: [
                      defaultActionButton(
                        onPressed: () {
                        },
                        icon: Icons.search,
                        backgroundColor: ColorsManager.white,
                        iconColor: ColorsManager.black,
                      ),
                    horizontalSpace(5.w),
                    defaultActionButton(
                          icon: Icons.add,
                          onPressed: ()
                          {
                            navigateTo(context, AddNutrition());
                          },
                          backgroundColor: Colors.green)
                  ],
                ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) => buildExercisesItems(
                      exerciseImage: 'https://media.istockphoto.com/id/1309328823/photo/headshot-portrait-of-smiling-male-employee-in-office.jpg?b=1&s=170667a&w=0&k=20&c=MRMqc79PuLmQfxJ99fTfGqHL07EDHqHLWg0Tb4rPXQc=',
                      exerciseName: 'homeCubit',
                      exerciseCategory: 'homeCubit',
                    ),
                    itemCount: 7,
                    physics: const BouncingScrollPhysics(),
                  ),
                )

              ],
        ),
      ),
    );
  }
}
