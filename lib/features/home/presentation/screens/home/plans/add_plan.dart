import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';

import '../../../../../../core/util/widgets/hideKeyboard.dart';

class AddPlan extends StatelessWidget {
  AddPlan(
      {Key? key,
      this.planId,
      this.planVisibility,
      this.planName,
      required this.isNutrition})
      : super(key: key);
  var formKey = GlobalKey<FormState>();
  int? planId;
  String? planName;
  String? planVisibility;
  bool isNutrition;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);

    if (planVisibility != null && planName != null) {
      homeCubit.nameOfPlanController.text = planName!;
      homeCubit.visibilityExerciseValue = planVisibility!;
    }

    return SafeArea(
      child: Scaffold(
        body: Form(
          key: formKey,
          child: Padding(
            padding: designApp,
            child: BlocConsumer<HomeCubit, HomeStates>(
              listener: (context, state) {
                if (state is UpdatePlanSuccessState) {
                  Navigator.pop(context);
                  Navigator.pop(context);
                  homeCubit.nameOfPlanController.text = '';
                  homeCubit.getPlan(
                    isNutrition: isNutrition,
                  );
                  designToastDialog(
                      context: context,
                      toast: TOAST.success,
                      text: 'Plan Updated Successfully');
                }
                if (state is AddPlanSuccessState) {
                  Navigator.pop(context);
                  homeCubit.getPlan(isNutrition: isNutrition);
                  homeCubit.nameOfPlanController.text = '';
                  designToastDialog(
                      context: context,
                      toast: TOAST.success,
                      text: 'Plan Added Successfully');
                }

                if (state is AddPlanErrorState) {
                  designToastDialog(
                      context: context,
                      toast: TOAST.error,
                      text: state.failure);
                }
                if (state is UpdatePlanErrorState) {
                  designToastDialog(
                      context: context,
                      toast: TOAST.error,
                      text: state.failure);
                }
              },
              builder: (context, state) {
                return state is AddPlanLoadingState ||
                        state is UpdatePlanLoadingState
                    ? const LoadingPage()
                    : SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: HideKeyboardPage(
                          child: Column(
                            children: [
                              defaultAppBar(
                                  title: isNutrition
                                      ? AppString.addNutritionPlan
                                      : AppString.addExercisePlan,
                                  context: context,
                                  onPressed: () {
                                    Navigator.pop(context);
                                  }),
                              verticalSpace(20.h),
                              DefaultTextField(
                                controller: homeCubit.nameOfPlanController,
                                hint: planName ?? AppString.nameOfPlan,
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'isEmpty';
                                  }
                                  return null;
                                },
                              ),
                              verticalSpace(5.h),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DefaultText(
                                      title: AppString.visibility,
                                      style: Style.extraSmall,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 12.rSp,
                                    ),
                                    const Spacer(),
                                    if (planVisibility == null ||
                                        planVisibility == 'private')
                                      InkWell(
                                        child: SvgPicture.asset(homeCubit
                                                    .isVisibilityExerciseIcon ==
                                                false
                                            ? Assets.images.svg.visibility_false
                                            : Assets
                                                .images.svg.visibility_true),
                                        onTap: () {
                                          homeCubit.visibilityExercise();
                                        },
                                      ),
                                    if (planVisibility != null &&
                                        planVisibility == 'public')
                                      InkWell(
                                        child: SvgPicture.asset(homeCubit
                                                    .isVisibilityExerciseIcon ==
                                                false
                                            ? Assets.images.svg.visibility_true
                                            : Assets
                                                .images.svg.visibility_false),
                                        onTap: () {
                                          homeCubit.visibilityExercise();
                                        },
                                      ),
                                  ],
                                ),
                              ),
                              verticalSpace(30.h),
                              Padding(
                                padding: EdgeInsets.only(bottom: 5.h),
                                child: DefaultButton(
                                  text: AppString.done,
                                  onPressed: () {
                                    debugPrintFullText(
                                        'plan name ======================${homeCubit.nameOfPlanController.text}');
                                    debugPrintFullText(
                                        'plan visibility ======================${homeCubit.visibilityExerciseValue}');

                                    if (planId == null) {
                                      if (formKey.currentState!.validate()) {
                                        homeCubit.addPlan(
                                            isNutrition: isNutrition,
                                            planName: homeCubit
                                                .nameOfPlanController.text,
                                            planVisibility: homeCubit
                                                .visibilityExerciseValue);
                                      }
                                    } else {
                                      homeCubit.updatePlan(
                                        planName:
                                            homeCubit.nameOfPlanController.text,
                                        planVisibility:
                                            homeCubit.visibilityExerciseValue,
                                        planId: planId!,
                                        isNutrition: isNutrition,
                                      );
                                    }
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
