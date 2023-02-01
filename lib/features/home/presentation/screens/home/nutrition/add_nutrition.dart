import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../../../core/util/resources/appString.dart';
import '../../../../../../core/util/resources/assets.gen.dart';
import '../../../../../../core/util/resources/constants_manager.dart';
import '../../../../../../core/util/widgets/myButton.dart';
import '../../../../../../core/util/widgets/myText.dart';
import '../../../controller/home_cubit.dart';

class AddNutrition extends StatelessWidget {
  AddNutrition({
    Key? key,
    // required this.mealType
  }) : super(key: key);

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
    final Map<String, String> componentNutrition = {};
    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AddNutritionSuccessState) {
            Navigator.pop(context);
            designToastDialog(
              context: context,
              toast: TOAST.success,
              text: 'Nutrition Added Successfully',
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
            homeCubit.mealImageFile == null;
          }
        },
        builder: (context, state) {
          return HideKeyboardPage(
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
                            myTextFill(
                              controller: mealNameController,
                              hint: AppString.nameOfMeal,
                              validate: (String? value) {
                                if (value!.isEmpty) {
                                  return 'isEmpty';
                                }
                                return null;
                              },
                            ),
                            Row (
                              children: [
                                Expanded(
                                  child: myTextFill(
                                    controller: componentController,
                                    hint: 'Component',
                                  ),
                                ),
                                horizontalSpace(3.w),
                                Expanded(
                                  child: myTextFill(
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
                                        debugPrintFullText(componentNutrition.toString());
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
                                        homeCubit.components(componentNutrition);
                                        debugPrintFullText(homeCubit.component.toString());
                                        debugPrintFullText(homeCubit.quantity.toString());
                                      },
                                      icon: Icons.add,
                                      backgroundColor: Colors.green),
                                )
                              ],
                            ),
                            if(homeCubit.component != null)
                            ExpansionTile(
                               title: const myText(
                                   title: 'See your component',
                                   style: Style.medium
                               ),
                               children: [
                                 ListView.builder(
                                   shrinkWrap: true,
                                   itemBuilder: (context, index) {
                                     return Padding(
                                       padding: EdgeInsets.symmetric(vertical: 1.h),
                                       child: Row(
                                         children: [
                                           Expanded(child:
                                           myText(
                                               align: TextAlign.center,
                                               title: homeCubit.component![index],
                                               style: Style.small
                                           )),
                                           horizontalSpace(3.w),
                                           Expanded(child:
                                           myText(
                                               align: TextAlign.center,
                                               title: homeCubit.quantity![index],
                                               style: Style.small
                                           )),
                                         ],
                                       ),
                                     );
                                   },
                                   itemCount: homeCubit.component!.length,
                                 )
                               ],

                           ),

                            verticalSpace(3.h),
                            myTextFill(
                              controller: howToPrepareController,
                              hint: 'How to prepare',
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: myTextFill(
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
                                  child: myTextFill(
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
                                  child: myTextFill(
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
                                  child: myTextFill(
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
                                myText(
                                  title: AppString.visibility,
                                  style: Style.extraSmall,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                ),
                                const Spacer(),
                                InkWell(
                                  child: SvgPicture.asset(
                                      homeCubit.isVisibilityExerciseIcon!
                                          ? Assets.images.svg.visibility_true
                                          : Assets.images.svg.visibility_false),
                                  onTap: () {
                                    homeCubit.visibilityExercise();
                                  },
                                ),
                              ],
                            ),
                            verticalSpace(6.h),
                            myButton(
                              text: AppString.done,
                              onPressed: () {
                                if (formKey.currentState!.validate() &&
                                    componentNutrition.isNotEmpty) {
                                  homeCubit.addNutrition(
                                    calories:
                                    int.parse(caloriesController.text),
                                    carb:
                                    int.parse(carbohydrateController.text),
                                    fat: int.parse(fatController.text),
                                    protein: int.parse(proteinController.text),
                                    nutritionName: mealNameController.text,
                                    nutritionCategory:
                                    homeCubit.selectedNutritionValue,
                                    nutritionVisibility: homeCubit
                                        .visibilityExerciseValue
                                        .toString(),
                                    nutritionPic: homeCubit.mealImageFile!,
                                    component: componentNutrition,
                                    howToPrepare: howToPrepareController.text,
                                  );
                                }

                                debugPrintFullText(homeCubit.mealImageFile!.toString());
                                debugPrintFullText(homeCubit.selectedNutritionValue);
                                debugPrintFullText(mealNameController.text);
                                debugPrintFullText('component$componentNutrition');
                                debugPrintFullText('howto${howToPrepareController.text}');
                                debugPrintFullText('cal${caloriesController.text}');
                                debugPrintFullText('fat${fatController.text}');
                                debugPrintFullText('carb${carbohydrateController.text}');
                                debugPrintFullText('protein${proteinController.text}');
                                debugPrintFullText('${homeCubit.visibilityExerciseValue}');











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
