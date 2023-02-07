import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/features/home/domain/entities/add_exercise_entity.dart';
import 'package:gymawy/features/home/domain/entities/exercise_details_entity.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';

class AddExerciseDetails extends StatelessWidget {
  AddExerciseDetails(
      {Key? key,
        this.planId,
       this.exerciseId,
      required this.update,
      this.exerciseEntity})
      : super(key: key);

  int? exerciseId;
  int? planId;
  bool update;

  ExerciseDetailsEntity? exerciseEntity;

  @override
  Widget build(BuildContext context) {
    TextEditingController setsController = TextEditingController();
    TextEditingController repsController = TextEditingController();
    TextEditingController restController = TextEditingController();

    var formKey = GlobalKey<FormState>();

    HomeCubit homeCubit = HomeCubit.get(context);

    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if (state is AddExerciseDetailsSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          if(update){
            Navigator.pop(context);
          }
          designToastDialog(
              context: context,
              toast: TOAST.success,
              text: update? 'Exercise Details Updated Successfully':'Exercise Details Added Successfully');

          homeCubit.getExercisePlanDetails(planId!);
        }
      },
      builder: (context, state) {
        if(update){
          setsController.text = exerciseEntity!.sets.toString();
          repsController.text = exerciseEntity!.reps.toString();
          restController.text = exerciseEntity!.rest.toString();
        }
        return Scaffold(
          body: Form(
            key: formKey,
            child: HideKeyboardPage(
              child: SingleChildScrollView(
                child: Padding(
                  padding: designApp,
                  child: Column(
                    children: [
                      defaultAppBar(
                        title:update? 'Update Exercise Details': 'Add Exercise Details',
                        context: context,
                      ),
                      myTextFill(
                        controller: setsController,
                        hint: AppString.sets,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      myTextFill(
                        controller: repsController,
                        hint: AppString.reps,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      myTextFill(
                        controller: restController,
                        hint: AppString.restInSeconds,
                        type: TextInputType.number,
                        validate: (value) {
                          if (value!.isEmpty) {
                            return 'This field can\'t be empty';
                          }
                          return null;
                        },
                      ),
                      DropdownButton(
                        isExpanded: true,
                        value: homeCubit.selectedDay,
                        items: homeCubit.daysValue,
                        onChanged: (value) {
                          homeCubit.changeDropDownSelectedDay(value!);
                          debugPrintFullText('second  value  is =$value');
                          debugPrintFullText(
                              'second is =${homeCubit.selectedDay}');
                        },
                      ),
                      verticalSpace(10.h),
                      myButton(
                          text:update? AppString.update:AppString.addExercise,
                          onPressed: () {
                            if(update){
                              showDialog(context: context, builder: (context) => DefaultDialog(
                                message: 'Are you sure to update this Exercise Details',
                                pushButtonText: AppString.update,
                                pushButtonVoidCallback: (){
                                  homeCubit
                                      .addExerciseDetails(ExerciseDetailsParams(
                                    exerciseDetailId: exerciseEntity!.exerciseDetailId,
                                    update: true,
                                    sets: int.parse(setsController.text),
                                    rest: double.parse(restController.text),
                                    reps: int.parse(repsController.text),
                                    day: homeCubit.selectedDay,
                                  ));
                                },
                              ),);

                            }else{
                              if (formKey.currentState!.validate()) {
                                homeCubit
                                    .addExerciseDetails(ExerciseDetailsParams(
                                  update: false,
                                  sets: int.parse(setsController.text),
                                  rest: double.parse(restController.text),
                                  reps: int.parse(repsController.text),
                                  planId: planId!,
                                  day: homeCubit.selectedDay,
                                  exerciseId: exerciseId!,
                                ));
                              }
                            }
                          }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
