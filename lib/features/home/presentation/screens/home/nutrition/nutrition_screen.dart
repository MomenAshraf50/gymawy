import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition_details.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/nutrition_basic_data.dart';
import 'package:gymawy/features/home/presentation/screens/search/search_screen.dart';
import '../../../../../../core/util/resources/appString.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/widgets/default_action_button.dart';
import '../../../widgets/build_exercise_item.dart';

class NutritionScreen extends StatelessWidget {
  NutritionScreen({Key? key, this.planId, this.isAddNutrition})
      : super(key: key);
  bool? isAddNutrition;
  int? planId;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.getNutrition();
    return Scaffold(
      body: BlocBuilder<HomeCubit, HomeStates>(
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
                      if (isAddNutrition != true)
                        defaultActionButton(
                          onPressed: () {
                            navigateTo(
                                context,
                                SearchScreen(
                                  isNutrition: true,
                                ));
                          },
                          icon: Icons.search,
                          backgroundColor: ColorsManager.white,
                          iconColor: ColorsManager.black,
                        ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemBuilder: (context, index) => InkWell(
                        onTap: () {
                          if (isAddNutrition != true) {
                            navigateTo(
                                context,
                                NutritionBasicData(
                                  nutritionEntity:
                                      homeCubit.nutritionResult![index],
                                ));
                          }

                          if (isAddNutrition == true) {
                            navigateTo(
                                context,
                                AddNutritionDetails(
                                  nutritionResult:
                                      homeCubit.nutritionResult![index],
                                  planId: planId,
                                  update: false,
                                ));
                          }
                        },
                        child: buildExercisesItems(
                          exerciseImage:
                              homeCubit.nutritionResult![index].nutritionPic!,
                          exerciseName:
                              homeCubit.nutritionResult![index].nutritionName!,
                          exerciseCategory: homeCubit
                              .nutritionResult![index].nutritionCategory!,
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
      floatingActionButton: isCoachLogin
          ? FloatingActionButton(
              onPressed: () {
                navigateTo(context, AddNutrition());
              },
              child: const Icon(
                Icons.add,
                color: ColorsManager.white,
              ),
            )
          : Container(),
    );
  }
}
