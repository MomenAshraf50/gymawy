import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/two_option_dialog.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_details_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/add_exercise_details.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/exercises_screen.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/add_nutrition_details.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/nutrition_basic_data.dart';
import 'package:gymawy/features/home/presentation/screens/home/nutrition/nutrition_screen.dart';
import 'package:gymawy/features/home/presentation/widgets/build_plan_type.dart';
import 'package:gymawy/features/home/presentation/widgets/exercise_details.dart';
import '../../../../../../core/util/widgets/default dialog.dart';
import '../../../../domain/entities/add_nutrition_details_entity.dart';
import '../../../../domain/usecase/delete_exersice_plan_usecase.dart';
import '../../../controller/home_cubit.dart';
import '../exercises/exercise_type.dart';
import 'add_plan.dart';

class PlanDetails extends StatelessWidget {
  PlanDetails(
      {Key? key,
      this.planId,
      required this.ownerUserId,
      this.planVisibility,
      this.planName,
      this.isNutrition})
      : super(key: key);

  int? planId;
  int ownerUserId;
  String? planName;
  String? planVisibility;
  bool? isNutrition;

  List<NutritionDetailsEntity>? nutritionResults;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    debugPrintFullText('$planId');
    debugPrintFullText('$ownerUserId');
    debugPrintFullText('$planVisibility');
    debugPrintFullText('$planName');
    debugPrintFullText('$isNutrition');

    if (isNutrition == false) {
      homeCubit.getExercisePlanDetails(planId!);
    }

    if (isNutrition == true) {
      homeCubit.getNutritionPlanDetails(planId!);
    }

