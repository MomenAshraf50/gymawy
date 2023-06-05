import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/features/home/domain/entities/add_nutrition_details_entity.dart';
import 'package:gymawy/features/home/domain/usecase/add_nutrition_details_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import '../../../../domain/entities/add_nutrition_entity.dart';

class AddNutritionDetails extends StatelessWidget {
  AddNutritionDetails(
      {Key? key,
      this.nutritionResult,
      this.planId,
      required this.update,
      this.nutritionDetailsEntity})
      : super(key: key);

  AddNutritionEntity? nutritionResult;
  NutritionDetailsEntity? nutritionDetailsEntity;
  int? planId;
  var formKey = GlobalKey<FormState>();
  bool update;
  List<String> hours = ['0','1','2','3','4','5','6','7','8','9','10','11','12'];

  @override
  Widget build(BuildContext context) {
    if (update) {
      nutritionResult = nutritionDetailsEntity!.nutritionModel;
      planId = nutritionDetailsEntity!.planId;
    }
    HomeCubit homeCubit = HomeCubit.get(context);


    return Scaffold(
      body: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {
          if (state is AddNutritionDetailsSuccessState) {
            Navigator.pop(context);
            Navigator.pop(context);
            if(update){
              Navigator.pop(context);
            }
            designToastDialog(
                context: context,
                toast: TOAST.success,
                text: update?'Nutrition details updated successfully':'Nutrition details added successfully');
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
                        title: update
                            ? 'Update Nutrition Details'
                            : 'Add Nutrition Details',
                        context: context),
                    verticalSpace(3.h),
                    Padding(
                      padding: EdgeInsetsDirectional.fromSTEB(
                          20.rSp, 0, 20.rSp, 20.rSp),
                      child: Center(
                        child: Image.network(nutritionResult!.nutritionPic!),
                      ),
                    ),
                    const DefaultText(
                        title: 'Select Day',
                        style: Style.medium,
                        fontWeight: FontWeight.w600),
                    verticalSpace(1.h),
                    DropdownButton(
                      isExpanded: true,
                      value: homeCubit.selectedDay,
                      items: homeCubit.daysValue,
                      onChanged: (value) {
                        homeCubit.changeDropDownSelectedDay(value!);
                      },
                    ),
                    verticalSpace(3.h),
                    const DefaultText(
                        title: 'Select Meal',
                        style: Style.medium,
                        fontWeight: FontWeight.w600),
                    verticalSpace(1.h),
                    DropdownButton(
                      isExpanded: true,
                      value: homeCubit.selectedMealValue,
                      items: homeCubit.selectedMeal,
                      onChanged: (value) {
                        homeCubit.changeDropDownSelectedMeal(value!);
                      },
                    ),
                    verticalSpace(3.h),
                    Row(
                      children: [
                        const DefaultText(
                            title: 'Meal Time',
                            style: Style.medium,
                            fontWeight: FontWeight.w600),
                        const Spacer(),
                        IconButton(
                            onPressed: () {
                              showTimePicker(
                                builder: (context, child) =>
                                    MediaQuery(
                                        data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true,boldText: true,textScaleFactor: 1.1.rSp ),
                                        child: child!,
                                    ),
                                context: context,
                                initialTime: TimeOfDay.now(),
                                initialEntryMode: TimePickerEntryMode.input,
                                helpText: 'Enter meal time',

                              ).then((value) {
                                homeCubit.selectedTime(value!);
                                homeCubit.timePicked = value;
                              });
                            },
                            icon: const Icon(
                              Icons.watch_later,
                              color: ColorsManager.darkGrey,
                            ))
                      ],
                    ),
                    verticalSpace(3.h),
                     if (homeCubit.timePicked != null)
                    Row(
                      children: [
                        DefaultText(
                            title: '${homeCubit.timePicked!.hour}:${homeCubit.timePicked!.minute}',
                            style: Style.medium,
                            fontWeight: FontWeight.w600),
                        const Spacer(),
                        DefaultText(
                            title: hours.contains(homeCubit.timePicked?.hour.toString()) ? 'AM': 'PM',
                            style: Style.medium,
                            fontWeight: FontWeight.w600),
                      ],
                    ),
                    verticalSpace(3.h),
                    DefaultButton(
                      text: update ? AppString.update : AppString.done,
                      onPressed: () {
                        if (update) {
                          showDialog(
                            context: context,
                            builder: (context) => DefaultDialog(
                              message:
                                  'Are you sure to update this nutrition detail',
                              pushButtonText: AppString.update,
                              pushButtonVoidCallback: () {
                                if (homeCubit.timePicked != null) {
                                  homeCubit.addNutritionDetails(
                                      NutritionDetailsParams(
                                          nutritionDetailId:
                                              nutritionDetailsEntity!
                                                  .nutritionDetailId,
                                          update: true,
                                          meal: homeCubit.selectedMealValue,
                                          time:
                                              '${homeCubit.timePicked!.hour}:${homeCubit.timePicked!.minute}',
                                          day: homeCubit.selectedDay,
                                          nutritionId:
                                              nutritionResult!.nutritionId!,
                                          planId: planId!));
                                } else {
                                  homeCubit.addNutritionDetails(
                                      NutritionDetailsParams(
                                          nutritionDetailId:
                                              nutritionDetailsEntity!
                                                  .nutritionDetailId,
                                          update: true,
                                          meal: homeCubit.selectedMealValue,
                                          time:
                                              nutritionDetailsEntity!.mealTime,
                                          day: homeCubit.selectedDay,
                                          nutritionId:
                                              nutritionResult!.nutritionId!,
                                          planId: planId!));
                                }
                              },
                            ),
                          );
                        } else {
                          if (homeCubit.timePicked != null) {
                            homeCubit.addNutritionDetails(NutritionDetailsParams(
                                update: false,
                                meal: homeCubit.selectedMealValue,
                                time:
                                    '${homeCubit.timePicked!.hour}:${homeCubit.timePicked!.minute}',
                                day: homeCubit.selectedDay,
                                nutritionId: nutritionResult!.nutritionId!,
                                planId: planId!));
                          } else {
                            designToastDialog(
                                context: context,
                                toast: TOAST.warning,
                                text: 'Please enter meal time');
                          }
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
