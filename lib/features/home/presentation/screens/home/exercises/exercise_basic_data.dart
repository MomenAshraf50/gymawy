import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/myText.dart';
import 'package:gymawy/features/home/domain/entities/add_exercise_entity.dart';
import 'package:gymawy/features/home/domain/usecase/delete_exercise_usecase.dart';
import 'package:gymawy/features/home/presentation/controller/home_states.dart';
import 'package:gymawy/features/home/presentation/screens/home/exercises/add_exercise.dart';
import 'package:video_player/video_player.dart';
import '../../../controller/home_cubit.dart';

class ExerciseBasicData extends StatelessWidget {
  ExerciseBasicData({
    Key? key,
    required this.exerciseEntity,
  }) : super(key: key);

  AddExerciseEntity exerciseEntity;



  @override
  Widget build(BuildContext context) {
    HomeCubit homeCubit = HomeCubit.get(context);
    homeCubit.initializeVideoPlayerController(video: exerciseEntity.exerciseVid);

    return BlocConsumer<HomeCubit,HomeStates>(
      listener: (context,state){
        if(state is DeleteExerciseSuccessState){
          Navigator.pop(context);
          Navigator.pop(context);
          homeCubit.getExercise();
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: Padding(
              padding: designApp,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  defaultAppBar(
                      title: exerciseEntity.exerciseName,
                      context: context,
                      actions: [
                        defaultActionButton(
                            backgroundColor: ColorsManager.mainColor,
                            icon: Icons.edit,
                            onPressed: (){
                              navigateTo(context, AddExerciseScreen(exerciseEntity: exerciseEntity,));
                            }
                        ),
                        horizontalSpace(2.w),
                        defaultActionButton(
                            backgroundColor: Colors.red,
                            icon: Icons.delete,
                            onPressed: (){
                              showDialog(context: context, builder: (context){
                                return DefaultDialog(
                                  message: 'Are you sure to delete this exercise',
                                  pushButtonText: 'Delete',
                                  pushButtonVoidCallback: (){
                                    homeCubit.deleteExercise(DeleteExerciseParams(exerciseEntity.exerciseId));
                                  },
                                );
                              });
                            }
                        )
                      ]
                  ),
                  verticalSpace(5.h),
                  SizedBox(
                    height: 40.h,
                    width: double.infinity,
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        homeCubit.videoPlayerController.value.isInitialized ? AspectRatio(
                          aspectRatio: homeCubit
                              .videoPlayerController
                              .value
                              .aspectRatio,
                          child: VideoPlayer(
                            homeCubit.videoPlayerController,
                          ),
                        )
                            : Image.network(exerciseEntity.exercisePic),
                        FloatingActionButton(
                          onPressed: () {
                            homeCubit.pauseAndPlayVideo();
                          },
                          backgroundColor: Colors.white,
                          child: Icon(
                            homeCubit
                                .videoPlayerController.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                          ),
                        )
                      ],
                    ),
                  ),
                  verticalSpace(5.h),
                  myText(
                    title: 'Exercise Category: ${exerciseEntity.exerciseCategory}',
                    style: Style.medium,
                    fontSize: 16.rSp,
                  ),
                  verticalSpace(3.h),
                  myText(
                    title: 'Exercise Added by coach: ${exerciseEntity.userName}',
                    style: Style.medium,
                    fontSize: 16.rSp,
                  ),
                  verticalSpace(3.h),
                  myText(
                    title: 'Visibility: ${exerciseEntity.exerciseVisibility}',
                    style: Style.medium,
                    fontSize: 16.rSp,
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
