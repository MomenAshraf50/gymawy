import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/myButton.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/core/util/widgets/myTextFild.dart';
import 'package:gymawy/core/util/widgets/myTextFill.dart';
import 'package:gymawy/core/util/widgets/progress.dart';
import 'package:gymawy/core/util/widgets/text_field.dart';
import 'package:gymawy/core/util/widgets/two_option_dialog.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:lottie/lottie.dart';

class AddExerciseScreen extends StatelessWidget {
  AddExerciseScreen({Key? key}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    TextEditingController exerciseNameController = TextEditingController();
    //  List<DropdownMenuItem<String>> exerciseType =
    // const [
    //    DropdownMenuItem(value: "Abs", child: Text("Abs")),
    //    DropdownMenuItem(value: "core", child: Text("core")),
    //    DropdownMenuItem(value: "Chest", child: Text("Chest")),
    //    DropdownMenuItem(value: "back", child: Text("back")),
    //    DropdownMenuItem(value: "Shoulder", child: Text("Shoulder")),
    //    DropdownMenuItem(value: "Arms", child: Text("Arms")),
    //    DropdownMenuItem(value: "Legs", child: Text("Legs")),
    //    // 'Abs',
    //    // 'core',
    //    // 'Chest',
    //    // 'back',
    //    // 'Shoulder',
    //    // 'Arms',
    //    // 'Legs',
    //  ];
    // TextEditingController setsController = TextEditingController();
    // TextEditingController repsController = TextEditingController();
    // TextEditingController restController = TextEditingController();
    // TextEditingController equipmentController = TextEditingController();
    // TextEditingController targetMuscleController = TextEditingController();
    // TextEditingController minutesController = TextEditingController();
    // TextEditingController caloriesController = TextEditingController();
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {
        if(state is AddExerciseSuccessState)
        {
          Navigator.pop(context);
          designToastDialog(
              context: context,
              toast: TOAST.success,
              text: 'Exercise Add Successfully');
        }
      },
      builder: (context, state) {
        HomeCubit homeCubit = HomeCubit.get(context);
        return Scaffold(
          body: HideKeyboardPage(
            child: Padding(
              padding: designApp,
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    defaultAppBar(
                      title: 'Add Exercise',
                      context: context,
                      actions: [
                        defaultActionButton(
                            backgroundColor: Colors.red,
                            icon: Icons.remove,
                            onPressed: () {}),
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
                                alignment: AlignmentDirectional.bottomEnd,
                                children: [
                                  Align(
                                    alignment: AlignmentDirectional.centerStart,
                                    child: homeCubit.exerciseImageFile == null
                                        ? Lottie.asset(
                                            Assets.images.lotti.exercise,
                                    )
                                        : CircleAvatar(
                                            backgroundImage: FileImage(
                                                homeCubit.exerciseImageFile!,
                                            ),
                                      minRadius: 50.rSp,
                                      maxRadius: 100.rSp,
                                          ),
                                  ),
                                  defaultActionButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return TwoOptionsDialog(
                                            height: 20.h,
                                            message: 'Pick Exercise Shows',
                                            popButtonText: 'Photo',
                                            pushButtonText: 'Video',
                                            pushButtonVoidCallback: () {
                                              homeCubit.selectExerciseVideo();
                                              Navigator.pop(context);
                                            },
                                            popButtonVoidCallback: () {
                                              homeCubit
                                                  .selectExerciseImage(context);
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: Icons.add,
                                    backgroundColor: ColorsManager.mainColor,
                                  )
                                ],
                              ),
                            ),
                            verticalSpace(3.h),
                            myTextFill(
                                validate: (String? value) {
                                  if (value!.isEmpty) {
                                    return 'isEmpty';
                                  }
                                  return null;
                                },
                                controller: exerciseNameController,
                                hint: AppString.nameOfExercise),
                            verticalSpace(3.h),
                            Row(
                              children: [
                                myText(
                                  title: 'Choose Exercise Type',
                                  style: Style.extraSmall,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 12.rSp,
                                ),
                                const Spacer(),
                                BlocBuilder<HomeCubit, HomeStates>(
                                  builder: (context, state) {
                                    return DropdownButton(
                                      value: homeCubit.selectedValue,
                                      items: homeCubit.exerciseItems,
                                      onChanged: (value) {
                                        homeCubit.selectedValue = value!;
                                        return;
                                      },
                                    );
                                  },
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
                            // verticalSpace(6.h),
                            // InkWell(
                            //   onTap: ()
                            //   {
                            //     homeCubit.selectExerciseVideo();
                            //   },
                            //   child: Align(
                            //     alignment: AlignmentDirectional.center,
                            //     child: myText(
                            //       title: 'Press To Pick Video',
                            //       style: Style.extraSmall,
                            //       fontWeight: FontWeight.w700,
                            //       fontSize: 12.rSp,
                            //       align: TextAlign.left,
                            //     ),
                            //   ),
                            // ),

                            // textField(
                            //     controller: exerciseNameController,
                            //     label: AppString.nameOfExercise
                            // ),
                            // textField(
                            //     controller: setsController,
                            //     label: AppString.sets
                            // ),
                            // textField(
                            //     controller: repsController,
                            //     label: AppString.reps
                            // ),
                            // textField(
                            //     controller: restController,
                            //     label: AppString.rest
                            // ),
                            // textField(
                            //     controller: equipmentController,
                            //     label: AppString.equipmentRequired
                            // ),
                            // textField(
                            //     controller: targetMuscleController,
                            //     label: AppString.targetMuscle
                            // ),
                            // textField(
                            //     controller: minutesController,
                            //     label: AppString.minutes
                            // ),
                            // textField(
                            //     controller: caloriesController,
                            //     label: AppString.calories
                            // ),
                            verticalSpace(20.h),
                            myButton(
                              text: AppString.done,
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  if (homeCubit.exerciseImageFile != null) {
                                    if (homeCubit.exerciseVideo != null) {
                                      debugPrintFullText(
                                          homeCubit.selectedValue);
                                      debugPrintFullText(
                                          '${homeCubit.exerciseVideo}');
                                      debugPrintFullText(
                                          '${homeCubit.exerciseImageFile}');
                                      debugPrintFullText(
                                          '${homeCubit.isVisibilityExerciseIcon}');
                                      debugPrintFullText(
                                          '${homeCubit.visibilityExerciseValue}');
                                      homeCubit.addExercise(
                                        exerciseName: exerciseNameController.text,
                                        exerciseCategory: homeCubit.selectedValue,
                                        exerciseVisibility: homeCubit.visibilityExerciseValue!,
                                        exercisePic: homeCubit.exerciseImageFile!,
                                        exerciseVideo: homeCubit.exerciseVideo!,
                                        context: context
                                      );
                                    } else {
                                      designToastDialog(
                                          context: context,
                                          toast: TOAST.warning,
                                          text: 'please pick exercise video');
                                    }
                                  } else {
                                    designToastDialog(
                                        context: context,
                                        toast: TOAST.warning,
                                        text: 'please pick exercise photo');
                                  }
                                } else {
                                  designToastDialog(
                                      context: context,
                                      toast: TOAST.warning,
                                      text: 'please fill exercise name');
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
          ),
        );
      },
    );
  }
}
