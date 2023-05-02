import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gymawy/core/util/resources/appString.dart';
import 'package:gymawy/core/util/resources/assets.gen.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/hideKeyboard.dart';
import 'package:gymawy/core/util/widgets/loadingPage.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/core/util/widgets/progress.dart';
import 'package:gymawy/core/util/widgets/two_option_dialog.dart';
import 'package:gymawy/features/home/domain/entities/add_exercise_entity.dart';
import 'package:gymawy/features/home/domain/usecase/add_exercise_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:lottie/lottie.dart';

class AddExerciseScreen extends StatelessWidget {
  AddExerciseScreen({Key? key, this.exerciseEntity}) : super(key: key);
  var formKey = GlobalKey<FormState>();

  AddExerciseEntity? exerciseEntity;

  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    TextEditingController exerciseNameController = TextEditingController();
    if (exerciseEntity != null) {
      exerciseNameController.text = exerciseEntity!
          .exerciseName; // debugPrintFullText(homeCubit.selectedValue);
    }
    return BlocConsumer<HomeCubit, HomeStates>(
      listener: (context, state) {

        if (state is UpdateExerciseSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          Navigator.pop(context);
          homeCubit.getExercise();
          designToastDialog(
              context: context,
              toast: TOAST.success,
              text: 'Exercise Updated Successfully');
        }
        if (state is AddExerciseSuccessState) {
          Navigator.pop(context);
          Navigator.pop(context);
          homeCubit.getExercise();
          homeCubit.exerciseVideo = null;
          homeCubit.exerciseImageFile = null;
          designToastDialog(
              context: context,
              toast: TOAST.success,
              text: 'Exercise Added Successfully');
        }
        if (state is AddExerciseErrorState) {
          Navigator.pop(context);
          designToastDialog(
              context: context, toast: TOAST.error, text: state.failure);
        }
        if (state is UpdateExerciseErrorState) {
          Navigator.pop(context);
          designToastDialog(
              context: context, toast: TOAST.error, text: state.failure);
        }
      },
      builder: (context, state) {
        debugPrintFullText(
            'ssssssssssssssssssssssssssss${homeCubit.selectedValue}');
        return Scaffold(
          body: HideKeyboardPage(
            child: state is AddExerciseLoadingState
                ? const LoadingPage()
                : Padding(
                    padding: designApp,
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          defaultAppBar(
                            title: exerciseEntity != null
                                ? 'Update Exercise'
                                : 'Add Exercise',
                            context: context,
                            // actions: [
                            //   defaultActionButton(
                            //       backgroundColor: Colors.red,
                            //       icon: Icons.remove,
                            //       onPressed: () {}),
                            // ],
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
                                          alignment:
                                              AlignmentDirectional.centerStart,
                                          child: homeCubit.exerciseImageFile ==
                                                  null
                                              ? Lottie.asset(
                                                  Assets.images.lotti.exercise,
                                                )
                                              : CircleAvatar(
                                                  backgroundImage: FileImage(
                                                    homeCubit
                                                        .exerciseImageFile!,
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
                                                  message:
                                                      'Pick Exercise Shows',
                                                  popButtonText: 'Photo',
                                                  pushButtonText: 'Video',
                                                  pushButtonVoidCallback: () {
                                                    homeCubit
                                                        .selectExerciseVideo();
                                                    Navigator.pop(context);
                                                  },
                                                  popButtonVoidCallback: () {
                                                    homeCubit
                                                        .selectExerciseImage(
                                                            context);
                                                    Navigator.pop(context);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          icon: Icons.add,
                                          backgroundColor:
                                              ColorsManager.mainColor,
                                        )
                                      ],
                                    ),
                                  ),
                                  verticalSpace(3.h),
                                  DefaultTextField(
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
                                      DefaultText(
                                        title: 'Choose Exercise Type',
                                        style: Style.extraSmall,
                                        fontWeight: FontWeight.w700,
                                        fontSize: 12.rSp,
                                      ),
                                      const Spacer(),
                                      DropdownButton(
                                        value: homeCubit.selectedValue,
                                        items: homeCubit.exerciseValue,
                                        onChanged: (value) {
                                          homeCubit.pickExercise();
                                          homeCubit.selectedValue = value!;
                                          debugPrintFullText(
                                              'second  value  is =$value');
                                          debugPrintFullText(
                                              'second is =${homeCubit.selectedValue}');
                                        },
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
                                      if (exerciseEntity == null ||
                                          exerciseEntity!.exerciseVisibility ==
                                              'private')
                                        InkWell(
                                          child: SvgPicture.asset(homeCubit
                                                  .isVisibilityExerciseIcon!
                                              ? Assets
                                                  .images.svg.visibility_true
                                              : Assets
                                                  .images.svg.visibility_false),
                                          onTap: () {
                                            homeCubit.visibilityExercise();
                                          },
                                        ),
                                      if (exerciseEntity != null &&
                                          exerciseEntity!.exerciseVisibility ==
                                              'public')
                                        InkWell(
                                          child: SvgPicture.asset(homeCubit
                                                      .isVisibilityExerciseIcon ==
                                                  false
                                              ? Assets
                                                  .images.svg.visibility_false
                                              : Assets
                                                  .images.svg.visibility_true),
                                          onTap: () {
                                            homeCubit.visibilityExercise();
                                          },
                                        ),
                                    ],
                                  ),
                                  verticalSpace(6.h),
                                  if (homeCubit.exerciseVideo != null)
                                    Row(
                                      children: [
                                        const Icon(Icons.upload),
                                        horizontalSpace(5.w),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            DefaultText(
                                              title: homeCubit.exerciseVideo!
                                                  .files.first.name,
                                              //AppString.certificationSize,
                                              style: Style.extraSmall,
                                              fontSize: 12.rSp,
                                              color: Colors.blue,
                                            ),
                                            verticalSpace(1.h),
                                            DefaultText(
                                              title:
                                                  '${homeCubit.exerciseVideo!.files.first.size ~/ 1024} kB',
                                              //AppString.certificationSize,
                                              style: Style.extraSmall,
                                              fontSize: 12.rSp,
                                              color: Colors.blue,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        const Icon(
                                          Icons.check_circle_rounded,
                                          color: ColorsManager.mainColor,
                                        )
                                      ],
                                    ),
                                  verticalSpace(15.h),
                                  DefaultButton(
                                    text: AppString.done,
                                    onPressed: () {
                                      if (formKey.currentState!.validate()) {
                                        if (exerciseEntity == null) {
                                          if (homeCubit.exerciseImageFile !=
                                              null) {
                                            if (homeCubit.exerciseVideo !=
                                                null) {
                                              debugPrintFullText(
                                                  homeCubit.selectedValue);
                                              debugPrintFullText(
                                                  '${homeCubit.exerciseVideo}');
                                              debugPrintFullText(
                                                  '${homeCubit.exerciseImageFile}');
                                              debugPrintFullText(
                                                  '${homeCubit.isVisibilityExerciseIcon}');
                                              debugPrintFullText(
                                                  homeCubit.visibilityExerciseValue);
                                              homeCubit.addExercise(
                                                exerciseName:
                                                    exerciseNameController.text,
                                                exerciseCategory:
                                                    homeCubit.selectedValue,
                                                exerciseVisibility: homeCubit
                                                    .visibilityExerciseValue,
                                                exercisePic: homeCubit
                                                    .exerciseImageFile!,
                                                exerciseVideo:
                                                    homeCubit.exerciseVideo!,
                                                context: context,
                                              );
                                              showDialog(
                                                context: context,
                                                barrierDismissible: false,
                                                builder: (context) {
                                                  return StreamBuilder<double>(
                                                    stream: homeCubit.progressStream,
                                                    builder: (context, snapshot) {
                                                      return ProgressDialog(
                                                      message:
                                                          'Processing... ${(snapshot.data ?? 0).toInt()}%',
                                                    );
                                                    },
                                                  );
                                                },
                                              );
                                            } else {
                                              designToastDialog(
                                                  context: context,
                                                  toast: TOAST.warning,
                                                  text:
                                                      'please pick exercise video');
                                            }
                                          } else {
                                            designToastDialog(
                                                context: context,
                                                toast: TOAST.warning,
                                                text:
                                                    'please pick exercise photo');
                                          }
                                        } else {
                                          if (homeCubit.exerciseImageFile !=
                                                  null &&
                                              homeCubit.exerciseVideo == null) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DefaultDialog(
                                                  message:
                                                      'Are you sure to update Exerxise',
                                                  pushButtonText: 'Okay',
                                                  pushButtonVoidCallback: () {
                                                    homeCubit.updateExercise(AddExerciseParams(
                                                        context: context,
                                                        isImage: true,
                                                        exercisePic: homeCubit
                                                            .exerciseImageFile,
                                                        exerciseCategory:
                                                            homeCubit
                                                                .selectedValue,
                                                        exerciseName:
                                                            exerciseNameController
                                                                .text,
                                                        exerciseVisibility:
                                                            homeCubit
                                                                .visibilityExerciseValue,
                                                        exerciseId:
                                                            exerciseEntity!
                                                                .exerciseId,
                                                        isVideo: false));
                                                  },
                                                );
                                              },
                                            );
                                          } else if (homeCubit
                                                      .exerciseImageFile ==
                                                  null &&
                                              homeCubit.exerciseVideo != null) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DefaultDialog(
                                                  message:
                                                      'Are you sure to update Exerxise',
                                                  pushButtonText: 'Okay',
                                                  pushButtonVoidCallback: () {
                                                    homeCubit.updateExercise(
                                                        AddExerciseParams(
                                                      context: context,
                                                      isImage: false,
                                                      exerciseCategory:
                                                          homeCubit
                                                              .selectedValue,
                                                      exerciseName:
                                                          exerciseNameController
                                                              .text,
                                                      exerciseVisibility: homeCubit
                                                          .visibilityExerciseValue,
                                                      exerciseId:
                                                          exerciseEntity!
                                                              .exerciseId,
                                                      isVideo: true,
                                                      exerciseVideo: homeCubit
                                                          .exerciseVideo,
                                                    ));
                                                    showDialog(
                                                      context: context,
                                                      builder: (context) {
                                                        return BlocBuilder<
                                                            HomeCubit,
                                                            HomeStates>(
                                                          builder:
                                                              (context, state) {
                                                               return StreamBuilder<double>(
                                                                  stream: homeCubit.progressStream,
                                                                  builder: (context, snapshot) {
                                                                    return ProgressDialog(
                                                                      message:
                                                                      'Processing... ${(snapshot.data ?? 0).toInt()}%',
                                                                    );
                                                                  },
                                                                );
                                                          },
                                                        );
                                                      },
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          } else if (homeCubit
                                                      .exerciseImageFile !=
                                                  null &&
                                              homeCubit.exerciseVideo != null) {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DefaultDialog(
                                                  message:
                                                      'Are you sure to update Exerxise',
                                                  pushButtonText: 'Okay',
                                                  pushButtonVoidCallback: () {
                                                    homeCubit.updateExercise(
                                                        AddExerciseParams(
                                                      context: context,
                                                      isImage: true,
                                                      exercisePic: homeCubit
                                                          .exerciseImageFile,
                                                      exerciseCategory:
                                                          homeCubit
                                                              .selectedValue,
                                                      exerciseName:
                                                          exerciseNameController
                                                              .text,
                                                      exerciseVisibility: homeCubit
                                                          .visibilityExerciseValue,
                                                      exerciseId:
                                                          exerciseEntity!
                                                              .exerciseId,
                                                      isVideo: true,
                                                      exerciseVideo: homeCubit
                                                          .exerciseVideo,
                                                    ));
                                                  },
                                                );
                                              },
                                            );
                                          } else {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return DefaultDialog(
                                                  message:
                                                      'Are you sure to update Exerxise',
                                                  pushButtonText: 'Okay',
                                                  pushButtonVoidCallback: () {
                                                    homeCubit.updateExercise(
                                                        AddExerciseParams(
                                                      context: context,
                                                      isImage: false,
                                                      exerciseCategory:
                                                          homeCubit
                                                              .selectedValue,
                                                      exerciseName:
                                                          exerciseNameController
                                                              .text,
                                                      exerciseVisibility: homeCubit
                                                          .visibilityExerciseValue,
                                                      exerciseId:
                                                          exerciseEntity!
                                                              .exerciseId,
                                                      isVideo: false,
                                                    ));
                                                  },
                                                );
                                              },
                                            );
                                          }
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
