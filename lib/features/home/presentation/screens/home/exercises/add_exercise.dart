import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/text_field.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:lottie/lottie.dart';

class AddExerciseScreen extends StatelessWidget {
  const AddExerciseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController exerciseNameController = TextEditingController();
    TextEditingController setsController = TextEditingController();
    TextEditingController repsController = TextEditingController();
    TextEditingController restController = TextEditingController();
    TextEditingController equipmentController = TextEditingController();
    TextEditingController targetMuscleController = TextEditingController();
    TextEditingController minutesController = TextEditingController();
    TextEditingController caloriesController = TextEditingController();
    return BlocBuilder<HomeCubit, HomeStates>(
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
        return Scaffold(
          body: HideKeyboardPage(
            child: Padding(
              padding: designApp,
              child: Column(
                children: [
                  defaultAppBar(
                    title: 'Add Exercise',
                    context: context,
                    actions: [
                      defaultActionButton(
                          backgroundColor: Colors.red,
                          icon: Icons.remove,
                          onPressed: () {}
                      ),

                    ],

                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: 140.rSp,
                            width: 180.rSp,
                            child: Stack(
                              alignment: AlignmentDirectional.centerEnd,
                              children: [
                                Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: homeCubit.imageFile == null
                                      ? Lottie.asset(Assets.images.lotti.exercise)
                                      : CircleAvatar(
                                    backgroundImage:
                                    FileImage(homeCubit.imageFile!),
                                  ),
                                ),

                                defaultActionButton(
                                  onPressed: (){
                                    homeCubit.selectImage(context);
                                  },
                                  icon: Icons.add,
                                  backgroundColor: ColorsManager.mainColor,
                                )
                              ],
                            ),
                          ),
                          textField(
                              controller: exerciseNameController,
                              label: AppString.nameOfExercise
                          ),
                          textField(
                              controller: setsController,
                              label: AppString.sets
                          ),
                          textField(
                              controller: repsController,
                              label: AppString.reps
                          ),
                          textField(
                              controller: restController,
                              label: AppString.rest
                          ),
                          textField(
                              controller: equipmentController,
                              label: AppString.equipmentRequired
                          ),
                          textField(
                              controller: targetMuscleController,
                              label: AppString.targetMuscle
                          ),
                          textField(
                              controller: minutesController,
                              label: AppString.minutes
                          ),
                          textField(
                              controller: caloriesController,
                              label: AppString.calories
                          ),
                          verticalSpace(3.h),
                          myButton(
                            text: AppString.done,
                            onPressed: (){},
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
    );
  }
}
