import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/nutrition_basic_data.dart';
import '../../../../../../core/util/resources/appString.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/widgets/default_action_button.dart';
import '../../../widgets/build_exercise_item.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getNutrition();
    return Scaffold(
      body: BlocBuilder<HomeCubit,HomeStates>(
        builder: (context, state) {
          if (homeCubit.nutritionResult != null) {
            return Padding(
            padding: designApp,
            child: Column(
              children: [
                defaultAppBar(
                  title: AppString.nutrition,
                  context: context,
                  actions: [
                    // defaultActionButton(
                    //   onPressed: () {
                    //   },
                    //   icon: Icons.search,
                    //   backgroundColor: ColorsManager.white,
                    //   iconColor: ColorsManager.black,
                    // ),
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
                    itemBuilder: (context, index) => InkWell(
                      onTap: () {
                        navigateTo(context, NutritionBasicData(
                          nutritionId: homeCubit.nutritionResult![index].nutritionId!,
                          userName: homeCubit.nutritionResult![index].userName!,
                          pic: homeCubit.nutritionResult![index].nutritionPic!,
                          calories: (homeCubit.nutritionResult![index].nutritionCalories!).toInt().toString(),
                          carb: (homeCubit.nutritionResult![index].nutritionCarb!).toInt().toString(),
                          category: homeCubit.nutritionResult![index].nutritionCategory!,
                          fat: (homeCubit.nutritionResult![index].nutritionFat!).toInt().toString(),
                          howToPrepare: homeCubit.nutritionResult![index].nutritionHowToPrepare!,
                          protein: (homeCubit.nutritionResult![index].nutritionProtein!).toInt().toString(),
                          nutritionName: homeCubit.nutritionResult![index].nutritionName!,
                          userId: homeCubit.nutritionResult![index].userId!,
                          visibility: homeCubit.nutritionResult![index].nutritionVisibility!,
                          component: homeCubit.nutritionResult![index].nutritionComponent!,
                        ));
                      },
                      child: buildExercisesItems(
                        exerciseImage: homeCubit.nutritionResult![index].nutritionPic!,
                        exerciseName: homeCubit.nutritionResult![index].nutritionName!,
                        exerciseCategory: homeCubit.nutritionResult![index].nutritionCategory!,
                      ),
                    ),
                    itemCount: homeCubit.nutritionResult!.length,
                    physics: const BouncingScrollPhysics(),
                  ),
                )

              ],
            ),
          );
          } else {
            return const LoadingPage();
          }
        },
      ),
    );
  }
}
