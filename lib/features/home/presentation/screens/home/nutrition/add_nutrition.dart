import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/features/home/domain/entities/add_nutrition_entity.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../../core/util/resources/appString.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../../../../core/util/resources/colors_manager.dart';
import '../../../../../../core/util/resources/constants_manager.dart';
import '../../../../../../core/util/widgets/default_button.dart';
import '../../../../../../core/util/widgets/default_text.dart';
import '../../../controller/home_cubit.dart';

class AddNutrition extends StatelessWidget {
  AddNutrition({
    Key? key,
    this.nutritionEntity,
    // required this.mealType
  }) : super(key: key);
  AddNutritionEntity? nutritionEntity;
  var formKey = GlobalKey<FormState>();

  // String mealType ;
  @override
  Widget build(BuildContext context) {
    TextEditingController mealNameController = TextEditingController();
    TextEditingController componentController = TextEditingController();
    TextEditingController caloriesController = TextEditingController();
    TextEditingController fatController = TextEditingController();
    TextEditingController proteinController = TextEditingController();
    TextEditingController carbohydrateController = TextEditingController();
    TextEditingController howToPrepareController = TextEditingController();
    TextEditingController quantityController = TextEditingController();
    HomeCubit homeCubit = HomeCubit.get(context);
    Map componentNutrition = {};

    if (nutritionEntity != null) {
      componentNutrition = nutritionEntity!.nutritionComponent!;
      mealNameController.text = nutritionEntity!.nutritionName!;
      caloriesController.text = nutritionEntity!.nutritionCalories!.toString();
      fatController.text = nutritionEntity!.nutritionFat!.toString();
      proteinController.text = nutritionEntity!.nutritionProtein!.toString();
      carbohydrateController.text = nutritionEntity!.nutritionCarb!.toString();
      homeCubit.components(componentNutrition);
      if (nutritionEntity!.nutritionHowToPrepare != null) {
        howToPrepareController.text = nutritionEntity!.nutritionHowToPrepare!;
      }
    }

    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AddNutritionSuccessState) {
            Navigator.pop(context);
            if (nutritionEntity != null) {
              Navigator.pop(context);
            }
            designToastDialog(
              context: context,
              toast: TOAST.success,
              text: nutritionEntity == null
                  ? 'Nutrition Added Successfully'
                  : 'Nutrition Updated Successfully',
            );
            mealNameController.clear();
            componentController.clear();
            caloriesController.clear();
            fatController.clear();
            proteinController.clear();
            carbohydrateController.clear();
            howToPrepareController.clear();
            quantityController.clear();
            componentNutrition.clear();
            homeCubit.mealImageFile = null;
            homeCubit.getNutrition();
          }
          if (state is AddNutritionErrorState) {
            designToastDialog(
                context: context,
                toast: TOAST.error,
                text: state.failure.toString());
          }
        },
        builder: (context, state) {
          return state is AddNutritionLoadingState?const LoadingPage():HideKeyboardPage(
            child: Padding(
              padding: designApp,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultAppBar(title: 'Add Nutrition', context: context),
                    verticalSpace(5.h),
                    Expanded(
                      child: SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                homeCubit.selectMealImage(context);
                              },
                              child: SizedBox(
                                height: 140.rSp,
                                width: 180.rSp,
                                child: homeCubit.mealImageFile == null
                                    ? SvgPicture.asset(
                                        Assets.images.svg.addMeal)
                                    : CircleAvatar(
                                        backgroundImage:
                                            FileImage(homeCubit.mealImageFile!),
                                      ),
                              ),
                            ),
                            DropdownButton(
                              isExpanded: true,
                              value: homeCubit.selectedNutritionValue,
                              items: homeCubit.selectedNutritionCat,
                              onChanged: (value) {
                                homeCubit.changeDropDownSelectedNutritionCValue(
                                    value!);
                              },
                            ),
                            DefaultTextField(
                              controller: mealNameController,
                              hint: AppString.nameOfMeal,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'isEmpty';
                                }
                                return null;
                              },
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultTextField(
                                    controller: componentController,
                                    hint: 'Component',
                                  ),
                                ),
                                horizontalSpace(3.w),
                                Expanded(
                                  child: DefaultTextField(
                                    controller: quantityController,
                                    hint: 'Quantity',
                                  ),
                                ),
                                horizontalSpace(1.w),
                                Padding(
                                  padding: EdgeInsets.only(bottom: 2.h),
                                  child: defaultActionButton(
                                      onPressed: () {
                                        componentNutrition[componentController
                                            .text] = quantityController.text;
                                        debugPrintFullText(
                                            componentNutrition.toString());
                                        componentController.clear();
                                        quantityController.clear();
                                        // designToastDialog(
                                        //     context: context,
                                        //     toast: TOAST.success,
                                        //     text:
                                        //         'Component Added Successfully Add more if you want');

                                        // componentNutrition.forEach((key, value)
                                        // {
                                        //   debugPrintFullText(key);
                                        //   debugPrintFullText(value);
                                        //  // homeCubit.component = key;
                                        // }
                                        // );
                                        homeCubit
                                            .components(componentNutrition);
                                        debugPrintFullText(
                                            homeCubit.component.toString());
                                        debugPrintFullText(
                                            homeCubit.quantity.toString());
                                      },
                                      icon: Icons.add,
                                      backgroundColor: Colors.green),
                                )
                              ],
                            ),
                            if (homeCubit.component != null &&
                                componentNutrition.isNotEmpty)
                              ExpansionTile(
                                title: const DefaultText(
                                    title: 'See your components',
                                    style: Style.medium),
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 1.h),
                                        child: Row(
                                          children: [
                                            Expanded(
                                                child: DefaultText(
                                                    align: TextAlign.center,
                                                    title: homeCubit
                                                        .component![index],
                                                    style: Style.small)),
                                            horizontalSpace(3.w),
                                            Expanded(
                                                child: DefaultText(
                                                    align: TextAlign.center,
                                                    title: homeCubit
                                                        .quantity![index],
                                                    style: Style.small)),
                                            horizontalSpace(3.w),
                                            defaultActionButton(
                                                onPressed: () {
                                                  componentNutrition.remove(
                                                      homeCubit
                                                          .component![index]);
                                                  homeCubit.components(
                                                      componentNutrition);
                                                  debugPrintFullText(
                                                      componentNutrition
                                                          .toString());
                                                },
                                                icon: Icons
                                                    .remove_circle_outline_outlined,
                                                backgroundColor:
                                                    ColorsManager.white,
                                                iconColor: ColorsManager.error),
                                          ],
                                        ),
                                      );
                                    },
                                    itemCount: homeCubit.component!.length,
                                  )
                                ],
                              ),
                            verticalSpace(3.h),
                            DefaultTextField(
                              controller: howToPrepareController,
                              hint: 'How to prepare',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultTextField(
                                    controller: caloriesController,
                                    type: TextInputType.phone,
                                    hint: AppString.calories,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'isEmpty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                horizontalSpace(3.w),
                                Expanded(
                                  child: DefaultTextField(
                                    controller: fatController,
                                    type: TextInputType.phone,
                                    hint: AppString.fat,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'isEmpty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: DefaultTextField(
                                    controller: proteinController,
                                    hint: AppString.protein,
                                    type: TextInputType.phone,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'isEmpty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                horizontalSpace(3.w),
                                Expanded(
                                  child: DefaultTextField(
                                    controller: carbohydrateController,
                                    type: TextInputType.phone,
                                    hint: AppString.carbohydrate,
                                    validate: (String? value) {
                                      if (value!.isEmpty) {
                                        return 'isEmpty';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            verticalSpace(3.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                DefaultText(
                                  title: AppString.visibility,
                                  style: Style.extraSmall,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                ),
                                const Spacer(),
                                if (nutritionEntity == null ||
                                    nutritionEntity!.nutritionVisibility ==
                                        'private')
                                  InkWell(
                                    child: SvgPicture.asset(homeCubit
                                                .isVisibilityExerciseIcon ==
                                            false
                                        ? Assets.images.svg.visibility_false
                                        : Assets.images.svg.visibility_true),
                                    onTap: () {
                                      homeCubit.visibilityExercise();
                                    },
                                  ),
                                if (nutritionEntity != null &&
                                    nutritionEntity!.nutritionVisibility ==
                                        'public')
                                  InkWell(
                                    child: SvgPicture.asset(homeCubit
                                                .isVisibilityExerciseIcon ==
                                            false
                                        ? Assets.images.svg.visibility_true
                                        : Assets.images.svg.visibility_false),
                                    onTap: () {
                                      homeCubit.visibilityExercise();
                                    },
                                  ),
                              ],
                            ),
                            verticalSpace(6.h),
                            DefaultButton(
                              text: AppString.done,
                              onPressed: () {
                                if (componentNutrition.isNotEmpty) {
                                  if (formKey.currentState!.validate()) {
                                    if (nutritionEntity == null) {
                                      if (homeCubit.mealImageFile != null) {
                                        homeCubit.addNutrition(
                                          update: false,
                                          calories: double.parse(
                                              caloriesController.text),
                                          carb: double.parse(
                                              carbohydrateController.text),
                                          fat: double.parse(fatController.text),
                                          protein: double.parse(
                                              proteinController.text),
                                          nutritionName:
                                              mealNameController.text,
                                          nutritionCategory:
                                              homeCubit.selectedNutritionValue,
                                          nutritionVisibility: homeCubit
                                              .visibilityExerciseValue
                                              .toString(),
                                          nutritionPic:
                                              homeCubit.mealImageFile!,
                                          component: componentNutrition,
                                          howToPrepare:
                                              howToPrepareController.text,
                                        );
                                      } else {
                                        designToastDialog(
                                          context: context,
                                          toast: TOAST.warning,
                                          text: 'Please select meal image',
                                        );
                                      }
                                    } else {
                                      showDialog(
                                          context: context,
                                          builder: (context) {
                                            return DefaultDialog(
                                              message:
                                                  'Are you sure to update this Nutrition',
                                              pushButtonText: 'yes',
                                              buttonColor:
                                                  ColorsManager.warning,
                                              pushButtonVoidCallback: () {
                                                homeCubit.addNutrition(
                                                  update: true,
                                                  nutritionId: nutritionEntity!
                                                      .nutritionId,
                                                  calories: double.parse(
                                                      caloriesController.text),
                                                  carb: double.parse(
                                                      carbohydrateController
                                                          .text),
                                                  fat: double.parse(
                                                      fatController.text),
                                                  protein: double.parse(
                                                      proteinController.text),
                                                  nutritionName:
                                                      mealNameController.text,
                                                  nutritionCategory: homeCubit
                                                      .selectedNutritionValue,
                                                  nutritionVisibility: homeCubit
                                                      .visibilityExerciseValue
                                                      .toString(),
                                                  nutritionPic:
                                                      homeCubit.mealImageFile,
                                                  component: componentNutrition,
                                                  howToPrepare:
                                                      howToPrepareController
                                                          .text,
                                                );
                                              },
                                            );
                                          });
                                    }
                                  }
                                } else {
                                  designToastDialog(
                                    context: context,
                                    toast: TOAST.error,
                                    text: 'Please Add Nutrition Component',
                                  );
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
