import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/home/domain/usecase/add_nutrition_details_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../domain/entities/add_nutrition_entity.dart';

class AddNutritionDetails extends StatelessWidget {
  AddNutritionDetails({Key? key ,required this.nutritionResult, this.planId}) : super(key: key);

  AddNutritionEntity? nutritionResult;
  int? planId;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    TextEditingController hoursController = TextEditingController();
    TextEditingController minutesController = TextEditingController();
    TextEditingController secondController = TextEditingController();

    return Scaffold(
      body: BlocConsumer<HomeCubit,HomeStates>(
        listener: (context, state) {

          if(state is AddNutritionDetailsSuccessState)
          {
            Navigator.pop(context);
            Navigator.pop(context);
            designToastDialog(context: context, toast: TOAST.success, text: 'Nutrition details added successfully');
            homeCubit.getNutritionPlanDetails(planId!);
          }
          
        },
        builder: (context, state) {
          return Padding(
            padding: designApp,
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultAppBar(
                        title: 'Add Nutrition Details',
                        context: context
                    ),
                    verticalSpace(3.h),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.rSp, 0, 20.rSp, 20.rSp),
                      child: Center(
                        child: Image.network(nutritionResult!.nutritionPic!),
                      ),
                    ),
                    const myText(title: 'Select Day', style: Style.medium,fontWeight: FontWeight.w600),
                    verticalSpace(1.h),
                    DropdownButton(
                      isExpanded: true,
                      value: homeCubit.selectedDay,
                      items: homeCubit.daysValue,
                      onChanged: (value) {
                        homeCubit.changeDropDownSelectedDay(
                            value!);
                      },
                    ),
                    verticalSpace(3.h),
                    const myText(title: 'Select Meal', style: Style.medium,fontWeight: FontWeight.w600),
                    verticalSpace(1.h),
                    DropdownButton(
                      isExpanded: true,
                      value: homeCubit.selectedMealValue,
                      items: homeCubit.selectedMeal,
                      onChanged: (value) {
                        homeCubit.changeDropDownSelectedMeal(
                            value!);
                      },
                    ),
                    verticalSpace(3.h),
                    const myText(title: 'Meal Time', style: Style.medium,fontWeight: FontWeight.w600),
                    verticalSpace(1.h),
                    Row(
                      children: [
                        Expanded(
                          child: myTextFill(
                              controller: hoursController,
                              hint: 'Hour',
                              type: TextInputType.phone,
                              validate: (String? value) {
                                if (int.parse(value!) >= 24 && value.isEmpty) {
                                  return '0:24';
                                }
                                return null;
                              },
                          ),
                        ),
                        horizontalSpace(10.w),
                        Expanded(
                          child: myTextFill(
                              controller: minutesController,
                              type: TextInputType.phone,
                              hint: 'Minute',
                              validate: (String? value) {
                                if (int.parse(value!) >= 60 && value.isEmpty) {
                                  return '0:60';
                                }
                                return null;
                              },
                          ),
                        ),
                        horizontalSpace(10.w),
                        Expanded(
                          child: myTextFill(
                              controller: secondController,
                              type: TextInputType.phone,
                              hint: 'Second',
                              validate: (String? value) {
                                if (int.parse(value!)>= 60 && value.isEmpty) {
                                  return '0:60';
                                }
                                return null;
                              },
                          ),
                        ),
                      ],
                    ),
                    verticalSpace(3.h),
                    myButton(
                        text: 'Done',
                        onPressed: () {
                          if(formKey.currentState!.validate())
                          {
                            homeCubit.addNutritionDetails(NutritionDetailsParams(
                                meal: homeCubit.selectedMealValue,
                                time: '${hoursController.text}:${minutesController.text}:${secondController.text}',
                                day: homeCubit.selectedDay,
                                nutritionId: nutritionResult!.nutritionId!,
                                planId: planId!
                            ));
                          } else {
                            designToastDialog(
                                context: context,
                                toast: TOAST.warning,
                                text: 'Please enter nutrition data correctly'
                            );
                          }

                        },
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
