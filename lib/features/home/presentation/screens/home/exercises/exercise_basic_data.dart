import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gymawy/core/util/resources/colors_manager.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default%20dialog.dart';
import 'package:gymawy/core/util/widgets/default_action_button.dart';
import 'package:gymawy/core/util/widgets/default_text.dart';
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
        return Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: designApp,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    defaultAppBar(
                        title: exerciseEntity.exerciseName,
                        context: context,

                        actions: [
                          if(exerciseEntity.makerInformation.userId == userId)
                          defaultActionButton(
                              backgroundColor: ColorsManager.mainColor,
                              icon: Icons.edit,
                              onPressed: (){
                                navigateTo(context, AddExerciseScreen(exerciseEntity: exerciseEntity,));
                              }
                          ),
                          if(exerciseEntity.makerInformation.userId == userId)
                          horizontalSpace(2.w),
                          if(exerciseEntity.makerInformation.userId == userId)
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
                          ) : Image.network(exerciseEntity.exercisePic),
                          if (homeCubit.videoPlayerController.value.isInitialized == true)
                          FloatingActionButton(
                            onPressed: () {
                              homeCubit.pauseAndPlayVideo();
                            },
                            backgroundColor: homeCubit.videoPlayerController.value.isPlaying == false ?
                            Colors.white : Colors.transparent,
                            child: homeCubit.videoPlayerController.value.isPlaying == false ?
                            const Icon( Icons.play_arrow,) : null,
                          )
                        ],
                      ),
                    ),
                    verticalSpace(5.h),
                    DefaultText(
                      title: 'Exercise Category: ${exerciseEntity.exerciseCategory}',
                      style: Style.medium,
                      fontSize: 16.rSp,
                    ),
                    verticalSpace(3.h),
                    DefaultText(
                      title: 'Exercise Added by coach: ${exerciseEntity.makerInformation.userName}',
                      style: Style.medium,
                      fontSize: 16.rSp,
                    ),
                    verticalSpace(3.h),
                    DefaultText(
                      title: 'Visibility: ${exerciseEntity.exerciseVisibility}',
                      style: Style.medium,
                      fontSize: 16.rSp,
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