    return SafeArea(
      child: Scaffold(
        body: BlocConsumer<HomeCubit, HomeStates>(
          listener: (context, state) {
            if (state is DeleteExercisePlanSuccessState) {
              Navigator.pop(context);
              Navigator.pop(context);
              homeCubit.getPlan(isNutrition: isNutrition!);
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: 'Plan Deleted Successfully');
            }

            if (state is DeleteExercisePlanDetailsSuccessState) {
              Navigator.pop(context);
              designToastDialog(
                  context: context,
                  toast: TOAST.success,
                  text: isNutrition == true
                      ? 'Nutrition Deleted Successfully'
                      : 'Exercise Deleted Successfully');
              if (isNutrition == false) {
                homeCubit.getExercisePlanDetails(planId!);
              }

              if (isNutrition == true) {
                homeCubit.getNutritionPlanDetails(planId!);
              }
            }

            if (state is GetNutritionDetailsSuccessState) {
              nutritionResults = state.nutritionPlanDetailList;
            }
          },
          builder: (context, state) {
            return WillPopScope(
              onWillPop: () async {
                Navigator.pop(context);
                homeCubit.getPlan(
                  isNutrition: isNutrition!,
                );
                return false;
              },
              child: Padding(
                padding: designApp,
                child: Column(
                  children: [
                    defaultAppBar(
                      title: planName!,
                      context: context,
                      onPressed: () {
                        Navigator.pop(context);
                        homeCubit.getPlan(
                          isNutrition: isNutrition!,
                        );
                      },
                      actions: [
                        if (userId == ownerUserId)
                          defaultActionButton(
                            onPressed: () {
                              navigateTo(
                                  context,
                                  AddPlan(
                                    isNutrition: isNutrition!,
                                    planId: planId,
                                    planName: planName,
                                    planVisibility: planVisibility,
                                  ));
                            },
                            icon: Icons.edit,
                            backgroundColor: ColorsManager.white,
                            iconColor: ColorsManager.black,
                          ),
                        if (userId == ownerUserId)
                          defaultActionButton(
                            onPressed: () {
                              isNutrition == false
                                  ? navigateTo(
                                      context,
                                      ExercisesScreen(
                                        isAddExercise: true,
                                        planId: planId,
                                      ))
                                  : navigateTo(
                                      context,
                                      NutritionScreen(
                                        isAddNutrition: true,
                                        planId: planId,
                                      ));
                            },
                            icon: Icons.add,
                            backgroundColor: Colors.green,
                            iconColor: ColorsManager.white,
                          ),
                      ],
                    ),
                    verticalSpace(2.h),
                    if (homeCubit.exerciseDetailsResult != null &&
                        isNutrition == false)
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                if (userId == ownerUserId) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TwoOptionsDialog(
                                          message: 'Your action:',
                                          popButtonText: 'Delete',
                                          pushButtonText: 'Update',
                                          color: ColorsManager.redPrimary,
                                          colorEdit: ColorsManager.green,
                                          pushButtonVoidCallback: () {
                                            navigateTo(
                                                context,
                                                AddExerciseDetails(
                                                  update: true,
                                                  exerciseEntity: homeCubit
                                                          .exerciseDetailsResult![
                                                      index],
                                                  planId: homeCubit
                                                      .exerciseDetailsResult![
                                                  index].planId,
                                                ));
                                          },
                                          popButtonVoidCallback: () {
                                            homeCubit.deleteExercisePlanDetails(
                                                DeleteExercisePlanDetailsParams(
                                                    homeCubit
                                                        .exerciseDetailsResult![
                                                            index]
                                                        .exerciseDetailId,
                                                    isNutrition!));
                                          });
                                    },
                                  );
                                }
                              },
                              onTap: () {
                                navigateTo(
                                    context,
                                    ExerciseType(
                                      id: homeCubit
                                          .exerciseDetailsResult![index]
                                          .exerciseDetailId,
                                      video: homeCubit
                                          .exerciseDetailsResult![index]
                                          .exerciseModel
                                          .exerciseVid,
                                      pic: homeCubit
                                          .exerciseDetailsResult![index]
                                          .exerciseModel
                                          .exercisePic,
                                      cat: homeCubit
                                          .exerciseDetailsResult![index]
                                          .exerciseModel
                                          .exerciseCategory,
                                      makerName: homeCubit
                                          .exerciseDetailsResult![index]
                                          .exerciseModel
                                          .exerciseMaker,
                                      name: homeCubit
                                          .exerciseDetailsResult![index]
                                          .exerciseModel
                                          .exerciseName,
                                      sets: homeCubit
                                          .exerciseDetailsResult![index].sets,
                                      rest: homeCubit
                                          .exerciseDetailsResult![index].rest
                                          .toInt(),
                                      reps: homeCubit
                                          .exerciseDetailsResult![index].reps,
                                    ));
                                debugPrintFullText('$index');
                              },
                              child: exerciseDetails(
                                exerciseImage: homeCubit
                                    .exerciseDetailsResult![index]
                                    .exerciseModel
                                    .exercisePic,
                                exerciseName: homeCubit
                                    .exerciseDetailsResult![index]
                                    .exerciseModel
                                    .exerciseName,
                                exerciseCategory: homeCubit
                                    .exerciseDetailsResult![index]
                                    .exerciseModel
                                    .exerciseCategory,
                                reps: homeCubit
                                    .exerciseDetailsResult![index].reps,
                                rest: homeCubit
                                    .exerciseDetailsResult![index].rest
                                    .toInt(),
                                sets: homeCubit
                                    .exerciseDetailsResult![index].sets,
                                isExercisePlanDetails: true,
                              ),
                            );
                          },
                          itemCount: homeCubit.exerciseDetailsResult!.length,
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                    if (nutritionResults != null && isNutrition == true)
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return InkWell(
                              onLongPress: () {
                                debugPrintFullText(
                                    '${nutritionResults![index].nutritionModel.userName}');
                                debugPrintFullText('$userName');

                                if (userId == ownerUserId) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return TwoOptionsDialog(
                                          message: 'Your action:',
                                          popButtonText: 'Delete',
                                          pushButtonText: 'Update',
                                          color: ColorsManager.redPrimary,
                                          colorEdit: ColorsManager.green,
                                          pushButtonVoidCallback: () {
                                            navigateTo(
                                                context,
                                                AddNutritionDetails(
                                                  nutritionDetailsEntity:
                                                      nutritionResults![index],
                                                  update: true,
                                                ));
                                          },
                                          popButtonVoidCallback: () {
                                            homeCubit.deleteExercisePlanDetails(
                                                DeleteExercisePlanDetailsParams(
                                                    nutritionResults![index]
                                                        .nutritionDetailId,
                                                    isNutrition!));
                                          });
                                    },
                                  );
                                }
                              },
                              onTap: () {
                                navigateTo(
                                    context,
                                    NutritionBasicData(
                                      nutritionEntity: nutritionResults![index]
                                          .nutritionModel,
                                      details: true,
                                    ));
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 3.h),
                                child: exerciseDetails(
                                  exerciseImage: nutritionResults![index]
                                      .nutritionModel
                                      .nutritionPic!,
                                  exerciseName: nutritionResults![index]
                                      .nutritionModel
                                      .nutritionName!,
                                  exerciseCategory: nutritionResults![index]
                                      .nutritionModel
                                      .nutritionCategory!,
                                  isExercisePlanDetails: false,
                                ),
                              ),
                            );
                          },
                          itemCount: nutritionResults!.length,
                          physics: const BouncingScrollPhysics(),
                        ),
                      ),
                    verticalSpace(4.h),
                    if (userId == ownerUserId)
                      myButton(
                        text: AppString.delete,
                        textOnly: true,
                        color: ColorsManager.redPrimary,
                        width: double.infinity,
                        radius: 40.h,
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return DefaultDialog(
                                  message: 'Are you sure to delete this plan',
                                  pushButtonText: 'yes',
                                  buttonColor: ColorsManager.error,
                                  pushButtonVoidCallback: () {
                                    homeCubit.deletePlan(DeletePlanParams(
                                        planId!, isNutrition!));
                                  },
                                );
                              });
                        },
                      ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
